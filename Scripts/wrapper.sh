SCRIPT_DIR=$(pwd)

cd ../CodePost
python3 download-from-codePost.py MECHTRON2MP3 Fall2023 "Quiz 3"

cd $SCRIPT_DIR

sh movefiles.sh
sh runallstudentcode.sh

python3 autograder.py

cat ../grades.csv

sh testsummary.sh

cd ..
python3 plot.py
python3 testsummary.py