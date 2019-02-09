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

# Initializes basic configuration.
# 
# @author: Djordje Jocic <office@djordjejocic.com>
# @copyright: 2019 MIT License (MIT)
# @version: 1.0.0
# 
# @return integer
#   It always returns <i>0</i> - SUCCESS.

initialize()
{
    # Core Variables
    
    selection="";
    
    # Step 1 - Create & Check Config Directory
    
    if    [ $(create_config_dir;     echo "$?") = 1 ] \
       && [ $(is_config_dir_created; echo "$?") = 1 ]; then
        
        printf "[X] Configuration directory coudn't be created.\n" && exit;
        
    elif    [ $(create_config_file;     echo "$?") = 1 ] \
         && [ $(is_config_file_created; echo "$?") = 1 ]; then
        
        printf "[X] Configuration file coudn't be created.\n" && exit; 
        
    fi
    
    # Step 2 -- Process Parameter
    
    if [ "$J_MW_PARAMETER" = "nf" ]; then
        
        set_config_param "firewall" "nf";
        set_config_param "configuration" "none";
        set_config_param "configured" "yes";
        
    elif [ "$J_MW_PARAMETER" = "ufw" ]; then
        
        set_config_param "firewall" "ufw";
        set_config_param "configuration" "none";
        set_config_param "configured" "yes";
        
    elif [ "$J_MW_PARAMETER" = "" ]; then
        
        # Get Firewall Option
        
        printf "Your firewall of choice:\n\n  1. %s\n  2. %s\n\n" \
            "NetFilter" \
            "UFW";
        
        read -p "Selection: " selection;
        
        if [ "$selection" = 1 ]; then
            set_config_param "firewall" "nf";
        elif [ "$selection" = 2 ]; then
            set_config_param "firewall" "ufw";
        else
            printf "\n[X] Invalid selection made.\n" && exit; 
        fi
        
        # Set Other Parameters
        
        set_config_param "configuration" "none";
        set_config_param "configured" "yes";
        
        printf "\n";
        
    else
        
        printf "[X] Invalid parameter provided.\n" && exit;
        
    fi
    
    printf "[+] Configuration initialized.\n";
    
    ( execute_procedure "reset" ) > /dev/null 2>&1;
    
    return 0;
}

###################
# CHECK FUNCTIONS #
###################

# CHECK FUNCTIONS GO HERE

###################
# OTHER FUNCTIONS #
###################

# Executes a defined firewall procedure for a defined group.
# 
# @author: Djordje Jocic <office@djordjejocic.com>
# @copyright: 2019 MIT License (MIT)
# @version: 1.0.0
# 
# @param string $procedure
#   Procedure that should be called, ex. <i>reset</i>.
# @return integer
#   It always returns <i>0</i> - SUCCESS.

execute_procedure()
{
    # Core Variables
    
    local procedure="$1";
    local group=$(get_config_param "firewall");
    local configured=$(get_config_param "configured");
    
    # Other Variables
    
    local group_path="$J_MW_SOURCE_DIR/procedures/$group";
    local procedure_path="$J_MW_SOURCE_DIR/procedures/$group/$procedure.sh";
    
    # Step 1 - Check Group
    
    if [ ! -d "$group_path" ]; then
        printf "[X] Desired group doesn't exist.\n" && exit;
    fi
    
    # Step 2 - Check Procedure
    
    if [ ! -f "$procedure_path" ]; then
        printf "[X] Desired procedure doesn't exist.\n" && exit;
    fi
    
    # Step 3 - Execute Procedure
    
    if [ "$configured" = "yes" ]; then
        
        ( . "$procedure_path" ) > /dev/null 2>&1;
        
        printf "[+] Procedure \"%s\" was executed.\n" "$procedure";
        
    else
        
        printf "[X] Script wasn't configured fully.\n" && exit;
        
    fi
    
    return 0;
}
