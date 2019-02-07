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

##################
# Core Variables #
##################

user_id="$(id -u)";
interface="$1";

#############################
# Step 1 - Check Privileges #
#############################

if [ "$user_id" != "0" ]; then
    printf "Error: You need to run this script with root privileges.\n" && exit;
fi

###############################
# Step 2 - Process Parameters #
###############################

if [ -z "$interface" ]; then
    interface="all";
fi

###########################
# Step 3 - Reset Firewall #
###########################

printf "[+] Reseting firewall..\n";

echo "y" | /usr/sbin/ufw reset > /dev/null 2>&1;

############################
# Step 4 - Enable Firewall #
############################

printf "[+] Enabling firewall..\n";

ufw enable > /dev/null 2>&1;

###########################################
# Step 5 - Disable All Traffic By Default #
###########################################

printf "[+] Disabling all inbound & outbound traffic...\n";

ufw default deny incoming > /dev/null 2>&1;
ufw default deny outgoing > /dev/null 2>&1;

################################
# Step 6 - Whitelisting GitHub #
################################

printf "[+] Whitelisting GitHub..\n";

ufw allow out on "$interface" to 140.82.118.3 port 443 comment "GitHub #1" > /dev/null 2>&1;
ufw allow out on "$interface" to 140.82.118.4 port 443 comment "GitHub #2" > /dev/null 2>&1;

printf "\n# GitHub\n\n\
140.82.118.3 github.com\n\
140.82.118.4 github.com\n\
140.82.118.3 www.github.com\n\
140.82.118.4 www.github.com\n\
140.82.118.3 github.githubassets.com\n\
140.82.118.4 github.githubassets.com\n" >> /etc/hosts;

##################################
# Step 7 - Whitelisting LinkedIn #
##################################

printf "[+] Whitelisting LinkedIn..\n";

ufw allow out on "$interface" to 108.174.10.10 port 443 comment "LinkedIn" > /dev/null 2>&1;

printf "\n# LinkedIn\n\n\
108.174.10.10 linkedin.com\n\
108.174.10.10 www.linkedin.com\n\
108.174.10.10 static.licdn.com\n\
108.174.10.10 static.licdn.com\n" >> /etc/hosts;

#################################
# Step 8 - Whitelisting Twitter #
#################################

printf "[+] Whitelisting Twitter..\n";

ufw allow out on "$interface" to 104.244.42.65 port 443 comment "Twitter #1" > /dev/null 2>&1;
ufw allow out on "$interface" to 104.244.42.193 port 443 comment "Twitter #2" > /dev/null 2>&1;

printf "\n# Twitter\n\n\
104.244.42.65 twitter.com\n\
104.244.42.193 twitter.com\n\
104.244.42.65 www.twitter.com\n\
104.244.42.193 www.twitter.com\n
104.244.42.65 abs.twimg.com\n\
104.244.42.193 abs.twimg.com\n" >> /etc/hosts;

######################################
# Step 9 - Whitelisting Godaddy (UK) #
######################################

printf "[+] Whitelisting GoDaddy (UK)..\n";

ufw allow out on "$interface" to 92.123.196.192 port 443 comment "GoDaddy (UK)" > /dev/null 2>&1;

printf "\n# GoDaddy (UK)\n\n\
92.123.196.192 uk.godaddy.com\n\
92.123.196.192 uk.godaddy.com\n" >> /etc/hosts;