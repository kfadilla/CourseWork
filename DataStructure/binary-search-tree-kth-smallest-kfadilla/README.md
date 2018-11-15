# Lab - Binary Search Tree, kth smallest

Modify the `BinarySearchTree` class by adding a method named `kth_smallest`
that finds the kth smallest key inside the tree in O(log n) time.
If there is no kth smallest element (because the
BST is not big enough), then throw an `Exception`.
For example, consider the following binary search tree.

    ~~~~
          8
        /  \
       /    \
      3     10
     / \      \
    1   6      14
       / \    /
      4   7  13
    ~~~~

The k=0 smallest key is 1, the k=3 smallest key is 6, and the k=7 smallest key is 13.
(The k's start at 0.)

Hint: `BSTNode` should keep a count of the number of nodes in
its left subtree. This may require changing or adding code in several
places with the `BSTNode` and `BinarySearchTree` classes.

