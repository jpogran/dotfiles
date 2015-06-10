
targetdir=~/code/dotfiles
linkdir=~

for file in $targetdir/.*
do
	echo "examining $file"
	fname=`basename "$file"`
	if [ "$fname" != "." ] && [ "$fname" != ".." ] && [ "$fname" != ".git" ] && [ ! -h "$HOME/$fname" ]; then
		echo "linking $fname"
		if [ ! -h "$linkdir/$fname" ]; then
			ln -s "$targetdir/$fname" "$linkdir/$fname"
		fi
    fi
done