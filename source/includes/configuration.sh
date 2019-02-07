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

get_config_param()
{
    # Core Variables
    
    local config_key="$1";
    local config_dir="$2";
    local config_file="$3";
    
    # Logic
    
    if [ -z "$config_file" ]; then
        config_file="$J_MW_CONF_FILE";
    fi
    
    
}

#################
# SET FUNCTIONS #
#################

set_config_param()
{
    # Core Variables
    
    local config_key="$1";
    local config_value="$2";
    local config_dir="$3";
    local config_file="$4";
    
    # Other Variables
    
    local config_path="";
    
    # Step 1 - Check Configuration File & Directory Names
    
    if [ -z "$config_file" ]; then
        config_file="$J_MW_CONF_FILE";
    elif [ $(is_config_file_valid "$config_file"; echo "$?") = 1 ]; then
        return 1;
    fi
    
    if [ -z "$config_dir" ]; then
        config_dir="$J_MW_CONF_DIR";
    elif [ $(is_config_dir_valid "$config_dir"; echo "$?") = 1 ]; then
        return 1;
    fi
    
    # Step 2 - Set Configuration Parameter
    
    config_path="$HOME/.config/$dir_name/$config_file";
    
    if [ $(is_config_file_created "$config_path"; echo "$?") = 0 ]; then
        
        #if [ -f "~/.cache/$
        
        printf "%s=%s\n" "$1" "$2" >> "$config_file";
        
    fi
    
    return 1;
}

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
#   Config. directory name that should be used, ex. <i>my-directory</i>.
# @return integer
#   Value <i>0</i> for <i>SUCCESS</i>, or value <i>1</i> for <i>FAILURE</i>.

create_config_dir()
{
    # Core Variables
    
    local dir_name="$1";
    
    # Other Variables
    
    local dir_path="";
    
    # Step 1 - Handle Passed Directory
    
    if [ -z "$dir_name" ]; then
        dir_name="$J_MW_CONF_DIR";
    elif [ $(is_config_dir_valid "$dir_name"; echo "$?") = 1 ]; then
        return 1;
    fi
    
    # Step 2 - Create Directory
    
    dir_path="$HOME/.config/$dir_name";
    
    if [ ! -d "$dir_path" ]; then
        mkdir -p "$dir_path" > /dev/null 2>&1 && return "$?";
    fi
    
    return 1;
}

# Creates a basic configuration file.
# 
# @author: Djordje Jocic <office@djordjejocic.com>
# @copyright: 2019 MIT License (MIT)
# @version: 1.0.0
# 
# @param string $file_name
#   Config. file name that should be used, ex. <i>basic.conf</i>.
# @param string $dir_name
#   Config. directory name that should be used, ex. <i>my-directory</i>.
# @return integer
#   Value <i>0</i> for <i>SUCCESS</i>, or value <i>1</i> for <i>FAILURE</i>.

create_config_file()
{
    # Core Variables
    
    local file_name="$1";
    local dir_name="$2";
    
    # Other Variables
    
    local file_path="";
    
    # Step 1 - Handle Passed Directory
    
    if [ -z "$dir_name" ]; then
        dir_name="$J_MW_CONF_DIR";
    elif [ $(is_config_dir_valid "$dir_name"; echo "$?") = 1 ]; then
        return 1;
    fi
    
    # Step 2 - Handle Passed File
    
    if [ -z "$file_name" ]; then
        file_name="$J_MW_CONF_FILE";
    elif [ $(is_config_file_valid "$file_name"; echo "$?") = 1 ]; then
        return 1;
    fi
    
    # Step 3 - Create File
    
    file_path="$HOME/.config/$dir_name/$file_name";
    
    if [ ! -f "$file_path" ]; then
        touch "$file_path" && return 0;
    fi
    
    return 1;
}

###################
# CHECK FUNCTIONS #
###################

# Checks if a provided configuration directory name is valid or not.
# 
# @author: Djordje Jocic <office@djordjejocic.com>
# @copyright: 2019 MIT License (MIT)
# @version: 1.0.0
# 
# @param string $dir_name
#   Config. directory name that should be checked, ex. <i>my-directory</i>.
# @return integer
#   Value <i>0</i> for <i>SUCCESS</i>, or value <i>1</i> for <i>FAILURE</i>.

is_config_dir_valid()
{
    # Core Variables
    
    local dir_name="$1";
    
    # Logic
    
    grep -qP "^[A-z0-9-]+$" <<< "$dir_name";
    
    return "$?";
}

# Checks if a configuration directory was created or not.
# 
# @author: Djordje Jocic <office@djordjejocic.com>
# @copyright: 2019 MIT License (MIT)
# @version: 1.0.0
# 
# @param string $dir_name
#   Config. directory name that should be checked, ex. <i>my-directory</i>.
# @return integer
#   Value <i>0</i> for if it was created, and <i>1</i> if it wasn't.


is_config_dir_created()
{
    # Core Variables
    
    local dir_name="$1";
    
    # Logic
    
    [ $(is_config_dir_valid "$dir_name"; echo "$?") = 1 ] \
       || [ ! -d "$HOME/.config/$dir_name" ] \
           && return 1;
    
    return 0;
}

# Checks if a provided configuration filename name is valid or not.
# 
# @author: Djordje Jocic <office@djordjejocic.com>
# @copyright: 2019 MIT License (MIT)
# @version: 1.0.0
# 
# @param string $file_name
#   Config. file name that should be checked, ex. <i>my-directory</i>.
# @return integer
#   Value <i>0</i> for <i>SUCCESS</i>, or value <i>1</i> for <i>FAILURE</i>.

is_config_file_valid()
{
    # Core Variables
    
    local file_name="$1";
    
    # Logic
    
    grep -qP "^[A-z-.]+$" <<< "$file_name";
    
    return "$?";
}

# Checks if a configuration file was created or not.
# 
# @author: Djordje Jocic <office@djordjejocic.com>
# @copyright: 2019 MIT License (MIT)
# @version: 1.0.0
# 
# @param string $file_name
#   Config. file name that should be checked, ex. <i>my-directory</i>.
# @param string $dir_name
#   Config. directory name that should be checked, ex. <i>my-directory</i>.
# @return integer
#   Value <i>0</i> for if it was created, and <i>1</i> if it wasn't.

is_config_file_created()
{
    # Core Variables
    
    local file_name="$1";
    local dir_name="$2";
    
    # Logic
    
    [ -z "$dir_name" ] && dir_name="$J_MW_CONF_DIR";
    
    [ $(is_config_dir_valid "$dir_name"; echo "$?") = 1 ] \
        || [ $(is_config_file_valid "$file_name"; echo "$?") = 1 ] \
            || [ ! -f "$HOME/.config/$dir_name/$file_name" ] \
                && return 1;
    
    return 0;
}

###################
# OTHER FUNCTIONS #
###################

# OTHER FUNCTIONS GO HERE
