#! /bin/bash

/bin/bash clean.sh

cat /dev/null > failed-tests

if [ ! "$AUTOBUILD" ]; then
	AUTOBUILD=autobuild
fi
for i in $(find . -maxdepth 2 -mindepth 2)
do
	if [ ! -d "$i" ] || [ ! -d "$i/autobuild" ]; then
		continue
	fi
	echo "=================================================================="
	echo "Running test $i"
	echo "=================================================================="
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
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" >&2
		echo "Test $i FAILED" >&2
		echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" >&2
		echo "$i" >> failed-tests
	fi
done
