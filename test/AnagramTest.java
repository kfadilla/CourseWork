import static org.junit.Assert.*;

public class AnagramTest {
    @org.junit.Test
    public void anagram() throws Exception {
        assertTrue(Anagram.anagram("mary", "army"));
        assertTrue(Anagram.anagram("doctor who", "torchwood"));
        assertFalse(Anagram.anagram("mary", "arm"));
        assertFalse(Anagram.anagram("doctr who", "torchwood"));
    }

}
