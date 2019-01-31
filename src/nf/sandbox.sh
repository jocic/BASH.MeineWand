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
    interface="any";
fi

###########################
# Step 3 - Reset Firewall #
###########################

printf "[+] Reseting firewall..\n";

(iptables -F && ip6tables -F) > /dev/null 2>&1;

###########################################
# Step 4 - Disable All Traffic By Default #
###########################################

printf "[+] Disabling all inbound & outbound traffic...\n";

(iptables -P INPUT DROP && iptables -P OUTPUT DROP) > /dev/null 2>&1;
(ip6tables -P INPUT DROP && ip6tables -P OUTPUT DROP) > /dev/null 2>&1;

iptables -P INPUT -j ACCEPT -m state --state ESTABLISHED > /dev/null 2>&1;
ip6tables -P INPUT -j ACCEPT -m state --state ESTABLISHED > /dev/null 2>&1;

################################
# Step 5 - Whitelisting GitHub #
################################

printf "[+] Whitelisting GitHub..\n";

iptables -A OUTPUT -j ACCEPT -o "$interface" -d 140.82.118.3 -p tcp --dport 443 > /dev/null 2>&1;
iptables -A OUTPUT -j ACCEPT -o "$interface" -d 140.82.118.4 -p tcp --dport 443 > /dev/null 2>&1;

printf "\n# GitHub\n\n\
140.82.118.3 github.com\n\
140.82.118.4 github.com\n\
140.82.118.3 www.github.com\n\
140.82.118.4 www.github.com\n\
140.82.118.3 github.githubassets.com\n\
140.82.118.4 github.githubassets.com\n" >> /etc/hosts;

##################################
# Step 6 - Whitelisting LinkedIn #
##################################

printf "[+] Whitelisting LinkedIn..\n";

iptables -A OUTPUT -j ACCEPT -o "$interface" -d 108.174.10.10 -p tcp --dport 443 > /dev/null 2>&1;

printf "\n# LinkedIn\n\n\
108.174.10.10 linkedin.com\n\
108.174.10.10 www.linkedin.com\n\
108.174.10.10 static.licdn.com\n\
108.174.10.10 static.licdn.com\n" >> /etc/hosts;

#################################
# Step 7 - Whitelisting Twitter #
#################################

printf "[+] Whitelisting Twitter..\n";

iptables -A OUTPUT -j ACCEPT -o "$interface" -d 104.244.42.65 -p tcp --dport 443 > /dev/null 2>&1;
iptables -A OUTPUT -j ACCEPT -o "$interface" -d 104.244.42.193 -p tcp --dport 443 > /dev/null 2>&1;

printf "\n# Twitter\n\n\
104.244.42.65 twitter.com\n\
104.244.42.193 twitter.com\n\
104.244.42.65 www.twitter.com\n\
104.244.42.193 www.twitter.com\n
104.244.42.65 abs.twimg.com\n\
104.244.42.193 abs.twimg.com\n" >> /etc/hosts;

######################################
# Step 8 - Whitelisting Godaddy (UK) #
######################################

printf "[+] Whitelisting GoDaddy (UK)..\n";

iptables -A OUTPUT -j ACCEPT -o "$interface" -d 92.123.196.192 -p tcp --dport 443 > /dev/null 2>&1;

printf "\n# GoDaddy (UK)\n\n\
92.123.196.192 uk.godaddy.com\n\
92.123.196.192 uk.godaddy.com\n" >> /etc/hosts;