#!/usr/bin/env bash
# https://github.com/drduh/blocklists/blob/master/generate-easylists.sh

LC_ALL=C

for list in $(find corporations -type f \
	! -name "README*" ! -name "*.easylist*" ! -name "*.ipv6") ; do

	easylist="${list}.easylist" && printf "creating %s\n" "${easylist}"

	printf "[Adblock Plus 2.0]\n" > "${easylist}"
	for ip in $(grep "0.0.0.0" ${list} | awk '{print $2}' | sort) ; do
		for mod in \^ \^\$popup \^\$third-party ; do
			printf "||%s%s\n" "${ip}" "${mod}"
		done
	done >> "${easylist}"
done
