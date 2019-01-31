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
network_interface="$1";
vpn_interface="$2";
vpn_ip_address="$3";
vpn_proto="$4";

#############################
# Step 1 - Check Privileges #
#############################

if [ "$user_id" != "0" ]; then
    printf "Error: You need to run this script with root privileges.\n" && exit;
fi

#############################
# Step 2 - Check Parameters #
#############################

if [ -z "$vpn_ip_address" ]; then
    printf "Error: You need to enter an IP address of a VPN server.\n" && exit;
fi

###############################
# Step 3 - Process Parameters #
###############################

if [ -z "$network_interface" ]; then
    network_interface="any";
fi

if [ -z "$vpn_interface" ]; then
    vpn_interface="tun0";
fi

if [ -z "$vpn_proto" ]; then
    vpn_proto="udp";
fi

###########################
# Step 4 - Reset Firewall #
###########################

printf "[+] Reseting firewall..\n";

(iptables -F && ip6tables -F) > /dev/null 2>&1;

###########################################
# Step 5 - Disable All Traffic By Default #
###########################################

printf "[+] Disabling all inbound & outbound traffic...\n";

(iptables -P INPUT DROP && iptables -P OUTPUT DROP) > /dev/null 2>&1;
(ip6tables -P INPUT DROP && ip6tables -P OUTPUT DROP) > /dev/null 2>&1;

##############################
# Step 6 - Define Core Rules #
##############################

printf "[+] Defining core rules...\n";

iptables -A OUTPUT -j ACCEPT -p udp --dport 68 > /dev/null 2>&1; # Regular DHCP

iptables -A OUTPUT -j ACCEPT -o "$network_interface" -d "$vpn_ip_address" -p "$vpn_proto" --dport 443 > /dev/null 2>&1; # VPN's IP

iptables -A OUTPUT -j ACCEPT -o "$vpn_interface" -d 8.8.8.8  -p udp --dport 53 > /dev/null 2>&1; # Google DNS #1
iptables -A OUTPUT -j ACCEPT -o "$vpn_interface" -d 8.8.4.4  -p udp --dport 53 > /dev/null 2>&1; # Google DNS #2

iptables -A OUTPUT -j ACCEPT -o "$vpn_interface" -p tcp --dport 80 > /dev/null 2>&1; # HTTP (TCP)
iptables -A OUTPUT -j ACCEPT -o "$vpn_interface" -p udp --dport 80 > /dev/null 2>&1; # HTTP (UDP)

iptables -A OUTPUT -j ACCEPT -o "$vpn_interface" -p tcp --dport 443 > /dev/null 2>&1; # HTTP (TCP)
iptables -A OUTPUT -j ACCEPT -o "$vpn_interface" -p udp --dport 443 > /dev/null 2>&1; # HTTP (UDP)

iptables -A OUTPUT -j ACCEPT -o "$vpn_interface" -p tcp --dport 465 > /dev/null 2>&1; # SMTP (SSL)
iptables -A OUTPUT -j ACCEPT -o "$vpn_interface" -p tcp --dport 995 > /dev/null 2>&1; # POP3 (SSL)