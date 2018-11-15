import java.util.function.Consumer;

class BinaryNode<T> {
    private T data;
    private BinaryNode<T> left;
    private BinaryNode<T> right;

    public BinaryNode(T d, BinaryNode<T> l, BinaryNode<T> r) {
        data = d; left = l; right = r;
    }

    public void preorder(Consumer<T> f) {
        // student implements
        if (data != null) {
            f.accept(data);
            if (left != null) {
                this.left.preorder(f);
            }
            if (right != null) {
                this.right.preorder(f);
            }
        }
    }


    public void inorder(Consumer<T> f) {
        // student implements
        if (data != null) {
            if (left != null) {
                this.left.inorder(f);
            }
            f.accept(data);
            if (right != null) {
                this.right.inorder(f);
            }
        }
    }

    public void postorder(Consumer<T> f) {
        // student implements
        if (data != null) {
            if (left != null) {
                this.left.postorder(f);
            }
            if (right != null) {
                this.right.postorder(f);
            }
            f.accept(data);
        }
    }

}

public class BinaryTree<T> {
    private BinaryNode<T> root;

    public BinaryTree() { root = null; }
    public BinaryTree(BinaryNode<T> r) { root = r; }

    public void preorder(Consumer<T> f) { root.preorder(f); }
    public void inorder(Consumer<T> f) { root.inorder(f); }
    public void postorder(Consumer<T> f) { root.postorder(f); }

}
