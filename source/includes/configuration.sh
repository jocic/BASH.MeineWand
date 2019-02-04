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

#################
# GET FUNCTIONS #
#################

# GET FUNCTIONS GO HERE

#################
# SET FUNCTIONS #
#################

# GET FUNCTIONS GO HERE

##################
# CORE FUNCTIONS #
##################

# Creates a configuration directory.
# 
# @author: Djordje Jocic <office@djordjejocic.com>
# @copyright: 2019 MIT License (MIT)
# @version: 1.0.0
# 
# @param string $dir_name
#   Directory name that should be checked, ex. <i>my-directory</i>.
# @return integer
#   Value <i>0</i> for <i>SUCCESS</i>, or value <i>1</i> for <i>FAILURE</i>.

create_config_dir()
{
    # Core Variables
    
    local dir_name="$1";
    
    # Step 1 - Handle Passed Directory
    
    if [ -z "$dir_name" ]; then
        dir_name="meine-wand";
    elif [ $(is_dir_name_valid "$dir_name"; echo "$?") = 1 ]; then
        return 1;
    fi
    
    # Step 2 - Create Directory
    
    if [ ! -d "~/.cache/$dir_name" ]; then
        
        mkdir -p "~/.cache/$dir_name" > /dev/null 2>&1;
        
        return "$?";
        
    fi
    
    return 1;
}

###################
# CHECK FUNCTIONS #
###################

# Checks if a provided directory name is valid or not.
# 
# @author: Djordje Jocic <office@djordjejocic.com>
# @copyright: 2019 MIT License (MIT)
# @version: 1.0.0
# 
# @param string $dir_name
#   Directory name that should be checked, ex. <i>my-directory</i>.
# @return integer
#   Value <i>0</i> for <i>SUCCESS</i>, or value <i>1</i> for <i>FAILURE</i>.

is_dir_name_valid()
{
    # Core Variables
    
    local dir_name="$1";
    
    # Logic
    
    printf "%s" "$dir_name" | grep -qP "^[A-z0-9-]+$";
    
    return "$?";
}

###################
# OTHER FUNCTIONS #
###################

# OTHER FUNCTIONS GO HERE
