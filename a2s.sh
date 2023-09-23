
input=$1

srt=`echo $input | sed "s/ass/srt/"`


# Get numbering
echo 1 `grep -a "Dialogue:" "$input" | wc -l` | sed "s/^/seq /" | sh |
sed "s/  //g" | sed "s/$/\n\n\n/" > 01-NUMBERING.txt

# Timing
grep -a "Dialogue:" "$input" | sed "s/,/[REMOVE0]/1"  | sed "s/,/[REMOVE1]/2" |
sed "s/.*.\[REMOVE0\]//" | sed "s/\[REMOVE1\].*.//" | sed "s/,/0 --> 0/" |
sed "s/\./,/g" | sed "s/$/0/" | sed "s/$/\n\n\n/" | sed "1s/^/\n/" > 02-TIMING.txt


# Get the text.. I think this will work.
grep -a "Dialogue:" "$input" | sed "s/,/[REMOVE]/9" | sed "s/.*.\[REMOVE\]//" |
sed "s/$/\n\n\n/" | sed "1s/^/\n\n/" | sed "s/\r//" > 03-DIALOG.txt

# Formatting issues:
#       * Weird spacing
#       * Convert newlines
#       * Remove \{k values (SLOPPY TODO: Make smaller.)
#       * Remove extra \{ values -- (This may be a poor decision. REMOVE IF NEEDED: "/{.*.}//")
paste -d" " 01-NUMBERING.txt 02-TIMING.txt 03-DIALOG.txt | sed "s/^  //" |
sed "s/^ //" | sed "s/{.k.}//g" | sed "s/{.k..}//g" | sed "s/{.k...}//g" |
sed "s/{.k....}//g" | sed "s/{.*.}//" | sed "s/\\\N/\n/g" | sed "s/\\\n/\n/" |
sed "s/  $//" > $srt

# clean up environment
rm 01-NUMBERING.txt 02-TIMING.txt 03-DIALOG.txt
