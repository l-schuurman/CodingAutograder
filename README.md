# CodingAutograder
The folder hierarchy of the tool is as follows:

- CodingAutograder
  - Autograding
    - Solution
    - Student
  - CodePost
    - *<assignment_name>*
  - Scripts
  - Submissions
    - Solution
    - Student


## Workflow
Note: All scripts should be run from inside the `Scripts/` folder.

A standard workflow is as follows:
- Run `CodePost/download-from-codePost.py` [Modified from original](https://github.com/codepost-io/download-from-codePost)
  - Example: `python3 download-from-codePost.py MECHTRON2MP3 Fall2023 "Quiz 3"`
  - This will download all assignments through the CodePost API
  - Make sure to install the CodePost library and setup the CodePost API Key in line 7
    - See [API Docs](https://docs.codepost.io/reference/welcome-api-v10)

- Run `Scripts/movefiles.sh`
  - This will move all assignments from `CodePost/<assignment_name>/MACID@mcmaster.ca/*` to `Submissions/Student/MACID.c`

- Run `Scripts/runallstudentcode.sh`
  - This will run all the student code with test cases and store the executable and test case results in `Autograding/Student/MACID/`

- **Current Limitation**
  - Solutions flow has not been set up independently. Take your solutions file, run it as if you were a student, and copy all test case output to `Autograding/Solution/`

- Run `Scripts/autograder.py`
  - This will compare all student test cases with the solution test cases

- Run `Scripts/testsummary.sh`
  - This will track the pass rate of the the test cases

- Run `plot.py` and `testsummary.py` to generate graphs of the student grades and test case pass rate