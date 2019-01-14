#!/bin/bash

###################################################################
# Script Author: Djordje Jocic                                    #
# Script Year: 2018                                               #
# Script License: MIT License (MIT)                               #
# =============================================================== #
# Personal Website: http://www.djordjejocic.com/                  #
# =============================================================== #
# Permission is hereby granted, free of charge, to any person     #
# obtaining a copy of this software and associated documentation  #
# files (the "Software"), to deal in the Software without         #
# restriction, including without limitation the rights to use,    #
# copy, modify, merge, publish, distribute, sublicense, and/or    #
# sell copies of the Software, and to permit persons to whom the  #
# Software is furnished to do so, subject to the following        #
# conditions.                                                     #
# --------------------------------------------------------------- #
# The above copyright notice and this permission notice shall be  #
# included in all copies or substantial portions of the Software. #
# --------------------------------------------------------------- #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, #
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES #
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND        #
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT     #
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,    #
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, RISING     #
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR   #
# OTHER DEALINGS IN THE SOFTWARE.                                 #
###################################################################

# Step 1 - Reseting & Enable Firewall

printf "[+] Reseting & enabling firewall..\n";

echo "y" | ufw reset && ufw enable;

# Step 2 - Deny Incoming & Outgoing Traffic

printf "[+] Denying incoming & outgoing traffic..\n";

ufw default deny incoming;
ufw default deny outgoing;

# Step 3 - Adding Basic Rules

printf "[+] Adding basic rules..\n";

ufw allow out on enx0c5b8f279a64 to 109.123.74.101 proto udp comment "TunnelBear (UK)";

#ufw allow out on tun0 to 8.8.8.8 port 53 proto udp comment "Google DNS #1";
#ufw allow out on tun0 to 8.8.4.4 port 53 proto udp comment "Google DNS #2";

# Step 4 - Whitelisting GitHub

printf "[+] Whitelisting GitHub..\n";

ufw allow out on tun0 to 140.82.118.3 port 443 comment "GitHub #1";
ufw allow out on tun0 to 140.82.118.4 port 443 comment "GitHub #2";

printf "\n# GitHub\n\
140.82.118.3 github.com\n\
140.82.118.4 github.com\n\
140.82.118.3 www.github.com\n\
140.82.118.4 www.github.com\n\
140.82.118.3 github.githubassets.com\n\
140.82.118.4 github.githubassets.com\n" >> /etc/hosts;

# Step 4 - Whitelisting Linkedin

printf "[+] Whitelisting LinkedIn..\n";

ufw allow out on tun0 to 108.174.10.10 port 443 comment "LinkedIn";

printf "\n# LinkedIn\n\
108.174.10.10 linkedin.com\n\
108.174.10.10 www.linkedin.com\n\
108.174.10.10 static.licdn.com\n\
108.174.10.10 static.licdn.com\n" >> /etc/hosts;

# Step 4 - Whitelisting Twitter

printf "[+] Whitelisting Twitter..\n";

ufw allow out on tun0 to 104.244.42.65 port 443 comment "Twitter #1";
ufw allow out on tun0 to 104.244.42.193 port 443 comment "Twitter #2";

printf "\n# Twitter\n\
104.244.42.65 twitter.com\n\
104.244.42.193 twitter.com\n\
104.244.42.65 www.twitter.com\n\
104.244.42.193 www.twitter.com\n
104.244.42.65 abs.twimg.com\n\
104.244.42.193 abs.twimg.com\n" >> /etc/hosts;

# Step 5 - Whitelisting Godaddy

printf "[+] Whitelisting GoDaddy..\n";

ufw allow out on tun0 to 92.123.196.192 port 443 comment "GoDaddy";

printf "\n# GoDaddy\n\
92.123.196.192 uk.godaddy.com\n\
92.123.196.192 uk.godaddy.com\n" >> /etc/hosts;
