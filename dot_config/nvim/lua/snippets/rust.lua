---@diagnostic disable: unused-local, unused-function
-- NOTE: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
local ls = require("luasnip")
local types = require("luasnip.util.types")
local s = ls.snippet -- s(<trigger>, <nodes>)
local sn = ls.snippet_node
local c = ls.choice_node
local i = ls.insert_node -- i(<position>, [default_text])
local t = ls.text_node
local f = ls.function_node -- f(fn, argnode_ref, [args]) fn(argnode_txt, parent, user_args)
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt -- fmt(<fmt_string>, {...nodes})
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep -- rep(<position>)
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

-- utils
local function generic(idx) -- BUG:
    return m(idx, l._1:match("<%w+>$"), l._1:match("<%w>"), "")
end
local function lifetime_generic(idx)
    return m(idx, l._1:match("<%w+>$"), l._1:match("<'a, %w>"), "<'a>")
end
local function comma(idx)
    return m(idx, "%w+", ", ")
end
local function lower(idx)
    return f(function(args)
        local result = string.gsub(args[1][1], "%u%l", function(match)
            return "_" .. string.lower(match)
        end)
        result = string.gsub(result, "%u", string.lower)
        result = string.gsub(result, "^_", "")
        return result
    end, idx)
end
local function last_namespace(idx)
    return f(function(args)
        local tokens = vim.split(args[1][1], "::")
        return tokens[#tokens]
    end, idx)
end
local function pub(idx)
    return c(idx, { t(""), t("pub ") })
end
local function field_type(idx)
    -- TODO: fix this
    return sn(idx, { i(1, "field"), t(": "), i(2, "String"), t(",") })
end
local function std_collections(idx)
    return c(idx, {
        i(1, "std::vec"),
        i(1, "std::collections::vec_deque"),
        i(1, "std::collections::linked_list"),
        i(1, "std::collections::hash_map"),
        i(1, "std::collections::hash_set"),
        i(1, "std::collections::btree_set"),
        i(1, "std::collections::btree_map"),
        i(1, "std::collections::binary_heap"),
    })
end

-- struct, enum, impl
local function derive(idx)
    return c(idx, {
        fmt("#[derive(Debug{})]", { i(1) }),
        t("#[derive(Debug, Clone, Serialize, Deserialize, Validate)]"),
    })
end
local function struct()
    return fmta(
        [[
        <derive>
        <pub>struct <name> {
            <field>: <type>
        }
        ]],
        { derive = derive(1), pub = pub(2), name = i(3, "FooBar"), field = i(4, "foobar"), type = i(5, "u32") }
    )
end
local function enum()
    return fmta(
        [[
        <derive>
        enum <name> {
            <variant>
        }
        ]],
        { derive = derive(1), name = i(2, "Color"), variant = i(3, "Black") }
    )
end
local function impl()
    return fmt(
        [[
        impl[generic] [target] {
            [fn]
        }
        ]],
        {
            target = c(1, {
                i(nil, "Foo"), -- struct
                fmt("{} for {}", { i(1, "Trait"), i(2, "Foo") }), -- trait
            }),
            generic = generic(1),
            fn = i(0, "// TODO: implement"),
        },
        { delimiters = "[]" }
    )
end
local function impl_display()
    return fmt(
        [[
        impl[generic] std::fmt::Display for [target] {
            fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
                [body]
            }
        }
        ]],
        {
            target = i(1, "Foo"),
            generic = generic(1),
            body = c(2, {
                i(1, "todo!()"),
                fmta([[write!(f, "{}", self.<>)]], { i(1, "field") }),
            }),
        },
        { delimiters = "[]" }
    )
end
local function impl_ord()
    return fmt(
        [[
        impl[generic] Ord for [target] {
            fn cmp(&self, other: &Self) -> std::cmp::Ordering {
                [body]
            }
        }
        ]],
        {
            target = i(1, "Foo"),
            generic = generic(1),
            body = c(2, {
                fmt("self.{field}.cmp(&other.{field})", { field = i(1, "field") }, { repeat_duplicates = true }),
                i(nil, "todo!()"),
            }),
        },
        { delimiters = "[]" }
    )
end
local function impl_partial_ord()
    return fmt(
        [[
        impl[generic] PartialOrd for [target] {
            fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
                [body]
            }
        }
        ]],
        {
            target = i(1, "Foo"),
            generic = generic(1),
            body = c(2, {
                fmt("self.{field}.partial_cmp(&other.{field})", { field = i(1, "field") }, { repeat_duplicates = true }),
                i(nil, "todo!()"),
            }),
        },
        { delimiters = "[]", repeat_duplicates = true }
    )
end
local function impl_default()
    return fmt(
        [[
        impl[generic] Default for [target] {
            fn default() -> Self {
                [body]
            }
        }
        ]],
        {
            target = i(1, "Foo"),
            generic = generic(1),
            body = c(2, {
                i(nil, "todo!()"),
                fmta("Self { <> }", { i(1, "..Default::default()") }),
            }),
        },
        { delimiters = "[]" }
    )
end
local function impl_as_ref()
    return fmt(
        [[
        impl[generic] AsRef<[target_type]> for [target] {
            fn as_ref(&self) -> &[target_type] {
                [as_ref_body]
            }
        }

        impl[generic] AsMut<[target_type]> for [target] {
            fn as_mut(&mut self) -> &mut [target_type] {
                [as_mut_body]
            }
        }
        ]],
        {
            target = i(1, "Foo"),
            generic = generic(1),
            target_type = i(2, "TargetType"),
            as_ref_body = c(3, {
                i(nil, "todo!()"),
                fmt("&self.{}", { i(1, "field") }),
            }),
            as_mut_body = c(4, {
                i(nil, "todo!()"),
                fmt("&mut self.{}", { i(1, "field") }),
            }),
        },
        { delimiters = "[]", repeat_duplicates = true }
    )
end
local function impl_deref()
    return fmt(
        [[
        impl[generic] std::ops::Deref for [target] {
            type Target = [target_type];

            fn deref(&self) -> &Self::Target {
                [deref_body]
            }
        }

        impl[generic] std::ops::DerefMut for [target] {
            fn deref_mut(&mut self) -> &mut Self::Target {
                [deref_mut_body]
            }
        }
        ]],
        {
            target = i(1, "Foo"),
            generic = generic(1),
            target_type = i(2, "TargetType"),
            deref_body = c(3, {
                i(nil, "todo!()"),
                fmt("&self.{}", { i(1, "field") }),
            }),
            deref_mut_body = c(4, {
                i(nil, "body"),
                fmt("&mut self.{}", { i(1, "field") }),
            }),
        },
        { delimiters = "[]", repeat_duplicates = true }
    )
end
local function impl_into_iter()
    return fmt(
        [[
        impl[generic] IntoIterator for [target] {
            type Item = [item_type];
            type IntoIter = [collections]::IntoIter<Self::Item>;

            fn into_iter(self) -> Self::IntoIter {
                [into_iter_body]
            }
        }

        impl[lifetime_generic] IntoIterator for &'a [target] {
            type Item = &'a [item_type];
            type IntoIter = [collections]::Iter<'a, Self::Item>;

            fn into_iter(self) -> Self::IntoIter {
                [iter_body]
            }
        }
        
        impl[lifetime_generic] IntoIterator for &'a mut [target] {
            type Item = &'a mut [item_type];
            type IntoIter = [collections]::IterMut<'a, Self::Item>;

            fn into_iter(self) -> Self::IntoIter {
                [iter_mut_body]
            }
        }

        ]],
        {
            target = i(1, "Foo"),
            generic = generic(1),
            lifetime_generic = lifetime_generic(1),
            item_type = i(2, "ItemType"),
            collections = c(3, {
                i(nil, "std::vec"),
                i(nil, "std::slice"),
                i(nil, "std::collections::vec_deque"),
                i(nil, "std::collections::linked_list"),
                i(nil, "std::collections::hash_map"),
                i(nil, "std::collections::hash_set"),
                i(nil, "std::collections::btree_set"),
                i(nil, "std::collections::btree_map"),
                i(nil, "std::collections::binary_heap"),
            }),
            into_iter_body = c(3, {
                i(nil, "todo!()"),
                i(nil, "self.0.into_iter()"),
            }),
            iter_body = c(4, {
                i(nil, "todo!()"),
                i(nil, "self.0.iter()"),
            }),
            iter_mut_body = c(5, {
                i(nil, "todo!()"),
                i(nil, "self.0.iter_mut()"),
            }),
        },
        { delimiters = "[]", repeat_duplicates = true }
    )
end
local function impl_from()
    return fmt(
        [[
        impl[generic] From<[source]> for [target] {
            fn from([source_var]: [source]) -> Self {
                Self {
                    [fields]
                }
            }
        }
        ]],
        {
            target = i(1, "Foo"),
            generic = generic(1),
            source = i(2, "SourceType"),
            source_var = i(3, "other"),
            fields = i(4, "..Default::default()"),
        },
        { delimiters = "[]", repeat_duplicates = true }
    )
end

-- control flow
local function match()
    return fmt(
        [[
        match [] {
            [] => [],
            [] => [],
        }
        ]],
        {
            i(1, "statement"),
            c(2, { fmt("Some({})", { i(1, "value") }), fmt("Ok({})", { i(1, "result") }) }),
            i(3, "expr"),
            c(4, { t("None"), fmt("Err({})", i(1, "error")) }),
            i(5, "expr"),
        },
        { delimiters = "[]" }
    )
end
local function letmatch()
    return fmt(
        [[
        let [] = match [] {
            [] => [],
            [] => [],
        };
        ]],
        {
            i(1, "variable"),
            i(2, "statement"),
            c(3, { fmt("Some({})", { i(1, "value") }), fmt("Ok({})", { i(1, "result") }) }),
            i(4, "expr"),
            c(5, { t("None"), fmt("Err({})", i(1, "error")) }),
            i(6, "expr"),
        },
        { delimiters = "[]" }
    )
end
local function for_()
    return fmt(
        [[
        for [] in [] {
            []
        }
        ]],
        { i(1, "item"), i(2, "iterable"), i(3, "unimplemented!();") },
        { delimiters = "[]" }
    )
end
local function ifelse()
    return fmt(
        [[
        if [] {
            []
        } else {
            []
        }
        ]],
        { i(1, "condition"), i(2, "unimplemented!();"), i(3, "unimplemented!();") },
        { delimiters = "[]" }
    )
end
local function iflet()
    return fmt(
        [[
        if let [] = [] {
            []
        };
        ]],
        { i(1, "Some(inner)"), i(2, "variable"), i(3, "todo!();") },
        { delimiters = "[]" }
    )
end
local function ifletelse()
    return fmt(
        [[
        if let [] = [] {
            []
        } else {
            []
        }
        ]],
        { i(1, "Some(inner)"), i(2, "variable"), i(3, "todo!();"), i(4, "todo!();") },
        { delimiters = "[]" }
    )
end

-- other useful snippets
local function box_dyn_error(idx)
    return c(idx, {
        t("Box<dyn std::error::Error>"),
        t("Box<dyn Error>"),
    })
end
local function result_box_dyn_error(idx)
    return c(idx, {
        fmt("Result<{}, Box<dyn std::error::Error>>", { i(1, "()") }),
        fmt("Result<{}, Box<dyn Error>>", { i(1, "()") }),
    })
end

-- tokio, gRPC, Protobuf
local function tokio_main()
    return fmt(
        [[
        #[tokio::main]
        async fn main() -> Result<(), Box<dyn std::error::Error>> {{
            {body}
        }}
        ]],
        { body = i(1, "todo!();") }
    )
end
local function incl_proto()
    return fmt(
        [[
        pub mod {package} {{
            tonic::include_proto!("{package}");
        }}
        ]],
        { package = i(1, "package_name") },
        { repeat_duplicates = true }
    )
end
local function tonic_async()
    return fmt(
        [[
        #[tonic::async_trait]
        impl {svc_path} for {svc_name}Server {{
            async fn {svc_method}(&self, request: tonic::Request<{svc_name}Request>)
            -> Result<tonic::Response<{svc_name}Response>, tonic::Status> {{
                {implementation}
            }}
        }}
        ]],
        {
            svc_path = i(1, "path::to::Service"),
            svc_method = i(2, "rpc_method"),
            implementation = i(3, "unimplemented!();"),
            svc_name = last_namespace(1),
        },
        { repeat_duplicates = true }
    )
end

-- rstest
local function rstfn()
    return fmta(
        [[
        #[rstest]
        #[case(<input_val>, <expected_val>)]
        fn <test_name>(#[case] <input>: <input_type>, #[case] expected: <expected_type>) {
            assert_eq!(expected, <method>(<input>));
        }
        ]],
        {
            test_name = i(1, "foo_bar"),
            input_val = i(2, "???"),
            expected_val = i(3, "???"),
            input = i(4, "input"),
            input_type = i(5, "Type"),
            expected_type = i(6, "Type"),
            method = i(7, "method"),
        },
        { repeat_duplicates = true }
    )
end
local function rstmod()
    return fmta(
        [[
        mod test {
            use rstest::rstest;

            use super::*;

            <rstfn>
        }
        ]],
        {
            rstfn = rstfn(),
        }
    )
end

-- Axum + Mongodb
local function mongo_model()
    return fmt(
        [=[
        use bson::oid::ObjectId;
        use bson::serde_helpers::{ bson_datetime_as_rfc3339_string, serialize_object_id_as_hex_string };
        use serde::{Deserialize, Serialize};
        use validator::Validate;

        use crate::utils::{date, date::Date, model::Model};

        #[[derive(Debug, Clone, Serialize, Deserialize, Validate)]]
        pub struct [model_name] {
            #[[serde(rename = "_id", skip_serializing_if = "Option::is_none")]]
            pub id: Option<ObjectId>,
            pub [field]: [type],
            pub created_at: Date,
            pub updated_at: Date,
        }

        impl [model_name] {
            fn new() -> Self {
                unimplemented!();
            }
        }

        #[[derive(Debug, Serialize, Deserialize, Validate)]]
        pub struct Public[model_name] {
            #[[serde(alias = "_id", serialize_with = "serialize_object_id_as_hex_string")]]
            pub id: ObjectId,
            pub [field]: [type],
            #[[serde(with = "bson_datetime_as_rfc3339_string")]]
            pub created_at: Date,
            #[[serde(with = "bson_datetime_as_rfc3339_string")]]
            pub updated_at: Date,
        }

        impl From<[model_name]> for Public[model_name] {
            fn from([lower_model_name]: [model_name]) -> Self {
                unimplemented!();
            }
        }
        ]=],
        {
            model_name = i(1, "ModelName"),
            field = i(2, "field"),
            type = i(3, "String"),
            lower_model_name = lower(1),
        },
        { delimiters = "[]", repeat_duplicates = true }
    )
end
local function crudhandlers_mongo()
    return fmt(
        [=[
        use axum::{
            extract::{Path, Query},
            http::StatusCode,
            routing::{delete, get, post, put},
            Router,
        };
        use bson::doc;
        use futures::TryStreamExt;
        use mongodb::options::{FindOneAndUpdateOptions, FindOptions, ReturnDocument};
        use serde::{Deserialize, Serialize};
        use tracing::debug;

        use crate::errors::Error;
        use crate::models::[lower_model_name]::{[model_name], Public[model_name]};
        use crate::utils::{
            json::Json,
            model::Model,
            pagination:: Pagination,
            query::Sort,
            response::Response, 
            date,
            to_object_id
        };

        pub fn routes() -> Router {
            Router::new()
        }

        #[[derive(Debug, Serialize, Deserialize, Validate)]]
        struct RequestBody {
            field: String
        }

        #[[derive(Debug, Deserialize, Validate)]]
        struct RequestQuery {
            field: String,
        }

        async fn query_[lower_model_name](pagination: Pagination, Query(query): Query<RequestParam>)
        -> Result<Response<Vec<Public[model_name]>>, Error> {
            unimplemented!();
        }

        async fn get_[lower_model_name]_by_id(Path(id): Path<String>)
        -> Result<Response<Public[model_name]>, Error> {
            unimplemented!();
        }

        async fn create_[lower_model_name](Json(body): Json<RequestBody>)
        -> Result<Response<Public[model_name]>, Error> {
            unimplemented!();
        }

        async fn update_[lower_model_name]_by_id(Path(id): Path<String>, Json(body): Json<RequestBody>)
        -> Result<Response<Public[model_name]>, Error> {
            unimplemented!();
        }

        async fn delete_[lower_model_name]_by_id(Path(id): Path<String>)
        -> Result<Response<()>, Error> {
            unimplemented!();
        }
        ]=],
        {
            model_name = i(1, "ModelName"),
            lower_model_name = lower(1),
        },
        { delimiters = "[]", repeat_duplicates = true }
    )
end

-- stylua: ignore start
return {
    -- rust_analyzer provided snippets:
    -- tmod: test module,
    -- tfn: test fn

    -- abbrs
    s(":turbofish", fmt("::<{}>", { i(1, "Type") })),
    s("clo",        fmta("|<>| {<>}", { i(1, "args"), i(2, "body") })),

    -- collections
    s("vec",        c(1, { t("Vec::new()"),        fmt("Vec::from({})",        { i(1, "iterable") }),   fmt("vec![{}]", { i(1) }) })),
    s("hmap",       c(1, { t("HashMap::new()"),    fmt("HashMap::from({})",    { i(1, "iterable") }) })),
    s("hset",       c(1, { t("HashSet::new()"),    fmt("HashSet::from({})",    { i(1, "iterable") }) })),
    s("bmap",       c(1, { t("BTreeMap::new()"),   fmt("BTreeMap::from({})",   { i(1, "iterable") }) })),
    s("bset",       c(1, { t("BTreeSet::new()"),   fmt("BTreeSet::from({})",   { i(1, "iterable") }) })),
    s("bheap",      c(1, { t("BinaryHeap::new()"), fmt("BinaryHeap::from({})", { i(1, "iterable") }) })),
    s("deque",      c(1, { t("VecDeque::new()"),   fmt("VecDeque::from({})",   { i(1, "iterable") }) })),
    s("collect()",  c(1, { t("collect()"),         fmt("collect::<{}>()",      { i(1, "Type") }) })),
    s("colvec()",   fmt("collect::<Vec<{}>>()",          { i(1, "_") })),
    s("colmap()",   fmt("collect::<HashMap<{}, {}>>()",  { i(1, "KeyType"), i(2, "ValueType") })),
    s("colbmap()",  fmt("collect::<BTreeMap<{}, {}>>()", { i(1, "KeyType"), i(2, "ValueType") })),
    s("colset()",   fmt("collect::<HashSet<{}>>()",      { i(1, "_") })),
    s("colbset()",  fmt("collect::<BTreeSet<{}>>()",     { i(1, "_") })),
    s("colheap()",  fmt("collect::<BinaryHeap<{}>>()",   { i(1, "_") })),
    s("coldeque()", fmt("collect::<VecDeque<{}>>()",     { i(1, "_") })),

    -- attributes
    s("derive",   derive(1)),
    s("serde",    fmt("#[serde({})]",    { i(1, "attributes") })),
    s("strum",    fmt("#[strum({})]",    { i(1, "attrs") })),
    s("validate", fmt("#[validate({})]", { i(1, "validator") })),
    -- diagnostics
    s("deadcode", c(1, { t("#![allow(dead_code)]"), t("#[allow(dead_code)]") })),
    s("unused",   c(1, { t("#![allow(unused)]"), t("#[allow(unused)]") })),
    s("freedom",  c(1, { t("#![allow(dead_code, unused)]"), t("#[allow(dead_code, unused)]") })),

    -- struct & enum
    s("enum",             enum()),
    s("struct",           struct()),
    s("impl",             impl()),
    s("impl_display",     impl_display()),
    s("impl_ord",         impl_ord()),
    s("impl_partial_ord", impl_partial_ord()),
    s("impl_default",     impl_default()),
    s("impl_as_ref",      impl_as_ref()),
    s("impl_deref",       impl_deref()),
    -- s("impl_into_iter",   impl_into_iter()),   -- BUG:
    s("impl_from",        impl_from()),

    -- control flow
    s("for",       for_()),
    s("match",     match()),
    s("letmatch",  letmatch()),
    s("ifelse",    ifelse()),
    s("iflet",     iflet()),
    s("ifletelse", ifletelse()),

    -- test
    -- s("rstmod", rstmod()),
    -- s("rstfn",  rstfn()),

    -- tracing
    s("tinfo",  fmta("tracing::info!(<>)",  { i(1) })),
    s("tdebug", fmta("tracing::debug!(<>)", { i(1) })),
    s("twarn",  fmta("tracing::warn!(<>)",  { i(1) })),
    s("terror", fmta("tracing::error!(<>)", { i(1) })),

    -- tokio
    s("tokiomain",  tokio_main()), -- choice node for main function or just attribute

    -- gRPC + Protobuf snippets
    s("incl_proto", incl_proto()), -- choice node to include server/client imports
    s("tonicasync", tonic_async()),

    -- Axum + Mongodb
    s("mongomodel",         mongo_model()),
    s("crudhandlers_mongo", crudhandlers_mongo()),

    -- other
    s("use_prelude", t("use crate::prelude::*;")),
    s("stderror",    box_dyn_error(1)),
    s("reserr",      result_box_dyn_error(1)),
}
-- stylua: ignore end
