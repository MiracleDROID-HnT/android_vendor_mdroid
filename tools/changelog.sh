#!/bin/sh

# Exports
dir=$ANDROID_BUILD_TOP
out=$dir/out/target/product

export Changelog=$PWD/Changelog.txt

if [ -f $Changelog ];
then
	rm -f $Changelog
fi

touch $Changelog

# Print something to build output
echo ${bldppl}"Generating changelog..."${txtrst}

# define changelog_days using 'export changelog_days=10'
# this can be done before intiate build environment (. build/envsetup.sh)
if [ -z $changelog_days ];then
	changelog_days=10
else
	if [ $changelog_days > 30 ]; then
        echo "Changelog can not generated for more then 30 days. For how many days do you want to generate changelog again? (🕑 timeout 15 seconds - default to 10 days)"
        read -r -t 15 changelog_days || changelog_days=10
	fi
fi
echo $changelog_days

for i in $(seq $changelog_days);
do
export After_Date=`date --date="$i days ago" +%F`
k=$(expr $i - 1)
export Until_Date=`date --date="$k days ago" +%F`
echo "====================" >> $Changelog;
echo "     $Until_Date    " >> $Changelog;
echo "====================" >> $Changelog;
repo forall -pc 'git log --after=$After_Date --until=$Until_Date --pretty=tformat:"%h  %s  [%an]" --abbrev-commit --abbrev=7' >> $Changelog
echo "" >> $Changelog;
done

sed -i 's/project/ */g' $Changelog
sed -i 's/[/]$//' $Changelog

if [ -e $out/*/$Changelog ]
then
rm $out/*/$Changelog
fi
if [ -e $out/*/system/etc/$Changelog ]
then
rm $out/*/system/etc/$Changelog
fi
cp $Changelog $OUT/system/etc/
cp $Changelog $OUT/
rm $Changelog
