#!/bin/sh
cat >/etc/motd <<EOL
  _____
  /  _  \ __________ _________   ____
 /  /_\  \\___   /  |  \_  __ \_/ __ \
/    |    \/    /|  |  /|  | \/\  ___/
\____|__  /_____ \____/ |__|    \___  >
        \/      \/                  \/
A P P   S E R V I C E   O N   L I N U X
Documentation: http://aka.ms/webapp-linux
Golang quickstart: https://aka.ms/golang-qs
EOL
cat /etc/motd

/etc/init.d/sshd start

# Get environment variables to show up in SSH session
eval $(printenv | awk -F= '{print "export " $1"="$2 }' >> /etc/profile)

executable=$(find -type f -executable -exec sh -c "file -i '{}' | grep -q 'x-executable; charset=binary'" \; -print -quit)
if [ -n "$executable" ]; then
    echo Found binary $executable. Running it...
    $executable
else
    echo Could not find any binary. Using default static website.
    cd /defaulthome/hostingstart
    ./defaultstaticwebapp
fi
