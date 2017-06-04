#! /bin/bash
if [ ! "$AUTOBUILD" ]; then
	AUTOBUILD=autobuild
fi
for i in $(find . -maxdepth 2 -mindepth 2)
do
	if [ ! -d "$i" ] || [ ! -d "$i/autobuild" ]; then
		continue
	fi
	echo "Running test $i"
	pushd $i > /dev/null
	"$AUTOBUILD"
	popd > /dev/null
done
