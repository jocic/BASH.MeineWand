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

# Step 1 - Enable Firewall

printf "[+] Enabling firewall..\n";

ufw enable > /dev/null 2>&1;

# Step 2 - Disable All Traffic By Default

printf "[+] Disabling all inbound & outbound traffic...\n";

ufw default deny incoming > /dev/null 2>&1;
ufw default deny outgoing > /dev/null 2>&1;

# Step 3 - Enable Google DNS Servers

printf "[+] Allowing traffic to Google DNS servers...\n";

ufw allow out to "8.8.8.8" comment "Google DNS 1" > /dev/null 2>&1;
ufw allow out to "8.8.4.4" comment "Google DNS 2" > /dev/null 2>&1;

# Step 4 - Allow Traffic To Ubuntu Servers

printf "[+] Allowing traffic to Ubuntu servers...\n";

/usr/sbin/ufw allow out to "91.189.91.23" comment "Ubuntu Server 1" > /dev/null 2>&1;
/usr/sbin/ufw allow out to "91.189.91.26" comment "Ubuntu Server 2" > /dev/null 2>&1;
