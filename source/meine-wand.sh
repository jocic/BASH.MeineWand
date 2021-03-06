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

##################################
# Step 1 - Export Core Variables #
##################################

export J_MW_USER_ID="$(id -u)";
export J_MW_SOURCE_DIR="$(cd -- "$(dirname -- "$0")" && pwd -P)";
export J_MW_VERSION="1.0.0";
export J_MW_CONF_DIR="meine-wand";
export J_MW_CONF_FILE="basic.conf";
export J_MW_SUPPRESS_WARNING="no";

##############################
# Step 2 - Include Functions #
##############################

. "$J_MW_SOURCE_DIR/includes/core.sh";
. "$J_MW_SOURCE_DIR/includes/configuration.sh";
. "$J_MW_SOURCE_DIR/includes/firewall.sh";

##############################
# STEP 3 - Process Arguments #
##############################

for arg in "$@"; do
    
    # Determine Parameter
    
    [ "$J_MW_OPTION" = "initialize" ] && J_MW_PARAMETER="$arg";
    
    # Determine Option
    
    [ "$arg" = "-i" ] || [ "$arg" = "--initialize" ] \
        && J_MW_OPTION="initialize";
    
    [ "$arg" = "-h" ] || [ "$arg" = "--help" ] \
        && J_MW_OPTION="show-help";
    
    [ "$arg" = "-v" ] || [ "$arg" = "--version" ] \
        && J_MW_OPTION="show-version";
    
    # Handle Flags
    
    [ "$arg" = "--suppress-warning" ] \
        && J_MW_SUPPRESS_WARNING="yes";
    
done

export J_MW_OPTION;
export J_MW_PARAMETER;

############################
# STEP 4 - Process Options #
############################

if [ "$J_MW_USER_ID" != 0 ] && [ "$J_MW_SUPPRESS_WARNING" = "no" ]; then
    printf "[+] This script should be ran with root privileges.\n\n";
fi

if [ "$J_MW_OPTION" = "show-help" ]; then
    show_help;
elif [ "$J_MW_OPTION" = "show-version" ]; then
    show_version;
elif [ "$J_MW_OPTION" = "initialize" ]; then
    initialize;
else
    printf "[X] You didn't provide any option.\n";
fi
