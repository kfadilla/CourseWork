import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.function.BiPredicate;
import java.util.function.Consumer;

/**
 * TODO: This is your first major task.
 * <p>
 * This class implements a generic unbalanced binary search tree (BST).
 */

public class BinarySearchTree<K> implements Tree<K> {

    /**
     * A Node is a Location (defined in Tree.java), which means that it can be the return value
     * of a search on the tree.
     */

    class Node implements Location<K> {

        protected K data;
        protected Node left, right;
        protected Node parent;
        protected int height;

        /**
         * Constructs a leaf node with the given key.
         */
        public Node(K key) {
            this(key, null, null);
        }

        /**
         * TODO
         * <p>
         * Constructs a new node with the given values for fields.
         */
        public Node(K data, Node left, Node right) {
            this.data = data;
            this.left = left;
            this.right = right;
        }

        /*
         * Provide the get() method required by the Location interface.
         */
        @Override
        public K get() {
            return data;
        }

        /**
         * Return true iff this node is a leaf in the tree.
         */
        protected boolean isLeaf() {
            return left == null && right == null;
        }

        /**
         * TODO
         * <p>
         * Performs a local update on the height of this node. Assumes that the
         * heights in the child nodes are correct. Returns true iff the height
         * actually changed. This function *must* run in O(1) time.
         */
        protected boolean updateHeight() {
            if(left == null && right == null) {
                if (height != 0) {
                    height = 0;
                    return true;
                } else {
                    return false;
                }
            } else if (left == null) {
                if (height != right.height + 1) {
                    height = right.height + 1;
                    return true;
                } else {
                    return false;
                }
            } else if (right == null) {
                if (height != left.height + 1) {
                    height = left.height + 1;
                    return true;
                } else {
                    return false;
                }
            } else if (Math.max(left.height, right.height)+1 != height) {
                height = Math.max(left.height, right.height) + 1;
                return true;
            } else {
                return false;
            }
        }

        /**
         * TODO
         * <p>
         * Returns the location of the node containing the inorder predecessor
         * of this node.
         */
        public Node getBefore() {
            if(left != null)
                return left.largest();
            else
                return smallerAncestor(this);
        }

        /**
         * TODO
         * <p>
         * Returns the location of the node containing the inorder successor
         * of this node.
         */
        public Node getAfter() {
            if(right != null)
                return right.smallest();
            else
                return greaterAncestor(this);
        }

        private Node smallerAncestor(Node q) {
            if (q.parent == null)
                return null;
            else if(q.parent.right == q)
                return q.parent;
            else
                return smallerAncestor(q.parent);
        }

        private Node greaterAncestor(Node q) {
            if (q.parent == null)
                return null;
            else if(q.parent.left == q)
                return q.parent;
            else
                return greaterAncestor(q.parent);
        }

        protected Node smallest() {
            if (left != null)
                return left.smallest();
            else
                return this;
        }

        private Node largest() {
            if (right != null)
                return right.largest();
            else
                return this;
        }

        public Node insert(K key, BiPredicate<K, K> pred) {
            Node n;
            if (data == key) {
                return null;
            } else {
                if (pred.test(key, data)) {
                    if (left == null) {
                        left = new Node(key, null, null);
                        left.height = 0;
                        left.parent = this;
                        n = left;
                    } else {
                        n = left.insert(key, pred);
                    }
                } else {
                    if (right == null) {
                        right = new Node(key, null, null);
                        right.height = 0;
                        right.parent = this;
                        n = right;
                    } else {
                        n = right.insert(key, pred);
                    }
                }
            }
            updateHeight();
            return n;
        }

        public Node search(K key, BiPredicate<K, K> pred) {
            if (data == key) {
                return this;
            } else {
                if(pred.test(key, data)) {
                    if (left != null)
                        return left.search(key, pred);
                    else
                        return null;
                } else {
                    if (right != null)
                        return right.search(key, pred);
                    else
                        return null;
                }

            }
        }
        public void inOrder(Consumer<K> f) {
            if(left != null)
                left.inOrder(f);
            f.accept(data);
            if(right != null)
                right.inOrder(f);
        }
        public String toString() {
            return toStringPreorder(this);
        }

    }

    protected Node root;
    protected int numNodes;
    protected BiPredicate<K, K> lessThan;

    /**
     * Constructs an empty BST, where the data is to be organized according to
     * the lessThan relation.
     */
    public BinarySearchTree(BiPredicate<K, K> lessThan) {
        this.lessThan = lessThan;
    }

    /**
     * TODO
     * <p>
     * Looks up the key in this tree and, if found, returns the
     * location containing the key.
     */
    public Node search(K key) {
        if (root == null)
            return null;
        else
            return root.search(key, lessThan);
    }

    /**
     * TODO
     * <p>
     * Returns the height of this tree. Runs in O(1) time!
     */
    public int height() {
        return get_height(root);
    }

    protected int get_height(Node n) {
        if(n == null)
            return -1;
        else
            return n.height;
    }
    /**
     * TODO
     * <p>
     * Clears all the keys from this tree. Runs in O(1) time!
     */
    public void clear() {
        root = null;
        numNodes = 0;
    }
    /**
     * Returns the number of keys in this tree.
     */
    public int size() {
        return numNodes;
    }

    /**
     * TODO
     * <p>
     * Inserts the given key into this BST, as a leaf, where the path
     * to the leaf is determined by the predicate provided to the tree
     * at construction time. The parent pointer of the new node and
     * the heights in all node along the path to the root are adjusted
     * accordingly.
     * <p>
     * Note: we assume that all keys are unique. Thus, if the given
     * key is already present in the tree, nothing happens.
     * <p>
     * Returns the location where the insert occurred (i.e., the leaf
     * node containing the key), or null if the key is already present.
     */
    public Node insert(K key) {
        if (root == null) {
            root = new Node(key, null, null);
            root.parent = null;
            root.height = 0;
            numNodes++;
            return root;
        } else {
            Node n = root.insert(key, lessThan);
            if(n != null)
                numNodes++;
            return n;
        }
    }

    /**
     * Returns true iff the given key is in this BST.
     */
    public boolean contains(K key) {
        Node p = search(key);
        return p != null;
    }

    /**
     * TODO
     * <p>
     * Removes the key from this BST. If the key is not in the tree,
     * nothing happens.
     */
    public void remove(K key) {
        remove_helper(key, root, lessThan);
    }
    public void remove_helper(K key, Node n, BiPredicate<K, K> pred) {
        if (n == null) {
            return;
        } else if (pred.test(key, n.data)) {
            remove_helper(key, n.left, pred);
        } else if (pred.test(n.data, key)) {
            remove_helper(key, n.right, pred);
        } else {
            if (n.left == null && n.right == null) {
                if (n == root)
                    root = null;
                else if (n.parent.left == n)
                    n.parent.left = null;
                else
                    n.parent.right = null;
            } else if(n.left == null) {
                n.data = n.right.data;
                n.left = n.right.left;
                n.right = n.right.right;
            } else if (n.right == null) {
                n.data = n.left.data;
                n.right = n.left.right;
                n.left = n.left.left;
            } else {
                Node after = n.getAfter();
                n.data = after.data;
                if(after.parent.left == after)
                    after.parent.left = null;
                else
                    after.parent.right = null;

            }
            numNodes--;
        }
        n.updateHeight();
    }
    /**
     * TODO
     * <p>
     * Returns a sorted list of all the keys in this tree.
     */
    public List<K> keys() {

        List<K> kList = new ArrayList<>();
        Consumer<K> cons = new Consumer<K>() {
            @Override
            public void accept(K k) {
                kList.add(k);
            }
        };
        if (root != null)
            root.inOrder(cons);
        return kList;
    }

    private String toStringInorder(Node p) {
        if (p == null)
            return ".";
        String left = toStringInorder(p.left);
        if (left.length() != 0) left = left + " ";
        String right = toStringInorder(p.right);
        if (right.length() != 0) right = " " + right;
        String data = p.data.toString();
        return "(" + left + data + right + ")";
    }

    private String toStringPreorder(Node p) {
        if (p == null)
            return ".";
        String left = toStringPreorder(p.left);
        if (left.length() != 0) left = " " + left;
        String right = toStringPreorder(p.right);
        if (right.length() != 0) right = " " + right;
        String data = p.data.toString();
        return "(" + data + "[" + p.height + "]" + left + right + ")";
    }

    /**
     * Returns a textual representation of this BST.
     */
    public String toString() {
        return toStringPreorder(root);
    }
}
