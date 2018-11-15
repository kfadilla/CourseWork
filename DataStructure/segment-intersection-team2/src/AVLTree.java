import java.util.function.BiPredicate;

import static java.lang.Math.abs;

/**
 * TODO: This is your second major task.
 * <p>
 * This class implements a generic height-balanced binary search tree,
 * using the AVL algorithm. Beyond the constructor, only the insert()
 * and remove() methods need to be implemented. All other methods are unchanged.
 */

public class AVLTree<K> extends BinarySearchTree<K> {

    /**
     * Creates an empty AVL tree as a BST organized according to the
     * lessThan predicate.
     */
    public AVLTree(BiPredicate<K, K> lessThan) {
        super(lessThan);
    }

    /**
     * TODO
     * Inserts the given key into this AVL tree such that the ordering
     * property for a BST and the balancing property for an AVL tree are
     * maintained.
     */
    public Node insert(K key) {
        Node inserted = super.insert(key);
        updateTree();
        return inserted;
    }


    private void updateTree(){
        Node unbalanced = minNotAVL();
        while (unbalanced != null) {
            Node left = unbalanced.left;
            Node right = unbalanced.right;
            if(left == null) {
                if (right.right == null || right.left != null && right.right.height < right.left.height) {
                    shiftRight(right);
                    shiftLeft(unbalanced);
                } else {
                    shiftLeft(unbalanced);
                }
            } else if (right == null) {
                if(left.left == null || left.right != null && left.left.height < left.right.height) {
                    shiftLeft(left);
                    shiftRight(unbalanced);
                } else {
                    shiftRight(unbalanced);
                }
            } else if (left.height > right.height) {
                if(left.left.height < left.right.height) {
                    shiftLeft(left);
                    shiftRight(unbalanced);
                } else {
                    shiftRight(unbalanced);
                }
            } else {
                if (right.left.height < right.right.height) {
                    shiftLeft(unbalanced);
                } else {
                    shiftRight(right);
                    shiftLeft(unbalanced);
                }
            }
            unbalanced = minNotAVL();
        }
    }
    private void shiftRight(Node n) {

        n.right = new Node(n.data, n.left.right, n.right);
        if (n.right.right != null) {
            n.right.right.parent = n.right;
            n.right.right.updateHeight();
        }
        if(n.right.left != null) {
            n.right.left.parent = n.right;
            n.right.left.updateHeight();
        }
        n.right.parent = n;

        n.data = n.left.data;
        n.left = n.left.left;
        if (n.left != null)
            n.left.parent = n;
        if (n.left != null)
            n.left.updateHeight();
        if (n.right != null)
            n.right.updateHeight();
        n.updateHeight();
    }

    private void shiftLeft(Node n) {

        n.left = new Node(n.data, n.left, n.right.left);
        if (n.left.left != null) {
            n.left.left.parent = n.left;
            n.left.left.updateHeight();
        }
        if (n.left.right != null) {
            n.left.right.parent = n.left;
            n.left.right.updateHeight();
        }
        n.left.parent = n;

        n.data = n.right.data;
        n.right = n.right.right;
        if (n.right != null)
            n.right.parent = n;
        if (n.left != null)
            n.left.updateHeight();
        if (n.right != null)
            n.right.updateHeight();
        n.updateHeight();
    }

    private Node minNotAVL() {
        Node current = notAVL(root);
        if (current == null) {
            return null;
        } else {
            Node previous = current;
            current = notAVL(current);
            while (current != null) {
                previous = current;
                if(current.left == null) {
                    current = notAVL(current.right);
                } else if (current.right == null) {
                    current = notAVL(current.left);
                } else {
                    if (current.left.height < current.right.height) {
                        current = notAVL(current.right);
                    } else {
                        current = notAVL(current.left);
                    }
                }
            }
            return previous;
        }
    }
    private Node notAVL(Node n) {
        if (n.left == null && n.right == null) {
            return null;
        } else if (n.left == null) {
            if (n.right.height == 0)
                return null;
            else
                return n;
        } else if (n.right == null) {
            if (n.left.height == 0)
                return null;
            else
                return n;
        } else if (abs(n.left.height - n.right.height) <= 1) {
            Node left = notAVL(n.left);
            Node right = notAVL(n.right);
            if (left == null && right == null) {
                return null;
            } else if (left != null) {
                return left;
            } else {
                return right;
            }
        } else {
            return n;
        }
    }
    public K test() {
        return minNotAVL().data;
    }

    public void remove(K key) {
        root = remove_helper(root, key);
    }

    private Node delete_min(Node n) {
        if (n.left == null) {
            return n.right;
        } else {
            n.left = delete_min(n.left);
            return n;
        }
    }

    private Node get_min(Node n) {
        if (n.left == null) return n;
        else return get_min(n.left);
    }

    private Node remove_helper(Node n, K key) {
        Node updated;
        if (n == null) {
            updated = null;
        } else if (lessThan.test(key, n.data)) {
            n.left = remove_helper(n.left, key);
            updated = n;
        } else if (lessThan.test(n.data, key)) {
            n.right = remove_helper(n.right, key);
            updated = n;
        } else {
            numNodes--;
            if (n.left == null) {
                if (n.right != null)
                    n.right.parent = n.parent;
                updated = n.right;
            } else if (n.right == null) {
                if (n.left != null)
                    n.left.parent = n.parent;
                updated = n.left;
            } else {
                Node min = get_min(n.right);
                n.data = min.data;
                n.right = delete_min(n.right);
                updated = n;
            }
        }
        n.updateHeight();
        return updated;
    }

}
