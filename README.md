Packages folder has actual packages.

Other folder has other stuff (build scripts, manually compiled stuff, etc).

Use at your own risk. ZSH wouldn't compile, other things may not work.

Things to be aware of:
  - [![is this a built-in ftp account?](http://i.imgur.com/EgXeA9S.png)](http://i.imgur.com/EgXeA9S.png)
  - [![hey, I found an smtp account!](http://i.imgur.com/dUsFRTB.png)](http://i.imgur.com/dUsFRTB.png)
  - Root account (used for ssh) has a default password. Recommend setting openssh to disallow root logins and add one of your users to sudoers.
  - [Enable SSH on reset button](http://community.wd.com/t5/My-Book-Live/GUIDE-Reset-Button-script-that-enables-SSH/m-p/490580#M15534)
    - basically, add `echo "enabled" > /etc/nas/service_startup/ssh` to `resetButtonAction.sh`
  - [http access to Public files](http://community.wd.com/t5/My-Book-Live/http-access-to-Public-files/m-p/550893#M20054)
    - I recommend you go further and lock down the port it runs on.
  - [speed up samba file transfer](http://community.wd.com/t5/My-Book-Live/New-Release-My-Book-Live-Firmware-Version-02-32-05-044-9-5-12/m-p/465514#M13966)
    - basically, commend out `max protocol = SMB2` (put a # in front of the line) in `/etc/samba/smb-global.conf`    
