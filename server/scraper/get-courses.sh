#!/bin/bash


while read line; do
  node.io -s query "$line" '.course-id';
done

