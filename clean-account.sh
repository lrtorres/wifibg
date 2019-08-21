#!/bin/sh

#If we ever need to deleted a logged-in console user,
#then uncomment the last line two lines and replace the current
#"for i" loop.
#for i in `who | grep "console" | cut -d" " -f1`
#    do HOMEDIR="$(eval echo ~${i})";
user=neyman
echo "Cleaning $HOMEDIR";
for i in Desktop Downloads Documents; do
    d="/Users/${user}/${i}"
    echo "Deleting ${d} contents";
    rm -rf ${d}
    install -d -o ${user} ${d}
done

