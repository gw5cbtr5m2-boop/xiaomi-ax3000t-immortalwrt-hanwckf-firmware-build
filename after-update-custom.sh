#!/bin/sh
# Description: (After Update feeds)

# Modify default IP
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# Set DHCP IP Address start and end
sed -i "s/option start.*/option start \'2\'/g" package/network/services/dnsmasq/files/dhcp.conf
sed -i "s/option limit.*/option limit \'55\'/g" package/network/services/dnsmasq/files/dhcp.conf

# ---- minimal build: only AX3000T AN8855 (112M UBI layout) ----
CONF=.config
for d in xiaomi_mi-router-ax3000t xiaomi_mi-router-ax3000t-stock xiaomi_mi-router-ax3000t-an8855-stock; do
  sed -i "s|^CONFIG_TARGET_DEVICE_mediatek_mt7981_DEVICE_${d}=y|# CONFIG_TARGET_DEVICE_mediatek_mt7981_DEVICE_${d} is not set|" "$CONF"
done

# ---- strip optional extras, keep LuCI + MTK wifi/HNAT ----
for p in luci-app-upnp luci-i18n-upnp-zh-cn miniupnpd luci-app-eqos-mtk luci-i18n-eqos-mtk-zh-cn luci-theme-argon luci-theme-bootstrap-mod htop; do
  sed -i "s|^CONFIG_PACKAGE_${p}=y|# CONFIG_PACKAGE_${p} is not set|" "$CONF"
done
