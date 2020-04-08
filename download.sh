#!/bin/bash

# file TSV Book Title	Author	English Package Name	OpenURL
input="books.tsv"
total=$(wc -l $input | cut -d' ' -f6)
counter=1

while IFS= read -r line
do
	echo "***** PROCESSING BOOK $counter of $total *****"
	OLD_IFS=$IFS
	IFS=$'\t'
	fields=($line)

	title=${fields[0]}
	author=${fields[1]}
	folder=${fields[2]}
	url=${fields[3]}

	mkdir -p "download/$folder"; 
	bookHtml=""

	# PDF
	filename="download/$folder/$title - $author.pdf"
	echo "Processing $filename"
	if [ ! -f $filename ]
	then
		echo "Downloading $filename"
    	bookHtml=$(wget -qO- "$url")
    	link=$(echo $bookHtml | grep -m 1 "Book download - pdf" | cut -d'"' -f2)
    	if [ ! -z "$link" ]; then
			wget "https://link.springer.com${link}" -O "$filename"
    	fi
	fi

	# EPUB
	filename="download/$folder/$title - $author.epub"
	echo "Processing $filename"
	if [ ! -f $filename ]
	then
		echo "Downloading $filename"
		if [ ! -z $bookHtml ]; then
			bookHtml=$(wget -qO- "$url")
    	fi
    	link=$(echo $bookHtml | grep -m 1 "Book download - ePub" | cut -d'"' -f2)
    	if [ ! -z "$link" ]; then
			wget "https://link.springer.com${link}" -O "$filename"
    	fi
	fi
	
	counter=$[$counter +1]
	IFS=$OLD_IFS
done < "$input"
