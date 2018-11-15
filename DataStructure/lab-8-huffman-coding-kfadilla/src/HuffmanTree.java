import javax.swing.text.html.HTMLDocument;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;

/**
 * TODO: Complete the implementation of this class.
 * 
 * A HuffmanTree represents a variable-length code such that the shorter the
 * bit pattern associated with a character, the more frequently that character
 * appears in the text to be encoded.
 */

public class HuffmanTree {

  class Node {
    protected char key;
    protected int priority;
    protected Node left, right;

    public Node(int priority, char key) {
      this(priority, key, null, null);
    }

    public Node(int priority, Node left, Node right) {
      this(priority, '\0', left, right);
    }

    public Node(int priority, char key, Node left, Node right) {
      this.key = key;
      this.priority = priority;
      this.left = left;
      this.right = right;
    }

    public boolean isLeaf() {
      return left == null && right == null;
    }

    public String toString() {
      return String.format("%s:%f", key, priority);
    }
  }

  protected Node root;

  /**
   * TODO
   * <p>
   * Creates a HuffmanTree from the given frequencies of letters in the
   * alphabet using the algorithm described in lecture.
   */
  public HuffmanTree(FrequencyTable charFreqs) {
    Comparator<Node> comparator = (x, y) -> {
      /**
       *  TODO: x and y are Nodes
       *  x comes before y if x's count is less than y's count
       */
      int ret;
      if (x.priority < y.priority) {
        ret = -1;
      } else if (x.priority > y.priority) {
        ret = 1;
      } else {
        ret = 0;
      }
      return ret;
    };

    PriorityQueue<Node> forest = new Heap<Node>(comparator);

    /**
     * TODO: Complete the implementation of Huffman's Algorithm.
     * Start by populating forest with leaves.
     */
    for (Character c : charFreqs.keySet()) {
      Node n = new Node(charFreqs.get(c), c);
      forest.insert(n);
    }
    while (forest.size() > 1) {
      Node small = forest.peek();
      forest.delete();
      Node sec = forest.peek();
      forest.delete();
      Node inserting = new Node(small.priority + sec.priority, small, sec);
      forest.insert(inserting);
    }
    root = forest.peek();
  }

  /**
   * TODO
   * <p>
   * Returns the character associated with the prefix of bits.
   *
   * @throws DecodeException if bits does not match a character in the tree.
   */
  public char decodeChar(String bits) {
    Node current = root;
    for (int i = 0; i != bits.length(); i++) {
      if (current == null) {
        throw new DecodeException("Invalid");
      }
      if (current.key != '\0') {
        return current.key;
      }
      if (bits.charAt(i) == '0') {
        current = current.left;
      } else if (bits.charAt(i) == '1') {
        current = current.right;
      }
    }
    return current.key;
  }


  /**
   * TODO
   * <p>
   * Returns the bit string associated with the given character. Must
   * search the tree for a leaf containing the character. Every left
   * turn corresponds to a 0 in the code. Every right turn corresponds
   * to a 1. This function is used by CodeBook to populate the map.
   *
   * @throws EncodeException if the character does not appear in the tree.
   */
  public String lookup(char ch) {
    Map<Character, String> look = new HashMap<>();
    String[] table = new String[65536];
    lookuptable(table, root, "");
    if (table[ch] == null){
      throw new EncodeException('n');
    }
    else {
      return table[ch];
    }
  }

  public static void lookuptable(String[] t, Node current, String s){
    if (current == null){
      return;
    }
    else if (!current.isLeaf()){
      lookuptable(t, current.left, s + "0");
      lookuptable(t, current.right, s + "1");
    } if (current.isLeaf()){
      t[current.key] = s;

    }
  }
}
