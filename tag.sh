#!/bin/sh 

find ./ -name "*.h" -o -name "*.c" -o -name "*.cc" > cscope.files 
echo "find ok!"
cscope -bkq -i cscope.files 
echo "cscope ok!"
ctags -R 
echo "ctags ok!"

