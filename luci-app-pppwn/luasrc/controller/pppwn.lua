module("luci.controller.pppwn", package.seeall)

-- 给 /etc/init.d/pppwn 赋予执行权限
local function check_and_chmod()
    local script_path = "/etc/init.d/pppwn"
    if nixio.fs.access(script_path) then
        -- 检查是否有执行权限，如果没有则赋予
        local has_exec = nixio.fs.stat(script_path).perm & 0x01
        if not has_exec then
            -- 没有执行权限，给予执行权限
            nixio.fs.chmod(script_path, 755)
        end
    end
end

function index()
    -- 检查配置文件是否存在
    if not nixio.fs.access("/etc/config/pppwn") then
        return
    end

    -- 在此处调用函数，确保权限
    check_and_chmod()

    entry({"admin", "services", "pppwn"}, alias("admin", "services", "pppwn", "general"), _("PS4 PPP PWN"), 80)
    entry({"admin", "services", "pppwn", "general"}, cbi("pppwn/settings"), _("Base Setting"), 1)
    entry({"admin", "services", "pppwn", "log"}, form("pppwn/info"), _("Log"), 2)

    entry({"admin", "services", "pppwn", "status"}, call("status")).leaf = true
end

function status()
    local e = {}
    e.running = luci.sys.call("pgrep pppwn >/dev/null") == 0
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end
