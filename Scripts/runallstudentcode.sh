#!/bin/bash

# Get the directory of the script
# script_dir=$(dirname "$0") # .
script_dir=$(pwd)

# Set the path to the test case results directory
results_dir="$script_dir/../Autograding/Student"

# Directory containing student C files
cfiles_dir="$script_dir/../Submissions/Student"

# Compile and execute C files with naming convention macid.c
for cfile in "$cfiles_dir"/*.c; do
   if [ -f "$cfile" ]; then
      macid=$(basename "$cfile" | sed -n 's/^\(.*\)\.c$/\1/p')

      # Create a subdirectory for the current MACID
      test_case_dir="$results_dir/$macid"

      mkdir -p "$test_case_dir"

      # Compile the C file
      gcc -o "$test_case_dir/program" "$cfile"

      if [ $? -eq 0 ]; then
         # Run the C program 20 times with different integer values
         for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20; do
               # Generate a random integer value (modify the range as needed)
               value=$i
               echo $value

               # Run the program with the integer value and capture the output
               cd $test_case_dir
               echo $PWD
               ./program "$value" > /dev/null

               echo "Executed $macid with value $value (Result saved to $output)"
         done
      else
         echo "Compilation of $macid's program failed"
      fi
   fi
done
