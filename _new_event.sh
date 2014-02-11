#!/bin/bash
# Author: Pierre-Antoine Rault (rigelk)
# Sauce: https://gist.github.com/rigelk
# Licence: BSD licence

usage="USAGE ./new_event [editor]"
if [ $1 ]
then
read -r -p "Post name > "
title=${REPLY}
read -r -p "Category > "
cat=${REPLY}
title_clean="$(<<< "$title" \
    iconv -f utf8 -t ascii//translit \
    | tr ' [:upper:]' '-[:lower:]' \
    | tr -dc 'a-z0-9._-')"

filename="_posts/$(date "+%Y-%m-%d")-$title_clean.md"
echo "---
layout: post
title: $title
categories: $cat
---" > "$filename"
$1 $filename
else echo $usage
fi
