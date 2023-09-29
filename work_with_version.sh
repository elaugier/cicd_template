#!/bin/bash

### Increments the part of the string
## $1: version itself
## $2: number of part: 0 – major, 1 – minor, 2 – patch

increment_version() {
  local delimiter=.
  local array=($(echo "$1" | tr $delimiter '\n'))
  array[$2]=$((array[$2]+1))
  if [ $2 -lt 2 ]; then array[2]=0; fi
  if [ $2 -lt 1 ]; then array[1]=0; fi
  echo $(local IFS=$delimiter ; echo "${array[*]}")
}

### Get the version from the most recent tag for a component
## $1: name of the component
##    eg: component1-v1.0.0 
get_version_from_more_recent_tag_of_component () {
    git tag --sort=-taggerdate | grep "$1" | cut -f 2 -d '-' | sed 's/v//' | head -1
}

get_short_hash () {
    git rev-parse --short HEAD
}

component=composant2
echo $component
old_version=$(get_version_from_more_recent_tag_of_component $component)
echo old version is: $old_version
target_version=$(increment_version $old_version 2)
echo new version is: $target_version
