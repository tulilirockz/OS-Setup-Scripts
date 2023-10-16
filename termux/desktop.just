vnc:
    pkg install -y x11-repo
    pkg install -y tigervnc

xfce:
    pkg install xfce4
    echo -e "#!/data/data/com.termux/files/usr/bin/sh\nxfce4-session &" | tee $HOME/.vnc/xstartup

setup-vnc:
    vncserver -localhost
    killall -9 vncserver
