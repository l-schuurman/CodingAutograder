import os
from collections import defaultdict

# Set the path to the directories
script_dir = os.getcwd()
parent_dir = os.path.dirname(script_dir)

QuizSubmissions = os.path.join(parent_dir, "Autograding/Student")
Solutions = os.path.join(parent_dir, "Autograding/Solution")
OutputCSV = os.path.join(parent_dir, "grades.csv")

# Print the parent directory
print(parent_dir)

# Initialize the CSV file with a header
with open(OutputCSV, 'w') as csv_file:
    csv_file.write("StudentID,Test1,Test2,Test3,Test4,Test5,MatchingOutputs,TotalFilesMatched,PercentageMatching\n")

# Loop through student directories in QuizSubmissions
for studentDir in sorted(os.listdir(QuizSubmissions)):
    studentDirPath = os.path.join(QuizSubmissions, studentDir)
    if os.path.isdir(studentDirPath):
        studentID = os.path.basename(studentDirPath)

        # Initialize counters for matching outputs and total files matched
        matchingComparisons = 0
        totalComparisons = 0

        testCounter = defaultdict(int)

        # Loop through all files in the student's directory
        for studentFile in os.listdir(studentDirPath):
            studentFilePath = os.path.join(studentDirPath, studentFile)
            if os.path.isfile(studentFilePath):
                # Get the corresponding solution file
                solutionFilePath = os.path.join(Solutions, studentFile)

                # Check if the solution file exists
                if os.path.isfile(solutionFilePath):
                    # Compare the student's output with the solution
                    with open(studentFilePath, 'rb') as student_file, open(solutionFilePath, 'rb') as solution_file:
                        if student_file.read() == solution_file.read():
                            matchingComparisons += 1

                            # Split the path and filename
                            path, filename = os.path.split(solutionFilePath)

                            # Split the filename using underscores
                            testID = filename.split("_")[0]

                            testCounter[testID] += 1

                    totalComparisons += 1

        # Calculate the percentage of matching comparisons
        if totalComparisons > 0:
            percentage = (matchingComparisons * 100 / totalComparisons)
        else:
            percentage = 0

        print(testCounter)

        # Append the results to the CSV file
        with open(OutputCSV, 'a') as csv_file:
            csv_file.write(f"{studentID},{testCounter['test1']},{testCounter['test2']},{testCounter['test3']},{testCounter['test4']},{testCounter['test5']},{matchingComparisons},{totalComparisons},{percentage}%\n")
