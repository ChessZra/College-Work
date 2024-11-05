import java.util.ArrayList;
import java.util.Collections;
import java.util.Random;

/* 
    This class represents a 52 card, standard deck, of playing cards. The constructor will
    create a new deck of 52 cards that have been sorted in random order. The second
    method will clear all the cards and create a brand new deck of 52 cards sorted in
    random order
 */
public class Deck extends ArrayList<Card> {

    private char[] suits;
    private int[] values;
    public Deck () {
        // Initialize our constant data members:
        suits = new char[] {'C', 'D', 'S', 'H'};
        values = new int[] {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14};

        newDeck();
    }

    void newDeck() {
        // Clear the current deck before making a new one.
        this.clear();   

        // Generate all possible cards
        // 13 * 4 = 52 cards
        for (char suit : suits) {
            for (int value : values) {
                this.add(new Card(suit, value));
            }
        }

        // Shuffle our deck:
        Collections.shuffle(this, new Random());
        
        /*
        for (int i = 0; i < 52; i++) {
            System.out.println("Card " + (i + 1) + " is " + this.get(i).suit + ' ' + this.get(i).value);
        }
         */

    }
    
}
