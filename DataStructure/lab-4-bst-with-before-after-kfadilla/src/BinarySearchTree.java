import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.function.BiPredicate;
//completed.
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
            if (this.height == 1 + Integer.max(get_height(this.left), get_height(this.right))){
                return true;
            } else{
                this.height = 1 + Integer.max(get_height(this.left), get_height(this.right));
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
            if (this.left != null){
                return this.left.largest();
            } else {
                if (this.parent == null){
                    return null;
                } else {
                    return smallerAncestor(this);
                }
            }
        }

        /**
         * TODO
         * <p>
         * Returns the location of the node containing the inorder successor
         * of this node.
         */
        public Node getAfter() {
            if (this.right != null){
            return this.right.smallest();
        } else {
                if (this.parent == null){
                    return null;
                }else {
                    return greaterAncestor(this);
                }
        }
        }

        /**
         * TODO
         * <p>
         * This method should return the closest ancestor of node q
         * whose key is less than q's key. It is not necessary to
         * to perform key comparisons to implement this method.
         */
        private Node smallerAncestor(Node q) {
            if (q.parent != null && q == q.parent.left){
                return smallerAncestor(q.parent);
            }
            else{
                return q.parent;
            }

        }

        /**
         * TODO
         * <p>
         * This method should return the closest ancestor of node q
         * whose key is greater than q's key. It is not necessary to
         * to perform key comparisons to implement this method.
         */
        private Node greaterAncestor(Node q) {
            if (q.parent != null && q == q.parent.right){
                return greaterAncestor(q.parent);
            }
            else{
                return q.parent;
            }
        }

        /*
         * TODO
         * This method should return the node in the subtree rooted at 'this'
         * that has the smallest key.
         */
        protected Node smallest() {
            Node result;
            if (this.left != null){
                result = this.left.smallest();
            } else{
                result = this;
            }
            return result;
        }

        /*
         * TODO
         * This method should return the node in the subtree rooted at 'this'
         * that has the largest key.
         */
        private Node largest() {
            Node result;
            if (this.right != null){
                result = this.right.largest();
            } else {
                result = this;
            }
            return result;
        }

        public String toString() {
            return toStringPreorder(this);
        }

    }

    protected Node root;
    protected int numNodes;
    protected BiPredicate<K, K> lessThan;
    public List<K>list = new ArrayList<K>();

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

    public Node search(K key){
        return search_helper(root, key);
    }
    public Node search_helper(Node n, K key) {
        if (n == null){
            return null;
        } else if (lessThan.test(n.data, key)) {
            return search_helper(n.right, key);
        } else if (lessThan.test(key,n.data)){
            return search_helper(n.left, key);
        } else {
            return n;
        }
    }

    /**
     * Returns the height of this tree. Runs in O(1) time!
     */
    public int height() {
        return get_height(root);
    }

    /**
     * TODO
     * The get_height method returns the height of the Node n, which may be null.
     */
    protected int get_height(Node n) {
        if (n == null)
        {
            return -1;
        }
        else
        {
            return n.height;
        }
    }

    /**
     * TODO
     * <p>
     * Clears all the keys from this tree. Runs in O(1) time!
     */
    public void clear() {
        root = null;
        numNodes = 0;
        list= new ArrayList<K>();
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

    public Node insert(K key){
        if (root == null){
            root = new Node(key, null, null);
            root.updateHeight();
            numNodes++;
            return root;
        } else {
            return insert_helper(root, key);
        }
    }

    public Node insert_helper(Node n, K key) {
         if (lessThan.test(key, n.data)) {
             if (n.left == null) {
                 Node temp = new Node(key, null, null);
                 n.left = temp;
                 temp.parent = n;
                 n.updateHeight();
                 numNodes++;
                 return temp;
             } else {
                  Node x = insert_helper(n.left, key);
                  n.updateHeight();
                  return x;
             }
         }
         if (lessThan.test(n.data, key)) {
             if (n.right == null) {
                 Node temp = new Node(key, null, null);
                 n.right = temp;
                 temp.parent = n;
                 n.updateHeight();
                 numNodes++;
                 return n.right;
             } else {
                 Node x = insert_helper(n.right, key);
                 n.updateHeight();
                 return x;
             }
         } else {
             return null;
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
    public Node child(Node n){
        if (n.left == null && n.right == null) {
            return null;
        } else if (n.left != null){
            return n.left;
        } else {
            return n.right;
        }
    }
    public void remove(K key){
        if (this.contains(key)){
            numNodes--;
        }
        root = remove_helper(root, key);
    }

    public Node remove_helper(Node n, K key) {
        if (n == null) {
            return null;
        } else if (lessThan.test(n.data, key)) {
            remove_helper(n.right, key);
            n.updateHeight();
            return n;
        } else if (lessThan.test(key, n.data)) {
            remove_helper(n.left, key);
            n.updateHeight();
            return n;
        } else {
            if (n.left == null) {
                if (n.parent != null && n.parent.left == n) {
                    setLeft(n.parent, n.right);
                } else if (n.parent != null && n.parent.right == n) {
                    setRight(n.parent, n.right);
                } else {
                    if (n.right != null) {
                        n.right.parent = null;
                    }
                }
                return n.right;
            } else if (n.right == null) {
                if (n.parent != null && n.parent.left == n) {
                    setLeft(n.parent, n.left);
                } else if (n.parent != null && n.parent.right == n) {
                    setRight(n.parent, n.left);
                } else {
                    if (n.right != null) {
                        n.left.parent = null;
                    }
                }
                return n.left;
            }
                else {
                    n.data = n.right.smallest().data;
                    remove_helper(n.right, n.right.smallest().data);
                    n.updateHeight();
                    return n;
                }
            }
        }
    public void setLeft(Node n1, Node n2){
        n1.left = n2;
        if (n2 != null){
            n2.parent = n1;
        }
    }
    public void setRight(Node n1, Node n2){
        n1.right = n2;
        if (n2 != null){
            n2.parent = n1;
        }
    }

    /**
     * TODO
     * <p>
     * Returns a sorted list of all the keys in this tree.
     */
    public List<K> keys(){
        return key_helper(root);
    }
    private List<K> key_helper(Node n){
        if (n != null){
            key_helper(n.left);
            list.add(n.data);
            key_helper(n.right);
        } else{
        }
        return list;
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
        return toStringInorder(root);
    }
}
