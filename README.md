# Pre-lecture assignment: anagram detection algorithm and its time complexity


Two words are anagrams of each other if they contain the same
characters, that is, they are a rearrangement of each other.

Examples: "mary" and "army", "silent" and "listen", "doctor who" and
"torchwood".

Note that we ignore spaces when checking whether two words are
anagrams.

1. Design an algorithm for efficiently determining whether two words are
   anagrams.

2. Implement the algorithm in Java in a file named Anagram.java in
   your version of this repository. Create a class named `Anagram`
   with the following method.

   ~~~~
   public static boolean anagram(String s1, String s2) { ... }
   ~~~~   

   As usual, test the `anagram` method in the `main` method of your
   Anagram class.

3. What is the big-O time complexity of your anagram detection algorithm?
   Put your answer in a file named README.md in your version of
   this repository.