Packages generated for western digital mycloud NAS using [the official build tools](http://support.wdc.com/product/download.asp?groupid=904&sid=233&lang=en).

Working for me--`dpkg -i $deb` works, and `$cmd` works. Not checked for good behavior or more than basic/primary functions.
- tmux
- htop
- screen - mlocate commands run in screen session
- mlocate - `updatedb && locate mlocate`. Installs a script to /etc/cron.daily/mlocate.
- most - pager with *more* features than *less*
- tree
- cowsay

Would not compile using build script
- zsh - I hate you
- git - I really hate you
- g++ - I really, REALLY hate you.
- schroot - `GC Warning: Out of Memory!  Returning NIL!` spams console
- php-fpm
- ffmpeg - :cry:
- libavtools :sob:
- rootstrap
- git-extras
- lolcat
- figlet - toilet worked. Why not figlet?
- aria2 - `A2STR.cc:65:1: internal compiler error: Segmentation fault`
- busybox - somewhat annoying
- openjdk-7-jre-headless - same error as schroot
  - only really needed for bubbleupnp, but I *really* want bubbleupnp--transcoding is good if I can get it, but I really like the android app.
  - will try a different jre. Options? [jrecreate](https://docs.oracle.com/javase/8/embedded/develop-apps-platforms/jrecreate.htm), jamvm, hotspot (hotspot zero should work if nothing else does)
- dchroot - tries to build schroot, see above
- proot
- fakechroot
- fakeroot-ng - but fakeroot builds? odd.
- fish

I'm not *quite* sure that all of the following actually tried to build; for example there shouldn't have been any problems with a keyring...All of these were in my old build script (I'm switching to the build- packages script), and it built several packages that came after them.
- apt - is this even the correct package name? I've never had to install a package manager before, everything comes with apt-get, aptitude, and synaptic...
- bcrypt
- coreutils - if coreutils and busybox won't compile for a given platform, how do you set up a minimal system for it?
- ctorrent
- dialog
- elinks
- gnupg
- gpgv
- perl
- php-fpm - why did I add this? I only use this with nginx...
- qbittorrent-nox - boo
- rhash
- rtorrent - boo again
- socat
- ubuntu-cloud-keyring - why not? This should be multiplatform, shouldn't it?
- vde2 - was hoping to play with UML. Guess not.
- vlc-nox
- w3m
- x264 - I'm quite sure I added this because I plan on converting blurays on my NAS.
- xbmc-addons-dev
- xbmc - not that I expect this or vlc to actually run. Not sure why I added these.
- plowshare4 - boo. Good for downloading stuff.
- elinks - odd, links and links2 compiled. I don't like elinks anyways, tho, so idc.
- lynx
- libav-tools - I may have spelled it wrong? I thought it was libav-tool

Would not install :sob:
- byobu - requires python-newt, tbd
- dnsmasq - depends on libnetfilter-conntrack3
- toilet - `echo G|toilet` for a swirly. enjoy
  - need deps (libcaca0)
- transmission-daemon
  - depends on libcurl3-gnutls, libminiupnpc5, libnatpmp1

Unchecked debs
- nano - same version as built-in
- make - no compilers...
- uml-utilities - I have vague ideas of getting this working, not sure if I'll ever do so

Other notes

1. Multiple packages, inluding coreinfo hang at "checking whether printf survives out-of-memory conditions...". I can't find any information on this online. If you kill the process (open htop, hit t for tree view, select the last child and hit k), it results in this check returning 'no' and continues building. Hopefully this doesn't have any evil effects.
2. The issue with schroot (`GC Warning: Out of Memory!  Returning NIL!` spam) occurs with multiple different packages. Maybe due to the limited memory of virtual system? Or limited ram of VPS, but I have 1.5gb swap...
