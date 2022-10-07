#!/bin/bash

# Write the paths in the CMakeLists.txt
function setup() 
{
    echo "" >> CMakeLists.txt
    echo "set(cpp_dir "PATH TO CPP FILES")" >> CMakeLists.txt
    echo "set(h_dir "PATH TO HEADER FILES")" >> CMakeLists.txt
    echo "include_directories($""{h_dir})" >> CMakeLists.txt
}

# Search for setup lines
ser1="$(grep "cpp_dir " CMakeLists.txt)"
ser2="$(grep "h_dir " CMakeLists.txt)"
ser3="$(grep "include_directories(${h_dir})" CMakeLists.txt)"

# Test to verify the setup lines
if [[ "$ser1" != "cpp_dir " && "$ser2" != "h_dir " && "$ser3" != "include_directories(${h_dir})" ]];
then
    setup
    echo "Setup Initialized."
else
    echo "Setup aleready initialized or a part of setup is aleready in."
fi

# Loop to include libs for every parameters.
for i in "$@"
    do
        echo "" >> CMakeLists.txt
        echo "set("$i"_src $"{cpp_dir}"/"$i".cpp)" >> CMakeLists.txt
        echo "add_library("$i" SHARED $"{$i"_src"}")" >> CMakeLists.txt
        echo "target_link_libraries($"{PROJECT_NAME}" "$i")" >> CMakeLists.txt
    done