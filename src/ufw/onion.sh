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
    network_interface="all";
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

echo "y" | /usr/sbin/ufw reset > /dev/null 2>&1;

############################
# Step 5 - Enable Firewall #
############################

printf "[+] Enabling firewall..\n";

ufw enable > /dev/null 2>&1;

###########################################
# Step 6 - Disable All Traffic By Default #
###########################################

printf "[+] Disabling all inbound & outbound traffic...\n";

ufw default deny incoming > /dev/null 2>&1;
ufw default deny outgoing > /dev/null 2>&1;

##############################
# Step 7 - Define Core Rules #
##############################

printf "[+] Defining core rules...\n";

ufw allow out on any to any port 68 proto udp comment "Regular DHCP" > /dev/null 2>&1;

ufw allow out on "$network_interface" to "$vpn_ip_address" port 443 proto "$vpn_proto" comment "VPN's IP" > /dev/null 2>&1;

ufw allow out on "$vpn_interface" to 8.8.8.8 port 53 proto udp comment "Google DNS #1" > /dev/null 2>&1;
ufw allow out on "$vpn_interface" to 8.8.4.4 port 53 proto udp comment "Google DNS #2" > /dev/null 2>&1;

ufw allow out on "$vpn_interface" to any port 80 proto tcp comment "HTTP (TCP)" > /dev/null 2>&1;
ufw allow out on "$vpn_interface" to any port 80 proto udp comment "HTTP (UDP)" > /dev/null 2>&1;

ufw allow out on "$vpn_interface" to any port 443 proto tcp comment "HTTPS (TCP)" > /dev/null 2>&1;
ufw allow out on "$vpn_interface" to any port 443 proto udp comment "HTTPS (UDP)" > /dev/null 2>&1;

ufw allow out on "$vpn_interface" to any port 465 proto tcp comment "SMTP (SSL)" > /dev/null 2>&1;
ufw allow out on "$vpn_interface" to any port 995 proto tcp comment "POP3 (SSL)" > /dev/null 2>&1;