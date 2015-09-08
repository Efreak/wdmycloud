Packages generated for western digital mycloud NAS using [the official build tools](http://support.wdc.com/product/download.asp?groupid=904&sid=233&lang=en).

Working for me--`dpkg -i $deb` works, and `$cmd` works. Not checked for good behavior or more than basic/primary functions.
- tmux
- htop
- screen - mlocate commands run in screen session
- mlocate - `updatedb && locate mlocate`. Installs a script to /etc/cron.daily/mlocate.
- most - pager with *more* features than *less*
- tree

Would not compile using build script
- zsh
- git
- g++
- schroot
- php-fpm
- ffmpeg
- libavtools
- rootstrap
- git-extras
- lolcat
- figlet
- aria2 (A2STR.cc:65:1: internal compiler error: Segmentation fault)

Would not install
- byobu (requires python-newt, tbd)

Unchecked
- nano (same version as built-in)
- dnsmasq (will test later)
- dos2unix
- make (no compilers...)
- toilet (`echo G|toilet` for a swirly)
- ttyrec
- uml-utilities (I have vague ideas of getting this working, not sure if I'll ever do so)
