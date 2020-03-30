
pythondir=/c/Python34/

cd $pythondir

edwardcustfile=/d/gitrep/Production/AuthorCustmization/AuthorCustmization/filelist.txt

winsourcetreedir="H:\\gitrep\\SourceTreeScript\\SourceTreeScript\\"
winrepodirnodash="H:\\gitrep\\mc-docs-pr.en-us\\"
filefullname=""

while read line
do
	filename=`echo "${line}" | cut -d "	" -f 1`
	filedir=`echo "${line}" | cut -d "	" -f 2`

	filefullname="${filefullname} ${filedir}/${filename}"
	
done <"${edwardcustfile}"

echo "filefullname is ${filefullname}"

./python.exe ${winsourcetreedir}SourceTreeScript.py pantool ${winrepodirnodash} ${filefullname}

