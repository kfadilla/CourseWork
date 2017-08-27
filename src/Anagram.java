public class Anagram {
	
    public static boolean anagram(String s1, String s2) {
        char[] a1 = s1.toCharArray();
        char[] a2 = s2.toCharArray();
        boolean TF = false;
        if (a1.length != a2.length){
            return false;
        }
        else
            for (int i = 0; i != a1.length;++i){
                for (char c : a1){
                    if (c == a2[i]){
                        TF = true;
                        break;
                    }
                    else {
                        TF = false;
                    }
                }
            }
        return TF;
}
