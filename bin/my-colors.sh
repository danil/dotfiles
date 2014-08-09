# <https://wiki.archlinux.org/index.php/x_resources#Display_all_256_colors>.
(x=`tput op` y=`printf %76s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done)
