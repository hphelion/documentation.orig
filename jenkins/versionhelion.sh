#!/bin/bash -li

original_files=""
renamed_files=""

for i in `find . -path ./redirects -prune -o -name "*.md"`

do

	if [[ -n $(head -50 $i | grep -E '(^#[^#]|^ *#[^#])' | grep "HP Helion" | grep -v "Public Cloud" | grep -v "CloudSystem") ]]; then

		if [[ -n $(grep  "published: false" $i) ]]; then
		   echo "Not published--skipping: $i"
		else
			echo " " 
			newname=`echo $i | sed -r 's:(.*)/:\1/1.1:g'`
			original_files=$original_files" "$i
			git mv $i $newname
			renamed_files=$renamed_files" "$newname
			echo "old name = $i"
			echo "new name = $newname"
			
			#insert version 1.1 in H1 string
			sed -i  's/\(^#[^#]*HP Helion\)/\1 1.1/' $newname
			
			#get the old permailink
			old_permalink=""
			old_permalink=`grep permalink $newname | head -1 | sed 's/[^/]*//'`
			echo $old_permalink
			
			#change permalink in renamed file
			sed -i 's|permalink: /helion/|permalink: /helion1.1/|g' $newname
			sed -i 's|permalink: /als/v1/|permalink: /als/v1.1/|g' $newname #???check with jayme
		
			#get the new permalink
			new_permalink=""
			new_permalink=`grep permalink $newname | head -1 | sed 's/[^/]*//'`
			
			echo $new_permalink
			
			#change permalink in all files
			for a in `find . -path ./redirects -prune -o -name "*.md"`
				do
					if [[ -n $(grep "$old_permalink" $a) ]]; then
						sed -i  "s:]($old_permalink:]($new_permalink:g"  $a 
						sed  -i "s:href=\"$old_permalink:href=\"$new_permalink:g"  $a 
						sed  -i "s:docs.hpcloud.com$old_permalink:docs.hpcloud.com$new_permalink:g"   $a 
						 
					fi			
				done
			fi
	else
		echo "No filename or permalink change for $i"
	fi
 
done

git add .
git commit -m "Create copy of existing Helion documentation and add 1.1 version string" .


for i in `echo $original_files`
do
	touch $i
	git checkout master -- $i
done

git add .
git commit -m "Merge 1.0 doc back to dev" . 