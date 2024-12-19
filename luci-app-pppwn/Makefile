# Copyright (C) 2022 Openwrt.org
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI support for PPPWN
LUCI_DEPENDS:=+pppwn-cpp
LUCI_PKGARCH:=all
PKG_NAME:=luci-app-pppwn
PKG_VERSION:=1
PKG_RELEASE:=2

include $(TOPDIR)/feeds/luci/luci.mk

# 只给 pppwn 脚本赋予执行权限
define Package/luci-app-pppwn/install
	chmod 0755 $(1)/etc/init.d/pppwn
endef

$(eval $(call BuildPackage,luci-app-pppwn))

# call BuildPackage - OpenWrt buildroot signature
