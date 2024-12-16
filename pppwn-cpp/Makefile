include $(TOPDIR)/rules.mk

PKG_NAME:=pppwn-cpp
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/xfangfang/PPPwn_cpp.git
PKG_SOURCE_VERSION:=abb5159737c92602f7f6aa5b99255b4a36258f72
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz

PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/pppwn-cpp
  SECTION:=net
  CATEGORY:=Network
  TITLE:=C++ rewrite of PPPwn (PlayStation 4 PPPoE RCE)
  URL:=https://github.com/xfangfang/PPPwn_cpp
  DEPENDS:=+libpcap +libstdcpp
endef

define Package/pppwn-cpp/description
  PPPwn is a kernel remote code execution exploit for PlayStation 4 up to
  FW 11.00. This is a proof-of-concept exploit for CVE-2006-4304 that was
  reported responsibly to PlayStation.
endef

CMAKE_OPTIONS += -DUSE_SYSTEM_PCAPPLUSPLUS=OFF

define Package/pppwn-cpp/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/pppwn
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/pppwn $(1)/usr/bin/pppwn
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/files/* $(1)/etc/pppwn/
	$(INSTALL_DIR) $(1)/www
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/www/goldhen.bin $(1)/www/goldhen.bin
endef

$(eval $(call BuildPackage,pppwn-cpp))
