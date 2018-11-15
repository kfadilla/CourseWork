

public class Main {

	static Node array_to_list(int[] array) {
		Node list = null;
		for (int i = array.length - 1; i != -1; --i)
			list = new Node(array[i], list);
		return list;
	}

	static Node nth_node(Node list, int n) {
		for (Node curr = list; curr != null; curr = curr.next)
			if (n == 0)
				return curr;
			else
				--n;
		return null;
	}

	static void remove_next(Node n) {
		if (n.next != null)
			n.next = n.next.next;
	}  

	static void insert_after(Node node, int x) {
		// student implementation
	}

}
