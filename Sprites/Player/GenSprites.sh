#!/bin/bash

echo -e "Up\nDown\nLeft\nRight\nUpLeft\nUpRight" | while read direction; do
	echo $direction.0.png $direction.1.png $direction.2.png +append $direction.png | while read line; do
		convert $line
	done
done

export full=""
echo -e "Up\nDown\nLeft\nRight\nUpLeft\nUpRight" | while read direction; do
	export full+="$direction.png "
	echo $full
done
