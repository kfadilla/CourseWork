import org.junit.After;

import static org.junit.Assert.*;

public class AnagramTest {
    public void anagram() throws Exception {
        assertTrue(Anagram.anagram("mary", "army"));
        assertTrue(Anagram.anagram("doctor who", "torchwood"));
        assertFalse(Anagram.anagram("mary", "arm"));
        assertFalse(Anagram.anagram("doctr who", "torchwood"));
        assertTrue(Anagram.anagram("abc", "cba"));
        assertTrue(Anagram.anagram("", ""));
        assertFalse(Anagram.anagram("da", "a"));
    }
}
