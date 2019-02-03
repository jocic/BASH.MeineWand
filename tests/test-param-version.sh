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

source_dir="$(cd -- "$(dirname -- "$0")" && pwd -P)";

#################
# Primary Tests #
#################

# Tests output of the <i>version</i> parameter - variant one.
# 
# @author: Djordje Jocic <office@djordjejocic.com>
# @copyright: 2019 MIT License (MIT)
# @version: 1.0.0
# 
# @return integer
#   It always returns <i>0</i> - SUCCESS.

testVariantOne()
{
    # Core Variables
    
    version_contents=$(cat "$source_dir/../source/other/version.txt");
    script_output=$(bash "$source_dir/../source/meine-wand.sh" -v);
    
    # Logic
    
    version_contents=$(printf "Meine Wand 1.0.0\n%s" "$version_contents");
    
    assertEquals "$version_contents" "$script_output";
    
    return 0;
}

# Tests output of the <i>version</i> parameter - variant two.
# 
# @author: Djordje Jocic <office@djordjejocic.com>
# @copyright: 2019 MIT License (MIT)
# @version: 1.0.0
# 
# @return integer
#   It always returns <i>0</i> - SUCCESS.

testVariantTwo()
{
    # Core Variables
    
    version_contents=$(cat "$source_dir/../source/other/version.txt");
    script_output=$(bash "$source_dir/../source/meine-wand.sh" --version);
    
    # Logic
    
    version_contents=$(printf "Meine Wand 1.0.0\n%s" "$version_contents");
    
    assertEquals "$version_contents" "$script_output";
    
    return 0;
}

###################
# Secondary Tests #
###################

# SECONDARY TESTS GO HERE

##################
# Tertiary Tests #
##################

# TERTIARY TESTS GO HERE

##################
# Include SHUnit #
##################

. "$source_dir/../other/shunit2/executable";