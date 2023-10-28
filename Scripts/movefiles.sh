#!/bin/bash

# Source directory where the subfolders with C files are located
source_dir="$PWD/../CodePost/Quiz 3"

# Destination directory where you want to copy all C files
destination_dir="$PWD/../Submissions/Student"

echo $destination_dir

# Loop through subdirectories with the naming convention "MACID@mcmaster.ca"
for student_dir in "$source_dir"/*@mcmaster.ca; do
    if [ -d "$student_dir" ]; then
        # Extract the MACID from the subdirectory name
        macid=$(basename "$student_dir" | sed -n 's/\(.*\)@mcmaster.ca/\1/p')

        # Copy the C file from the subdirectory to the destination directory with the new name
        if [ -f "$student_dir"/* ]; then
                    echo $student_dir

            cp "$student_dir"/* "$destination_dir/$macid.c"
            echo $student_dir
            echo "Copied and renamed $macid.c"
        fi
    fi
done

echo "All C files have been copied to $destination_dir"
