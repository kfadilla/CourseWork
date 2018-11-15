# Lab 1: Average Rainfall

1. Java Installation

    If your computer does not already have Java Version 8 installed,
    you can download and install it from the following URL:
   
    https://java.com/en/download/

2. Git installation

    If your computer does not already have git installed, you can download and install it from the following URL:

    https://git-scm.com/downloads

3. IntelliJ Project Setup

   Create a new project using the menu 'File' > 'New' > 'Project from Version Control'
   selecting GitHub and password access. Use the URL for your repository for this assignment,
   something like: https://github.com/IUDataStructuresCourse/lab-1-average-rainfall-[username].git
   Verify that the new project is configured properly by building the
   project and then running the test. It should fail with an AssertionFailedError.

4. Implement `average_rainfall`

   In file `Main.java`, mplement the method named `average_rainfall` that
   takes as input an array of integers (int) and returns the average
   (double). The input array represents daily rainfall amounts.  The
   array may contain the number -999 indicating the end of the data of
   interest, so you must ingore integers that follow -999.  Return the
   average of the non-negative values in the array up to the first
   -999 (if it shows up). (There may be negative numbers other than
   -999 in the sequence.) If for some reason it is impossible to 
   compute the average rainfall, throw an IllegalArgumentException.
   Test your program on diverse inputs that
   exercise the different parts of your code and fix the bugs that you
   find.  Put your tests in the class `MainTest` in the `test` diretory.

5. Submission

   Submit your assignment by committing and pushing it to github.
   Go to the menu 'VCS' > 'Git' > 'Commit Directory ...',
   enter a commit message like 'Hurrah!' and push the 'Commit'
   button, selecting 'Commit and Push' and then again 'Push'
   on the next window. Verify on github.com that the push was successfull 
   and contains your working program.
