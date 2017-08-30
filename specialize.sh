#!/bin/sh
for file in $(find Sources/Swim/Specialization -name "*.gyb"); do
	dest=${file%.*}
	echo "gyb $file -o $dest --line-directive="
	gyb "$file" -o "$dest" --line-directive=""
done