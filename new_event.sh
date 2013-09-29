#!/bin/bash

read -r -p "Event name > "
title=${REPLY}
read -r -p "Author > "
author=${REPLY}
title_clean="$(<<< "$title" \
    iconv -f utf8 -t ascii//translit \
    | tr ' [:upper:]' '-[:lower:]' \
    | tr -dc 'a-z0-9._-')"

filename="events/$(date "+%Y-%m-%d")-$title_clean.md"
echo "---
title: $title
author: $author
---" > "$filename"

emacs "$filename" &
