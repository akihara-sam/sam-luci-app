module("luci.controller.eqosplus", package.seeall)
-- Copyright 2022-2023 sirpdboy <herboy2008@gmail.com>

function index()
    if not nixio.fs.access("/etc/config/eqosplus") then return end

    -- 将 eqosplus 菜单项添加到 network 菜单下，确保它位于网络菜单下的指定位置
    local e = entry({"admin", "network", "eqosplus"}, cbi("eqosplus"), _("Eqosplus"), 40)
    e.dependent = false
    e.acl_depends = { "luci-app-eqosplus" }

    -- 添加一个状态页菜单项，位于 eqosplus 菜单下
    entry({"admin", "network", "eqosplus", "status"}, call("act_status")).leaf = true
end

function act_status()
    local sys  = require "luci.sys"
    local e = {} 
    e.status = sys.call(" busybox ps -w | grep eqosplus | grep -v grep  >/dev/null ") == 0  
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end

