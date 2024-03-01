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
local function generic(idx) return m(idx, l._1:match("<%w+>$"), l._1:match("<%w>"), "") end
local function comma(idx) return m(idx, "%w+", ", ") end
local function lower(idx)
    return f(function(args)
        local result = string.gsub(args[1][1], "%u%l", function(match) return "_" .. string.lower(match) end)
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

-- struct & enum
local function pub(idx) return c(idx, { t(""), t("pub ") }) end
local function derive(idx)
    return c(idx, {
        fmt("#[derive(Debug{})]", { i(1) }),
        t("#[derive(Debug, Clone, Serialize, Deserialize, Validate)]"),
    })
end
local function field_type(idx) return sn(idx, { i(1, "field"), t(": "), i(2, "String"), t(",") }) end
local function struct()
    return fmta(
        [[
        #[derive(<traits><extra_traits>)]
        <pub>struct <name> {
            <pub><field_type>
        }
        ]],
        { traits = i(1, "Debug, Clone"), extra_traits = i(2), pub = pub(3), name = i(4, "Foo"), field_type = field_type(5) },
        { repeat_duplicates = true }
    )
end
local function enum()
    return fmta(
        [[
        enum <name> {
            <variant>
        }
        ]],
        { name = i(1, "Color"), variant = i(2, "Black = 1") }
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
            fn = i(2, "// TODO: implement"),
        },
        { delimiters = "[]" }
    )
end
local function impl_display()
    return fmt(
        [[
        impl[generic] std::fmt::Display for [target] {
            fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
                write!(f, "{}", self.[field])
            }
        }
        ]],
        { target = i(1, "Foo"), generic = generic(1), field = i(2, "field") },
        { delimiters = "[]" }
    )
end
local function impl_ord()
    return fmt(
        [[
        impl[generic] Ord for [target] {
            fn cmp(&self, other: &Self) -> std::cmp::Ordering {
                self.[field].cmp(&other.[field])
            }
        }
        ]],
        { target = i(1, "Foo"), generic = generic(1), field = i(2, "field") },
        { repeat_duplicates = true, delimiters = "[]" }
    )
end
local function impl_partial_ord()
    return fmt(
        [[
        impl[generic] PartialOrd for [target] {
            fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
                self.[field].partial_cmp(&other.[field])
            }
        }
        ]],
        { target = i(1, "Foo"), generic = generic(1), field = i(2, "field") },
        { repeat_duplicates = true, delimiters = "[]" }
    )
end
local function impl_default()
    return fmt(
        [[
        impl[generic] Default for [target] {
            fn default() -> Self {
                Self {
                    [fields]
                }
            }
        }
        ]],
        { target = i(1, "Foo"), generic = generic(1), fields = i(2, "..Default::default()") },
        { delimiters = "[]" }
    )
end
local function impl_deref()
    return fmt(
        [[
        impl[generic] std::ops::Deref for [target] {
            type Target = [target_type];

            fn deref(&self) -> &Self::Target {
                &self.[field]
            }
        }
        ]],
        { target = i(1, "Foo"), generic = generic(1), field = i(2, "field"), target_type = i(3, "FieldType") },
        { delimiters = "[]" }
    )
end
local function impl_deref_mut()
    return fmt(
        [[
        impl[generic] std::ops::DerefMut for [target] {
            fn deref_mut(&mut self) -> &mut Self::Target {
                &mut self.[field]
            }
        }
        ]],
        { target = i(1, "Foo"), generic = generic(1), field = i(2, "field") },
        { delimiters = "[]" }
    )
end
local function impl_from()
    return fmt(
        [[
        impl[generic] From<[source]> for [target] {
            fn from([source]: [source]) -> Self {
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
            fields = i(3, "..Default::default()"),
        },
        { delimiters = "[]" }
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
        { i(1, "Some(inner)"), i(2, "variable"), i(3, "unimplemented!();") },
        { delimiters = "[]" }
    )
end

-- tokio, gRPC, Protobuf
local function tokiomain()
    return fmt(
        [[
        #[tokio::main]
        async fn main() -> Result<(), Box<dyn std::error::Error>> {{
            {body}
        }}
        ]],
        { body = i(1, "unimplemented!();") }
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
local function tonicasync()
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
        fn test_<name>(#[case] <input>: <input_type>, #[case] expected: <expected_type>) {
            assert_eq!(expected, <method>(<input>));
        }
        ]],
        {
            name = i(1, "foo_bar"),
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
            use super::*;
            use rstest::rstest;

            <rstfn>
        }
        ]],
        {
            rstfn = rstfn(),
        },
        { repeat_duplicates = true }
    )
end

-- Axum + Mongodb
local function mongomodel()
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
    s("vec",        c(1, { t("Vec::new()"), fmt("Vec::from({})", { i(1, "iterable") }), fmt("vec![{}]", { i(1) }) })),
    s("hmap",       c(1, { t("HashMap::new()"), fmt("HashMap::from({})", { i(1, "iterable") }) })),
    s("hset",       c(1, { t("HashSet::new()"), fmt("HashSet::from({})", { i(1, "iterable") }) })),
    s("bmap",       c(1, { t("BTreeMap::new()"), fmt("BTreeMap::from({})", { i(1, "iterable") }) })),
    s("bset",       c(1, { t("BTreeSet::new()"), fmt("BTreeSet::from({})", { i(1, "iterable") }) })),
    s("bheap",      c(1, { t("BinaryHeap::new()"), fmt("BinaryHeap::from({})", { i(1, "iterable") }) })),
    s("deque",      c(1, { t("VecDeque::new()"), fmt("VecDeque::from({})", { i(1, "iterable") }) })),
    s("collect()",  c(1, { t("collect()"), fmt("collect::<{}>()", { i(1, "Type") }) })),
    s("colvec()",   fmt("collect::<Vec<{}>>()", { i(1, "_") })),
    s("colmap()",   fmt("collect::<HashMap<{}, {}>>()", { i(1, "KeyType"), i(2, "ValueType") })),
    s("colbmap()",  fmt("collect::<BTreeMap<{}, {}>>()", { i(1, "KeyType"), i(2, "ValueType") })),
    s("colset()",   fmt("collect::<HashSet<{}>>()", { i(1, "_") })),
    s("colbset()",  fmt("collect::<BTreeSet<{}>>()", { i(1, "_") })),
    s("colheap()",  fmt("collect::<BinaryHeap<{}>>()", { i(1, "_") })),
    s("coldeque()", fmt("collect::<VecDeque<{}>>()", { i(1, "_") })),

    -- derive
    s("derive",   derive(1)),
    s("derdebug", t("#[derive(Debug)]")),
    s("derserde", t("#[derive(Debug, Serialize, Deserialize)]")),
    -- attributes
    s("serde",    fmt("#[serde({})]", { i(1, "attributes") })),
    s("strum",    fmt("#[strum({})]", { i(1, "attrs") })),
    s("validate", fmt("#[validate({})]", { i(1, "validator") })),
    -- diagnostics
    s("deadcode", c(1, { t("#![allow(dead_code)]"), t("#[allow(dead_code)]") })),
    s("unused",   c(1, { t("#![allow(unused)]"), t("#[allow(unused)]") })),
    s("freedom",  c(1, { t("#![allow(dead_code, unused)]"), t("#[allow(dead_code, unused)]") })),

    -- struct & enum
    s("enum",   enum()),
    s("struct", struct()),
    s("impl",   impl()),
    s("impl_display", impl_display()),
    s("impl_ord", impl_ord()),
    s("impl_partial_ord", impl_partial_ord()),
    s("impl_default", impl_default()),
    s("impl_deref", impl_deref()),
    s("impl_deref_mut", impl_deref_mut()),
    s("impl_from", impl_from()),

    -- control flow
    s("for",      for_()),
    s("match",    match()),
    s("letmatch", letmatch()),
    s("ifelse",   ifelse()),
    s("iflet",    iflet()),

    -- test
    s("rstmod", rstmod()),
    s("rstfn",  rstfn()),

    -- tokio
    s("tokiomain",  tokiomain()), -- choice node for main function or just attribute

    -- gRPC + Protobuf snippets
    s("incl_proto", incl_proto()), -- choice node to include server/client imports
    s("tonicasync", tonicasync()),

    -- Axum + Mongodb
    s("mongomodel",         mongomodel()),
    s("crudhandlers_mongo", crudhandlers_mongo()),
}
-- stylua: ignore end
