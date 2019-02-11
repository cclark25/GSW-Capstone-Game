#!/bin/bash

if [ $1 == "y" ]; then
	if [ -e timestamp ] ; then
		echo EXISTS!
	fi
	ls *.kra | while read file; do
		if [ ! -e timestamp ] || [ $file -nt timestamp ]; then
			echo Starting file: $file
			krita $file --export --export-filename PNGs/$file.png 
		fi
	done
	touch timestamp
fi

list(){
	ls $2/*.png | grep $3 | cut -d '.' -f $1 | sed "s/$2.//" | uniq | while read line; do
		echo $line;
	done
}

ls PNGs | while read line; do
	newFile=`echo $line | sed 's/UpRight/7/' | sed 's/DownRight/1/' | sed 's/DownLeft/3/' | sed 's/UpLeft/5/' | sed 's/Right/0/' | sed 's/Down/2/' | sed 's/Left/4/' | sed 's/Up/6/'`

	mv PNGs/$line PNGs/$newFile
done

convert_rows(){
	list $1 "PNGs" "." | while read line; do
		re='^[0-9]+$'
		if [[ $line =~ $re ]] ; then
			convert PNGs/$line.* +append "PNGs/Rows/$line.png"
		else
			var=$1
			list $((var+1)) "PNGs" $line | while read line2; do
				convert PNGs/$line.$line2.* +append "PNGs/Rows/$line.$line2.png"
			done
		fi
	done
}

convert_rows 1

convert PNGs/Rows/*.png -append PNGs/Rows/Sheet/Entity.png

#
#ls *.kra | cut -d '.' -f 1 | uniq | while read line; do
#	echo $line
#	ls PNGs/$line.* | sed 's/PNGs.//' | sed 's/.import//' | uniq | while read line2; do
#		echo -e "\t$line2"
#	done
#done
