
// Wrapper class to make a Java array into a Sequence.
//a
public class ArraySequence<T> implements Sequence<T>{
	private T[] array;
	public ArraySequence(T[] a) { array = a; }
	public ArrayIter<T> begin() { return new ArrayIter<T>(array,0); }
	public ArrayIter<T> end() { return new ArrayIter<T>(array, array.length); }
	
	class ArrayIter<T> implements Iter<T> {
		private T[] array;
		private int pos;
		public ArrayIter(T[] a, int p) {
			array = a; pos = p;
		}

		public T get() {
			return array[pos];
		}
		public void advance() {
			++pos;
		}
		public ArrayIter<T> clone() {
			return new ArrayIter<T>(array,pos);
		}
		public boolean equals(Iter<T> other) {
			ArrayIter<T> i = (ArrayIter<T>) other;
			return pos == i.pos;
		}
	}
}
