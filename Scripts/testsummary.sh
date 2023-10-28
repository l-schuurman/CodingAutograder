#!/bin/bash

# Set the path to the directories
script_dir=$(pwd)
parent_dir=$(dirname "$script_dir")

QuizSubmissions="$parent_dir/Autograding/Student"
Solutions="$parent_dir/Autograding/Solution"
OutputCSV="$parent_dir/testsummary.csv"

# Initialize the CSV file with a header
echo "TestID,MatchingOutputs,TotalFilesMatched,PercentageMatching" > "$OutputCSV"

# Loop through solution files in the Solutions directory
for solutionFile in "$Solutions"/*; do
    if [ -f "$solutionFile" ]; then
        solutionID=$(basename "$solutionFile")

        # Initialize counters for matching outputs and total files matched
        matchingComparisons=0
        totalComparisons=0

        # Loop through student directories in QuizSubmissions
        for studentDir in "$QuizSubmissions"/*; do
            if [ -d "$studentDir" ]; then
                studentFile="$studentDir/$solutionID"

                # Check if the student file exists
                if [ -f "$studentFile" ]; then
                    # Compare the solution file with the student file
                    if cmp -s "$solutionFile" "$studentFile"; then
                        matchingComparisons=$((matchingComparisons + 1))
                    fi

                    totalComparisons=$((totalComparisons + 1))
                fi
            fi
        done

        # Calculate the percentage of matching comparisons
        if [ "$totalComparisons" -gt 0 ]; then
            percentage=$((matchingComparisons * 100 / totalComparisons))
        else
            percentage=0
        fi

        # Append the results to the CSV file
        echo "$solutionID,$matchingComparisons,$totalComparisons,$percentage%" >> "$OutputCSV"
    fi
done
