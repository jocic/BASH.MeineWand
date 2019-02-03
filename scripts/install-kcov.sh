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

kcov_dir="$1";

###################
# Other Variables #
###################

temp="";

#################################
# Step 1 - Check Work Directory #
#################################

printf "[+] Check work directory...\n";

if [ -z "$kcov_dir" ]; then
    printf "\nError: Directory wasn't provided...\n" && exit 1;
elif [ ! -d "$kcov_dir/source/build" ]; then
    printf "\nError: Build directory doesn't exist...\n" && exit 1;
fi

#######################################
# Step 2 - Prepare Coverage Directory #
#######################################

mkdir "$kcov_dir/coverage" > /dev/null 2>&1;

if [ ! -d "$kcov_dir/coverage" ]; then
    printf "\nError: Coverage directory coudn't be created...\n" && exit 1;
fi

#########################
# Step 3 - Install KCOV #
#########################

cd "$kcov_dir/source/build" > /dev/null 2>&1;

make install;
