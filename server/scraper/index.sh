#!/bin/bash


cd "$(dirname "$0")"

./get-prefixes.sh               | \
  sort -R                       | \
  ./get-courses.sh 2>/dev/null  | \
  ./get-course.coffee

