while [true] 
do
cd ~/.trashCan
md5sum * > .file1
if (! diff -rq .file1 .file2); then
{
clear
echo "Changes were detected" >> .file3
comm -3 <(sort .file1) <(sort .file2) | awk '{ printf "%s\n", $filename }' >> .file3
cat .file1 > .file2
}
else echo "No changes were made in the Trash Can for the past 15 secs" >> .file3
fi
sleep 15;
clear
cat  ~/.trashCan/.file3
done
