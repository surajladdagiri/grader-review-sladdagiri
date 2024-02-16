CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

if [ $# -ne 1 ];
then
    echo "Incorrect number of arguments! Make sure to only provide a git link"
    exit 1
fi


git clone $1 student-submission

if [ $? -ne 0 ];
then
    exit 1
fi
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

if [ -f student-submission/ListExamples.java ];
then
    cp student-submission/ListExamples.java grading-area
    cp TestListExamples.java grading-area

else
    echo "ListExamples.java file not found!! Did you name it right? Is it in a nested folder(It shouldn't be)?"
    exit 1
fi

cd grading-area
javac -cp $CPATH *.java
if [ $? -ne 0 ];
then
    echo "Code doesn't compile, see error above."
    exit 1
fi

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > result.txt

resultLine=$( tail -n 2 result.txt | head -n 1)
check=$( echo $resultLine | awk -F'[( ]' '{print $1}')
if [ $check == "OK" ];
then
    echo "You got a full score!"
else
    tests=$( echo $resultLine | awk -F'[, ]' '{print $3}')
    fail=$( echo $resultLine | awk -F'[, ]' '{print $6}')
    success=$((tests - fail))
    echo "Your score is $success/$tests. You failed $fail test(s)" 
fi