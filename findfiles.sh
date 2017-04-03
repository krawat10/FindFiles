#!\bin\bash
{
FILENAME=
FOLDERNAME=
SIZEBT=
SIZELT=
DATE=
CONTENT=
red=`tput setaf 1`
clean=`tput sgr0`
menu(){
 echo "Search files"
 echo "1. Filename: ${red} $FILENAME ${clean}"
 echo "2. Folder name: ${red}  $FOLDERNAME ${clean}"
 echo "3. Size (bigger than): ${red} $SIZEBT ${clean}"
 echo "4. Size (smaller than): ${red} $SIZELT ${clean}"
 echo "5. Modified X day ago: ${red} $DATE ${clean}"
 echo "6. File content: ${red} $CONTENT ${clean}"
 echo "7. SEARCH"
 echo "8. EXIT"
 
}

next(){
echo -en "\ec"
menu
echo "Select next option(1-8)"
}

filename(){
echo "Imput filename: "
read FILENAME
}

folderpath(){
echo "Input catalouge path: "
read FOLDERNAME
}

biggersize(){
echo "Input min. size: "
read SIZEBT
}

lesssize(){
echo "Input max. size: "
read SIZELT
}

created(){
echo "Input max. day of file"
read DATE
}

fileContent(){
echo "Input file content"
read CONTENT
}

findfiles(){
$TMP
if [[ ! $FOLDERNAME ]] ; then
FOLDERNAME='.'
fi

if [[ ! $FILENAME ]] ; then
FILENAME="*"
fi

if [[ ! $SIZEBT ]] ; then
SIZEBT=0
fi

if [[ ! $SIZELT ]] ; then
SIZELT=10000000
fi

if [[ ! $DATE ]] ; then
DATES='+0'
else
DATES="-$DATE"
fi 



find ../$FOLDERNAME -name ''"$FILENAME"'' -type f -size +$SIZEBT -size -$SIZELT -mtime $DATES -exec grep -H ''"$CONTENT"'' {} \; | sed "s/\:.*//" | sort | uniq -c
}

loop(){
echo -en "\ec"
menu
OPTION=
until [ "$OPTION" = "8" ]; do
read OPTION
case $OPTION in 
1 ) echo "Search by filename" ; filename ;  next ;; 
2 ) echo "Search by folder patch" ; folderpath ; next ;;
3 ) echo "Search by minimum size" ; biggersize ; next ;;
4 ) echo "Search by maximum size" ; lesssize ; next ;;
5 ) echo "Search by days of last modified" ; created ; next ;;
6 ) echo "Search by file content" ; fileContent ; next ;;
7 ) echo "Result: " ; findfiles ;;
8 ) echo "EXIT";;
esac
done



}
menu
loop

}
