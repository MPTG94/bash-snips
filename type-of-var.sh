#!/bin/bash

typeofvar () {
    
    local type_signature=$(declare -p "$1" 2>/dev/null)
    
    if [[ "$type_signature" =~ "declare --" ]]; then
        echo "string"
        elif [[ "$type_signature" =~ "declare -a" ]]; then
        echo "array"
        elif [[ "$type_signature" =~ "declare -A" ]]; then
        echo "map"
    else
        echo "none"
    fi
    
}

function main() {
    # the basic type in bash is a string
    # there are no integers, nor booleans
    
    a="hello"
    
    typeofvar a # string
    
    b=(array)
    
    typeofvar b # array
    
    declare -A c=([key]=value)
    
    typeofvar c # map
    
    f () {
        echo "is a function"
    }
    
    typeofvar f # none
}

main "$@"
