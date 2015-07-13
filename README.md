# Data Science Project
Group Project for Data Science course.

## User-defined functions
In order to create more UDF's you can create them in the /udfs folder. In order to compile them, you should first execute the following statements in the root directory of this repository:
```
$ svn co http://svn.apache.org/repos/asf/hadoop/pig/trunk
$ cd trunk
$ ant
```
A pig.jar file should be built in the trunk directory. It can be named different, then rename it to pig.jar. Make sure you have set the HADOOP_CLASSPATH variable. To know the value it should have:
```
$ hadoop classpath
```
Then, you can compile your (and the other) UDF's as follow starting from the root directory:
```
$ cd trunk
$ javac -cp pig.jar:$HADOOP_CLASSPATH ../udfs/udf1.java ../udfs/udf2.java
$ cd ../
$ jar -cf udfs.jar udfs
```
Now, the udfs.jar file can be included in the pig-files to call the UDF's.

## Visualization

The d3.js based visualization of the result is located on the folder viz. Open the `index.html` to edit the visualization.

To test on your local browser, run any http server beforehand, such as
```
python -m SimpleHTTPServer 8000
```

then open browser with url `localhost:8000`. The visualization is running live on following [link](http://homepage.tudelft.nl/9k0y3/).
