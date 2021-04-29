#Introduction
Implemented a JavaGrep interface to perform function same as grep command in linux. The program was written with the help of IntelliJ which searches pattern recursively in a given directory and stores the matched lines to output file. 
For the efficient search through the directories and files, stream and lambda expression is used and slf4j to log messages. The Java grep app was packaged using maven and dockerized so that users can easily consume it. 
#Quick Start
The java grep app takes three CLI arguments starting with regular expression for search pattern, followed by root directory path to input file and lastly the output file to store the matched lines.
The program recursively searches for the file in root directory and reads each line of the file to find a match with the regular expression pattern. Once matched, the output is written to a new output file.
* problem: Find all the lines that contain *Romeo* and *Juliet*
###Usage
Java -jar grep-1.0-SNAPSHOT.jar ${Regex_pattern} source_file out_file

#Implementation
##Pseudo code
matchedLines = []
for file in listFilesRecursively(rootDir)
for line in readLines(file)
if containsPattern(line)
matchedLines.add(line)
writeToFile(matchedLines)
##Performance Issue
The program initially loads all the file from a root directory and recursively finds the source file. Here, shakesphere.txt file is used which is of more than 5MB in size. So, when the JVM was loaded with less than 5MB memory (java -Xm5m -Xm5m -cp target/grep-1.0-SNAPSHOT.jar ca.jrvs.apps.grep.JavaGrepImp \
.*Romeo.*Juliet.* ./data ./out/grep.txt ) an OutofMemoryError exception is thrown. 
To resolve the issue the heap size of more than 5MB should at least be allocated. 
#Test
To test the application manually, a source file shakesphere.txt is passed as one of the CLI arguments. As the program executes, matched lines is written in grep.txt file. slf4j is used to log the messages and debug the errors.  
#Deployment
The grep app is dockerize so that users can consume it easily. Maven shade plugin is added in pom.xml and with maven package command uber jar file including all the dependencies is generated. A docker file is created and this uber jar file is copied to newly build local docker image. A docker container runs and executes the grep app. Lastly, docker image is pushed to docker hub. 
#Improvement
- Use the source file in any format - txt,docx,pdf 