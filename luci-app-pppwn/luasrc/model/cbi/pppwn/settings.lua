local sys = require "luci.sys"

m = Map("pppwn", "PPPwn - PlayStation 4 PPPoE RCE", translate("PPPwn is a kernel remote code execution exploit for PlayStation 4 up to FW 11.00."))

m:section(SimpleSection).template  = "pppwn/pppwn_status"

s = m:section(TypedSection, "pppwn")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("Enabled"))
enable.rmempty = false

-- 设置启用/禁用功能
function enable.write(self, section, value)
    Flag.write(self, section, value)
    local uci = require "luci.model.uci".cursor()
    uci:commit("pppwn") -- 立即提交配置更改

    if value == "1" then
        -- 启动 PPPwn
        luci.sys.call("/etc/init.d/pppwn start")
    else
        -- 停止 PPPwn
        luci.sys.call("/etc/init.d/pppwn stop")
    end
end

source = s:option(Value, "source", translate("PPPwn Running Port"))
source.datatype = "network"
source.default = "br-lan"
source.rmempty = false
for _, e in ipairs(sys.net.devices()) do
    if e ~= "lo" then source:value(e) end
end

fwver = s:option(Value, "fwver", translate("PlayStation 4 System Version"))
fwver.default = "1100"
fwver.rmempty = false
fwver:value("700", translate("7.00"))
fwver:value("900", translate("9.00"))
fwver:value("1100", translate("11.00"))
fwver.description = translate("1100 means Ver 11.00 etc.")

goldhen = s:option(DummyValue, "goldhen", translate("Download GoldHEN Payload BIN"))
goldhen.description = translate("<a class='btn cbi-button cbi-button-apply' type='button' href=\"../../../../goldhen.bin\" target=\"_blank\" />"..translate("Copy goldhen.bin to the root directory of an exfat/fat32 USB and insert it into your PS4").."</a>")

-- 强制在“保存并应用”时立即启停服务
function m.apply(self)
    local uci = require "luci.model.uci".cursor()
    local enabled = uci:get("pppwn", "pppwn", "enable")

    if enabled == "1" then
        luci.sys.call("/etc/init.d/pppwn start")
        luci.sys.call("logger -t PPPwn 'Service started after apply'")
    else
        luci.sys.call("/etc/init.d/pppwn stop")
        luci.sys.call("logger -t PPPwn 'Service stopped after apply'")
    end
end

return m
