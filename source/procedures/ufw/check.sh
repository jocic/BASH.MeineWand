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
fw_status="";
interfaces="";

#############################
# Step 1 - Check Privileges #
#############################

if [ "$user_id" != "0" ]; then
    printf "Error: You need to run this script with root privileges.\n" && exit;
fi

###############################
# Step 2 - Check Dependencies #
###############################

if [ -z "$(command -v ifconfig)" ]; then
    printf "Error: Command \"ifconfig\" is missing. Please install \"net-tools\" to your machine.\n" && exit;
fi

##########################
# Step 3 - Check Firewal #
##########################

for i in {1..59}; do
    
    # Get Status & Interfaces
    
    fw_status="$(ufw status |  grep -oP '^Status: active')";
    interfaces="$(nmcli d | egrep 'connected|unmanaged')";
    
    # Turn Off The Interfaces If Needed
    
    echo "$i/59 seconds..." && sleep 1s;
    
    if [ -z "$fw_status" ]; then
        
        for interface in "$interfaces"; do
            
            interface="$(echo "$interface" | cut -d " " -f 1)";
            
            if [ -n "$interface" ]; then
                ifconfig "$interface" down;
            fi
            
        done
        
        exit;
        
    fi
    
done