package ca.jrvs.apps.grep;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class JavaGrepLambdaImp extends JavaGrepImp{

  public static void main(String[] args) {
    if(args.length != 3) {
      throw new IllegalArgumentException("USAGE: JavaGrep regex rootPath outFile");
    }

    JavaGrepLambdaImp javaGrepLambdaImp = new JavaGrepLambdaImp();
    javaGrepLambdaImp.setRegex(args[0]);
    javaGrepLambdaImp.setRootPath(args[1]);
    javaGrepLambdaImp.setOutFile(args[2]);

    try {
      javaGrepLambdaImp.process();
    } catch (Exception ex) {
      javaGrepLambdaImp.logger.error("Please provide valid regex pattern, rootPath and outFile", ex);
    }
  }

 @Override
  public List<File> listFiles(String rootDir) {
   File rootDirFile = new File(rootDir);
   File[] files = rootDirFile.listFiles();

   if(files == null) {
     return new ArrayList<>();
   }
   return Arrays.stream(files).flatMap(file -> {
     if(file.isDirectory()) {
       return listFiles(file.getAbsolutePath()).stream();
     } else {
       return new ArrayList<File>(){{
         add(file);
       }}.stream();
     }
   }).collect(Collectors.toList());

 }

 @Override
  public List<String> readlines(File inputFile) throws IllegalArgumentException {
   List<String> fileLines = new ArrayList<>();
    try {
      Stream<String> linesStream = Files.lines(inputFile.toPath());
      linesStream.forEach(line -> fileLines.addAll(Collections.singleton(line)));
    }catch (IOException ex) {
      logger.error("Please provide valid argument", ex);
    }
    return fileLines;
  }
}
