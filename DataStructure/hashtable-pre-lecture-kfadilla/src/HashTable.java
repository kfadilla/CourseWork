
import sun.awt.image.ImageWatched;
import java.util.ArrayList;
import java.util.LinkedList;

class Entry<K,V> {
    Entry(K k, V v) { key = k; value = v; }
    K key; V value;
};

public class HashTable<K,V> implements Map<K,V> {

    ArrayList<LinkedList<Entry<K,V>>> table;

    public HashTable() {
        int m = 20;
        table = new ArrayList<>(m);
        for (int i = 0; i != m; ++i)
            table.add(new LinkedList<>());
    }

    public boolean contains(K key) { return findEntry(key) != null; }

    public V get(K key) throws Exception {
        Entry<K,V> e = findEntry(key);
        if (e == null)
            throw new Exception("there is no entry with key " + key.toString());
        else
            return e.value;
    }

    /*
     * TODO
     *
     * The put() method should associate the value with the key, so that
     * subsequent invocations of get() on the same key should return the value.
     */
    public void put(K key, V value) {
        Entry<K, V> found = findEntry(key);
        if(found == null){
            LinkedList<Entry<K, V>> list = table.get(key.hashCode() % table.size());
            list.add(new Entry<>(key, value));
        }
        else found.value = value;
    }

    /*
     * TODO
     *
     * The remove() method removes the entry whose key matches the key parameter
     * from the hashtable, if such an entry exists.
     */
    public void remove(K key) {
        Entry<K, V> found = findEntry(key);
        if (found == null) return;
        else {
            LinkedList<Entry<K, V>> list = table.get(key.hashCode() % table.size());
            list.remove(found);
        }
    }

    /**********************
     * TODO
     *
     * The findEntry() helper function returns an entry whose key matches the key parameter,
     * or else returns null if there is not such an entry in the table.
     */

    protected Entry<K,V> findEntry(K key) {
        LinkedList<Entry<K, V>> list = table.get(key.hashCode() % table.size());
        for (Entry<K, V> e : list){
            if (e.key.equals(key)) return e;
        }
        return null;
    }

}