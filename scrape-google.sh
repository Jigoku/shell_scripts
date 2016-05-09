#!/usr/bin/env bash
#
# dump first 100 results for query
#

QUERY="$@";
AGENT="Mozilla/4.0";
AGENT="Windows; U; Windows NT 5.1; ko; rv:1.9.2.4) Gecko/20100523 Firefox/3.6.4";
for START in '10' '20' '30' '40' '50' '60' '70' '80' '90' '100'
do
	URL="http://www.google.com/search?q=${QUERY}&start=${START}";
	stream=$(curl -A "$AGENT" -skLm 10 "${URL}" | grep -oP '\/url\?q=.+?&amp' | sed 's/\/url?q=//;s/&amp//');
	echo -e "$stream";
done
