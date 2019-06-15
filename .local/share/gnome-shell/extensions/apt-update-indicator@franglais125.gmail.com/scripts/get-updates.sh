#!/bin/bash
##################################################################################
#    This file is part of Apt Update Indicator
#    Update Indicator is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#    Apt Update Indicator is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#    You should have received a copy of the GNU General Public License
#    along with Apt Update Indicator.  If not, see <http://www.gnu.org/licenses/>.
#    Copyright 2017 Fran Glais
##################################################################################

######################################
#                                    #
#         Check for updates          #
#      and print package names       #
#                                    #
######################################

# Get updates list    | Rm 1st line | "\" -> " "    | Package name and version
apt list --upgradable | tail -n +2  | sed 's/\// /' | awk '{print $1 "\t" $3}'
