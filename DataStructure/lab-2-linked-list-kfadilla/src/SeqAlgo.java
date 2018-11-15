

public class SeqAlgo {
	
	public static <T> boolean equals(Sequence<T> s1, Sequence<T> s2) {
		Iter<T> i = s1.begin();
		Iter<T> j = s2.begin();
		while ((! i.equals(s1.end())) && (! j.equals(s2.end()))) {
			if (! i.get().equals(j.get()))
				return false;
			i.advance(); j.advance();
		}
		return i.equals(s1.end()) && j.equals(s2.end());
	}
	
}