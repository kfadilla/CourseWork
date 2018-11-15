
class BSTNode<T> {
    T key;
    BSTNode<T> left, right, parent;
    public int left_child_count = 0;

    BSTNode(T k, BSTNode<T> l, BSTNode<T> r) {
        key = k;
        left = l;
        right = r;
    }

}

public class BinarySearchTree<T extends Comparable<T>> {
    BSTNode<T> root;
    int numNode;

    BinarySearchTree() {
        root = null;
    }

    boolean find(T k) {
        return find_helper(root, k) != null;
    }

    void insert(T key) {
        root = insert_helper(root, key);
    }

    void remove(T key) {
        root = remove_helper(root, key);
    }
//a

    private T  kth_smallest(BSTNode<T> n,int k){
        if (n == null) return null;
        else if (k < n.left_child_count){
            return kth_smallest(n.left,k);
        }
        else if (k > n.left_child_count){
            return kth_smallest(n.right,(k-n.left_child_count-1));
        }
        else{
            return n.key;
        }
    }
    T kth_smallest(int k){
        if (k > numNode){
            throw new IllegalArgumentException("k is too large");
        }
        return kth_smallest(this.root,k);
    }

    public void print_tree() {
        System.out.print(tree_to_string(root));
    }

    private String tree_to_string(BSTNode<T> n) {
        if (n != null) {
            return String.format("(%s %d %s)",
                    tree_to_string(n.left),
                    n.key.toString(),
                    tree_to_string(n.right));
        }
        return "";
    }


    // Helper Functions

    private BSTNode<T> find_helper(BSTNode<T> n, T key) {
        if (n == null) {
            return null;
        } else if (key.compareTo(n.key) < 0) {
            return find_helper(n.left, key);
        } else if (key.compareTo(n.key) > 0) {
            return find_helper(n.right, key);
        } else {
            return n;
        }
    }

    private BSTNode<T> insert_helper(BSTNode<T> n, T key) {
        if (n == null) {
            numNode++;
            return new BSTNode<T>(key, null, null);
        } else if (key.compareTo(n.key) < 0 && n.left == null) {
            n.left_child_count++;
            numNode++;
            n.left = new BSTNode<>(key,null,null);
            n.left.parent = n;
            return n;
        } else if (key.compareTo(n.key) < 0 && n.left != null) {
            n.left_child_count ++;
            n.left= insert_helper(n.left, key);
            return n;
        }else if (key.compareTo(n.key) > 0 && n.right == null){
            numNode++;
            n.right = new BSTNode<>(key,null,null);
            n.right.parent = n;
            return n;
        }else if (key.compareTo(n.key) > 0 && n.right != null){
            n.right = insert_helper(n.right,key);
            return n;
        }
        else { // no need to insert, already there
            return n;
        }
    }

    private BSTNode<T> delete_min(BSTNode<T> n) {
        if (n.left == null) {
            return n.right;
        } else {
            n.left = delete_min(n.left);
            return n;
        }
    }

    private BSTNode<T> get_min(BSTNode<T> n) {
        if (n.left == null) {
            return n;
        }
        else {
            return get_min(n.left);
        }
    }

    private BSTNode<T> remove_helper(BSTNode<T> n, T key) {
        if (n == null) {
            return null;
        } else if (key.compareTo(n.key) < 0) { // remove in left subtree
            n.left = remove_helper(n.left, key);
        } else if (key.compareTo(n.key) > 0) { // remove in right subtree
            n.right = remove_helper(n.right, key);
        } else { // remove this node
            if (n.left == null) {
                n = n.right;
            } else if (n.right == null) {
                n = n.left;
            } else { // two children, replace this with min of right subtree
                BSTNode<T> min = get_min(n.right);
                n.key = min.key;
                n.right = delete_min(n.right);
            }
        }
        numNode--;
        return n;
    }
}
