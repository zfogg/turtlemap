#!/bin/bash


SOC_URL="https://ntst.umd.edu/soc/"

PREFIX_LINK_CSS=".course-prefix.row a"

PREFIX_LINK_ATTR="href"


node.io -s query "$SOC_URL" "$PREFIX_LINK_CSS" "$PREFIX_LINK_ATTR" \
  | while read line; do
    echo "$SOC_URL$line"
  done

