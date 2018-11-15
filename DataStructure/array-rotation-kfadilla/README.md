# Pre-lecture Assignment: Array Rotation

1. Java Installation

   If your computer does not already have Java Version 8 installed,
   you can download and install it from the following URL:
   
   https://java.com/en/download/

2. Git installation

   If your computer does not already have git installed,
   you can download and install it from the following URL:
   
   https://git-scm.com/downloads
   
3. IntelliJ Project Setup 

    Create a new project using the 'check out from version control'
    option, selecting GitHub and password access. Use the URL for
    your repository for this assignment, something like:
    https://github.com/IUDataStructuresCourse/array-rotation-[username].git
    Verify that the new project is configured properly by building the
    project and then running the test. It should fail with an AssertionFailedError.

4. Implement `rotate`

    Implement a method named `rotate` in the `Main` class in the file
    `Main.java`. The method should rotate the elements of an array to the
    right by one position.  For example, if the input array is the
    following array of integers

    ~~~~
    {7,4,12,53,32}
    ~~~~

    then the method should change the array so that its contents are as follows

    ~~~~
    {32,7,4,12,53}
    ~~~~

    Note that the right-most element, 32, wrapped-around to become the
    first element. Add three more tests with different arrays to the
    `testRotate` method of the `MainTest` class in the `test` directory.

5. Submission
 
    Submit your assignment by committing and pushing it to github.
    Go to the menu 'VCS' > 'Git' > 'Commit Directory ...',
    enter a commit message like 'Hurrah!' and push the 'Commit'
    button, selecting 'Commit and Push' and then again 'Push'
    on the next window.
  
