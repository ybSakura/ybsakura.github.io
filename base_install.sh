#!/usr/bin/zsh
echo "清空所有软件源码"
truncate -s 0 /etc/pacman.d/mirrorlist

echo "添加Archlinux清华源&UTC源"
cat>>/etc/pacman.d/mirrorlist<<EOF
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/\$repo/os/\$arch
Server = https://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch
EOF

echo "添加Archlinuxcn清华源"
cat >>/etc/pacman.conf<<EOF

#清华archlinuxcn
[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch
EOF

echo "安装GPG key"
pacman -S archlinuxcn-keyring

echo "更新Archlinux源"
pacman -Syyu
echo "安装yay"
pacman -S yay
echo "安装基础工具"
yay -S xorg wayland net-tools networkmanager  firefox firefox-i18n-zh-cn google-chrome  git  base-devel
echo "安装amd驱动"
yay -S vulkan-radeon opencl-mesa mesa amdvlk xf86-video-amdgpu amd-ucode
echo "开机启动网络管理程序"
systemctl enable NetworkManager
echo "安装Kde(最小)桌面"
yay -S plasma konsole ark dolphin  plasma-wayland-session  sddm  sddm-kcm kdeconnect packagekit-qt5
echo "开机启动sddm"
systemctl enable sddm

echo "安装fcitx5输入法"
yay -S fcitx5-im fcitx5-chinese-addons fcitx5-rime fcitx5-chewing fcitx5-qt fcitx5-gtk

echo "安装fcitx5词库"
yay -S fcitx5-pinyin-zhwiki fcitx5-pinyin-moegirl

echo "配置fcitx5环境变量"
cat>>/etc/environment<<EOF
GTK_IM_MODULE DEFAULT=fcitx
QT_IM_MODULE  DEFAULT=fcitx
XMODIFIERS    DEFAULT=\@im=fcitx
SDL_IM_MODULE DEFAULT=fcitx
EOF
echo "安装cjk字体"
yay - S noto-fonts-cjk adobe-source-han-sans-otc-fonts noto-fonts-emoji
#所有配置已完成
