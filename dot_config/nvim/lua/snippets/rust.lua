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

---newline text_node
---@param text string|nil text to insert before the newline
local N = function(text) return t({ text and text or "", "" }) end

---user_args for function_node
---@param prefix string|nil
---@param suffix string|nil
---@return string[]
local ua = function(prefix, suffix) return { user_args = { { prefix and prefix or "", suffix and suffix or "" } } } end

---callback fn for function_node
---@param nodes string[] texts from reference nodes
---@param parent any immediate parent of function_node
---@param uargs string[] strings to prepend and append in order
---@return string
local to_lower = function(nodes, parent, uargs)
    if uargs == nil then
        return #nodes > 0 and string.lower(nodes[1][1]) or ""
    end
    local prefix = #uargs > 0 and uargs[1] and uargs[1] or ""
    local suffix = #uargs > 1 and uargs[2] and uargs[2] or ""
    return #nodes > 0 and prefix .. string.lower(nodes[1][1]) .. suffix or ""
end

---callback fn for function_node
---comment
---@param args string[]
---@return string
local generic = function(args)
    local match = string.match(args[1][1], "<.*>")
    return match and match or ""
end

---callback fn for function_node
---@param nodes string[] texts from reference nodes
---@param parent any immediate parent of function_node
---@param uargs string[] strings to prepend and append in order
---@return string
local var = function(nodes, parent, uargs)
    if uargs == nil then
        return #nodes > 0 and nodes[1][1] or ""
    end
    local prefix = #uargs > 0 and uargs[1] or ""
    local suffix = #uargs > 1 and uargs[2] or ""
    return #nodes > 0 and prefix .. nodes[1][1] .. suffix or ""
end

---sensible wrapper around function_node for prettier formatting
---@param prefix string|nil String to prepend to te ref_node's value
---@param callback function callback function called by function_node
---@param ref_node integer indices of nodes to reference
---@param suffix string|nil String to append to the ref_node's value
---@return unknown
local F = function(prefix, callback, ref_node, suffix) return f(callback, ref_node, ua(prefix, suffix)) end

---convenient insert node with text nodes as prefix and suffix
---@param prefix string|nil
---@param index integer
---@param suffix string|nil
---@param extra integer|nil
---@return unknown
local I = function(prefix, index, suffix, extra)
    local nodes = { t(prefix and prefix or ""), i(1), t(suffix and suffix or nil) }
    if extra ~= nil then
        table.insert(nodes, i(2))
    end
    return sn(index, nodes)
end

-- stylua: ignore
return {
    -- rust_analyzer provided snippets: tmod, tfn
    s("todo",         t("// TODO: ")),
    s("derive",       I("#[derive(",1,")]")),
    s("derdebug",     t("#[derive(Debug)]")),
    s("derserde",     t("#[derive(Debug, Serialize, Deserialize)]")),
    s("serde",        I("#[serde(",1,")]")),
    s("validate",     I("#[validate(",1,")]")),
    s("deadcode",     t("#[allow(dead_code)]")),
    s("allowfreedom", t("#[allow(unused_variables, dead_code)]")),
    s(":turbofish",   I("::<",1,">")),

    -- rust-analyzer override
    -- s("println!",  { t('println!("'), f(var, {1}, ua(nil,": ")), t('= {:?}", '), i(1), t(");"), i(0) }),
    -- s("pprintln!", { t('println!("'), f(var, {1}, ua(nil,": ")), t('= {:#?}", '), i(1), t(");"), i(0) }),
    -- s("assert!",    I("assert!(",1,");")),
    -- s("assert_eq!", I("assert_eq!(",1,");")),
    -- s("assert_ne!", I("assert_ne!(",1,");")),

    -- struct, enum, impl, trait
    s("struct", {
        N("#[derive(Debug)]"),
        I("struct ", 1, " {"), N(),
        I("    ",2), N(),
        N("}"),
    }),
    s("enum", {
        I("enum ", 1, " {"), N(),
        I("    ", 2), N(),
        N("}")
    }),
    s("impl", {
        t("impl"), f(generic, {1}), t({" "}), i(1), N(" {"),
        I("    ", 2), N(),
        N("}"),
    }),
    -- s("implfrom", {
    --     t("impl From<"), i(1), I("> for ", 2, " {"), N(),
    --     I("    fn from(",3,": "), f(var, {1}), N(") -> Self {"),
    --     I("        ", 4), N(),
    --     N("    }"),
    --     N("}")
    -- }),
    -- impl default
    -- impl display

    -- control flow
    s("for", {
        I("for ",1," in "), i(2), N(" {"),
        I( "    ",3), N(),
        N("}")
    }),
    s("ifelse", {
        I("if ",1), N(" {"),
        I("    ",2), N(),
        t("} else {" ), N(),
        I("    ",3), N(),
        N("}")
    }),
    s("iflet", {
        I("if let ",1," = ",1), N(" {"),
        I("    ",2), N(),
        N("};")
    }),
    s("match", {
        I("match ",1), N(" {"),
        I("    ",2," => ",2), N(","),
        I("    ",3," => ",3), N(","),
        N("}")
    }),
    s("letmatch", {
        I( "let ",1," = match ",1), N(" {"),
        I( "    ",2," => ",2), N(","),
        I( "    ",3," => ",3), N(","),
        N( "};")
    }),

    -- FIX: bug here
    -- axum, mongodb model
    s("model", {
        t("use bson::oid::ObjectId;"), N(),
        t("use bson::serde_helpers::bson_datetime_as_rfc3339_string;"), N(),
        t("use bson::serde_helpers::serialize_object_id_as_hex_string;"), N(),
        t("use serde::{Deserialize, Serialize};"), N(),
        t("use validator::Validate;"), N(),
        N(),
        t("use crate::utils::{date, date::Date };"), N(),
        N(),
        t("#[derive(Debug, Clone, Serialize, Deserialize, Validate)]"), N(),
        t("pub struct "), i(1, "ModelName"), N(" {"),
        t('    #[serde(rename = "_id", skip_serializing_if = "Option::is_none")]'), N(),
        t("    pub id: Option<ObjectId>,"), N(),
        I("    ",2), N(),
        t("    pub created_at: Date,"), N(),
        t("    pub updated_at: Date,"), N(),
        N("}"),
        N(),
        F("impl ",var,1), N(" {"),
        t("    pub fn new() -> Self {"), N(),
        t("        todo!();"), N(),
        N("    }"),
        N("}"),
        N(),
        t("#[derive(Debug, Serialize, Deserialize)]"), N(),
        F("pub struct Public",var,1), N(" {"),
        t('    #[serde(alias = "_id", serialize_with = "serialize_object_id_as_hex_string")]'), N(),
        t("    pub id: ObjectId,"), N(),
        F("    ",var,2), N(),
        t('    #[serde(with = "bson_datetime_as_rfc3339_string")]'), N(),
        t("    pub created_at: Date,"), N(),
        t('    #[serde(with = "bson_datetime_as_rfc3339_string")]'), N(),
        t("    pub updated_at: Date,"), N(),
        N( "}"),
        N(),
        F("impl From<",var,1), F("> for Public",var,1), N(" {"),
        F("    fn from(",to_lower,1,": "), f(var, {1}), N( ") -> Self {" ),
        t("        todo!();"), N(),
        N("    }"),
        N("}"),
    }),

    s("routes", {
        N("use axum::http::StatusCode;"),
        N("use axum::{extract::{Path, Query}, routing::{get, post, put, delete}, Json, Router};"),
        N("use bson::doc;"),
        N("use futures::TryStreamExt;"),
        N("use serde::{Deserialize, Serialize};"),
        N("use tracing::debug;"),
        N(),
        N("use crate::database::CONNECTION;"),
        N("use crate::errors::Error;"),
        F("use crate::models::",to_lower,1,"::{"), i(1, "..."), F(", Public",var,1), N("};"),
        N("use crate::utils::response::{Response, ResponseBuilder};"),
        N("use crate::utils::to_object_id;"),
        N(),
        t("pub fn routes() -> Router"), N(" {"),
        t("    todo!();"), N(),
        t("}"), N(),
        N(),
        F("async fn create_",to_lower,1), t("(Json(payload): Json<Payload>"), F(">) -> Result<Response<Public",var,1,">, Error> {"), N(),
        t("    todo!();"), N(),
        t("}"), N(),
        N(),
        F("async fn update_",to_lower,1), t("_by_id(Path(id): Path<String>, Json(payload): Json<Payload>"), F(">) -> Result<Json<Public",var,1,">, Error> {"), N(),
        t("    todo!();"), N(),
        t("}"), N(),
        N(),
        F("async fn delete_",to_lower,1), t("_by_id(Path(id): Path<String>) -> Result<Response<()>, Error> {"), N(),
        t("    todo!();"), N(),
        t("}"), N(),
        N(),
        F("async fn get_",to_lower,1), F("_by_id(Path(id): Path<String>) -> Result<Json<Public",var,1,">, Error> {"), N(),
        t("    todo!();"), N(),
        t("}"), N(),
        N(),
        F("async fn query_",to_lower,1), F("(Query(query): Query<String>) -> Result<Json<Vec<Public",var,1,">>, Error> {"), N(),
        t("    todo!();"), N(),
        t("}"), N(),
        N(),
        N("#[derive(Serialize, Deserialize)]"),
        t("struct Payload {}"), N(),
   })
}
