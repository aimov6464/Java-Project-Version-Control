cd "project-$1/opt/"
echo "<files>" > ../index$1.xml

for file in 'find -type f'
do
  filezip="$file.zip"
  zip -9 -j -X -y "$filezip" "$file"

  zipsize=$(stat -c%s "$filezip")
  filesize=$(stat -c%s "$file")

  crczip=$(crs32 "$filezip")
  crc=$(crc32 "$file")

  #if (($zipsize < $filesize))
  #then
    rm "$file"
    echo "<file crc32rar=\"$crczip\" crc32=\"$crc\" len=\"$filesize\">${file:2}</file>" >> ../index$1.xml
  #else
    #rm "$filezip"
    #echo "<file crc32=\"$crc\" len=\"$filesize\">${file:2}</file>" >> ../index0.xml
  #fi
done

echo "</files>" >> ../index$1.xml

mv ../index$1.xml index$1.xml

sed -ni 'H;${x;s/&/&amp;/g;p}' index$1.xml

zip -9 index$1.xml.zip index$1.xml

cd ..
cd ..
cd ..
mv project-$1/opt/sopme-copmany-name LAS$1