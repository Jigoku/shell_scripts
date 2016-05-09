#!/bin/bash
# lilo bootsplash generator
#
# converts images suitable for lilo
#	- indexed pallete (16 colors)
#	- resizes to 640x480 (stretched)
#	- writes as a bitmap
#
# todo
#	- print available colors from pallete (used for fonts/menus)
#	- option to add some template/menu borders to the image 
#	- print lilo config for placement of template menus, if used
IMG=$1


FNAME=${IMG##*/}

convert ${IMG} -resize 640x480\! -colors 32 bmp3:${FNAME%.*}.bmp
