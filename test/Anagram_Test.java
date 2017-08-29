import static org.junit.Assert.*;

public class Anagram_Test {
    @org.junit.Test
    public void anagram() throws Exception {
        assertTrue(Anagram_a.anagram("mary", "army"));
        assertTrue(Anagram_a.anagram("doctor who", "torchwood"));
        assertFalse(Anagram_a.anagram("mary", "arm"));
        assertFalse(Anagram_a.anagram("doctr who", "torchwood"));
        assertTrue(Anagram_a.anagram("abc", "cba"));
        assertTrue(Anagram_a.anagram("", ""));
        assertFalse(Anagram_a.anagram("da", "a"));
    }

}
