#! /bin/bash

cat /dev/null > failed-tests

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
	if "$AUTOBUILD"; then
		FAIL=0
	else
		FAIL=1
	fi
	if [ -e "EXPECT_FAILURE" ]; then
		if [ "$FAIL" = "1" ]; then
			FAIL=0
		else
			FAIL=1
		fi
	fi
	popd > /dev/null
	if [ "$FAIL" = "1" ]; then
		echo "Test $i FAILED" >&2
		echo "$i" >> failed-tests
	fi
done
