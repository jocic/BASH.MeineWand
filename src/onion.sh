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

if [ "$1" = "1" ]; then # Layer 1
    
    echo "y" | ufw reset;
    
    ufw enable;
    
    ufw default deny incoming;
    ufw default deny outgoing;
    
    ufw allow out on enp0s3 to any port 68 proto udp comment "Regular DHCP";
    
    ufw allow out on enx0c5b8f279a64 to 109.123.74.101 proto udp comment "TunnelBear (UK)";
    
    ufw allow out on tun0 to 8.8.8.8 port 53 proto udp comment "Google DNS #1";
    ufw allow out on tun0 to 8.8.4.4 port 53 proto udp comment "Google DNS #2";
    
    ufw allow out on tun0 to any port 443 proto tcp comment "HTTPS";
    
    ufw allow out on tun0 to any port 465 proto tcp comment "SMTP (SSL)"
    ufw allow out on tun0 to any port 995 proto tcp comment "POP3 (SSL)"
    
elif [ "$1" = "2" ]; then # Layer 2
    
    echo "y" | ufw reset;
    
    ufw enable;
    
    ufw default deny incoming;
    ufw default deny outgoing;
    
    ufw allow out on enp0s3 to any port 68 proto udp comment "Regular DHCP";
    
    ufw allow out on enp0s3 to 185.246.130.5 proto udp comment "TunnelBear (SE)";
    
    ufw allow out on tun0 to 8.8.8.8 port 53 proto udp comment "Google DNS #1";
    ufw allow out on tun0 to 8.8.4.4 port 53 proto udp comment "Google DNS #2";
    
    ufw allow out on tun0 to any port 443 proto tcp comment "HTTPS";
    
    ufw allow out on tun0 to any port 465 proto tcp comment "SMTP (SSL)"
    ufw allow out on tun0 to any port 995 proto tcp comment "POP3 (SSL)"
    
fi
