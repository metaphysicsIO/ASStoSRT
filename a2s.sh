
input=$1

srt=`echo $input | sed "s/ass/srt/"`


# Get numbering
echo 1 `grep "Dialogue:" "$input" | wc -l` | sed "s/^/seq /" | sh | sed "s/$/\n\n\n/" > 01-NUMBERING.txt

# Timing
grep "Dialogue:" "$input" | sed "s/Dialogue: 0,/0/" | sed "s/.Style.*.//" | sed "s/,/0 --> 0/" | sed "s/\./,/g" | sed "s/$/0/" | sed "s/$/\n\n\n/" | sed "1s/^/\n/" > 02-TIMING.txt

# Get the text.. I think this will work.
grep "Dialogue:" "$input" | sed "s/.*.0000..//" | sed "s/$/\n\n\n/" | sed "1s/^/\n\n/" | sed "s/\r//" > 03-DIALOG.txt

# Fix weird spacing and newlines
paste -d" " 01-NUMBERING.txt 02-TIMING.txt 03-DIALOG.txt | sed "s/^  //" | sed "s/^ //"| sed "s/\\\N/\n/" | sed "s/\\\n/\n/" > $srt

# clean up environment
rm 01-NUMBERING.txt 02-TIMING.txt 03-DIALOG.txt
