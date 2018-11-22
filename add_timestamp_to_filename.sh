#!/bin/sh
# bash script, that duplicates the given files. The filenames of the duplicates will get the
# current timestamp (e.g. 2018-11-22_09:04:01.353) appended to the filename
# e.g.: test.png --> test_2018-11-22_09:04:01.353.png

for f in "$@"
do
    echo "$f"
    timestamp=$(stat -c %y "$f")
    timestamp=$(echo $timestamp | sed 's/ +....//g' | sed 's/ /_/g' | sed -E 's/(:..\....)(.*)/\1/g')

    echo "a"
    f_basename=$(basename "$f")
    f_dirname=$(dirname "$f")
    f_extension="${f_basename##*.}"


    if [ $f_basename = $f_extension ]
    then
        # filename has no extension: e.g. testfile
        new_filename="${f_dirname}/${f_basename}_$timestamp"
    else
        # filename has extension: e.g. testfile.txt
        f_basename=$(basename "$f" ".$f_extension")
        new_filename="${f_dirname}/${f_basename}_$timestamp.${f_extension}"
    fi
    
    # echo $timestamp
    echo $new_filename
        
    cp "$f" "${new_filename}"
done

