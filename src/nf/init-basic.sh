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

######################################
# Step 5 - Enable Google DNS Servers #
######################################

printf "[+] Allowing traffic to Google DNS servers...\n";

iptables -A OUTPUT -j ACCEPT -o "$interface" -d 8.8.8.8 -p udp --dport 53 > /dev/null 2>&1;
iptables -A OUTPUT -j ACCEPT -o "$interface" -d 8.8.4.4 -p udp --dport 53 > /dev/null 2>&1;

############################################
# Step 6 - Allow Traffic To Ubuntu Servers #
############################################

printf "[+] Allowing traffic to Ubuntu servers...\n";

iptables -A OUTPUT -j ACCEPT -o "$interface" -d 91.189.91.23 -p tcp --dport 80 > /dev/null 2>&1;
iptables -A OUTPUT -j ACCEPT -o "$interface" -d 91.189.91.26 -p tcp --dport 80 > /dev/null 2>&1;