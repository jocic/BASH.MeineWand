#!/bin/bash

###################################################################
# Script Author: Djordje Jocic                                    #
# Script Year: 2019                                               #
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

kcov_version="$1";
kcov_link=$(printf "https://github.com/SimonKagstrom/kcov/archive/v%s.tar.gz", "$kcov_version");
kcov_archive=$(printf "kcov-v%s.tar.gz" "$kcov_version");

###################
# Other Variables #
###################

temp="";

#############################
# Step 1 - Download Archive #
#############################

[ -z "$kcov_version" ] && printf "[+] Version wasn't provided...\n" && exit 1;

printf "[+] Downloading KCOV v%s...\n" "$kcov_version";

(wget "$kcov_link" -O "$kcov_archive") > /dev/null 2>&1;

##########################
# Step 2 - Check Archive #
##########################

printf "[+] Checking downloaded archive...\n";

temp=$(file --mime-type "$kcov_archive" | cut -d " " -f 2);

[ "$temp" != "application/gzip" ] \
    && printf "\nProcedure failed...\n" && exit 1;
