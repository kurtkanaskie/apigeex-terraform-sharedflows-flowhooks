#! /bin/bash

for sf in `ls src`
do
	cd src/$sf
	rm $sf.zip
	zip -r $sf.zip sharedflowbundle
	cd -
done