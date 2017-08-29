public class Anagram {

    public static boolean anagram(String s1, String s2) {
        s1 = s1.replaceAll("\\s", "");
        s2 = s2.replaceAll("\\s", "");
        char[] a1 = new char[s1.length()];
        char[] a2 = new char[s2.length()];
        boolean TF = false;
        if (a1.length != a2.length) {
            return TF = false;
        } else if (a1.length == 0) {
            return true;
        } else
            for (int i = 0; i != a1.length; ++i) {
                for (char c : a1) {
                    if (c == a2[i]) {
                        TF = true;
                        break;
                    } else {
                        TF = false;
                    }
                }
            }
        return TF;
    }
}