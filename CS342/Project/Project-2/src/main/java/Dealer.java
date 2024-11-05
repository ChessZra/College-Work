import java.util.ArrayList;

public class Dealer {
    Deck theDeck;
    ArrayList<Card> dealersHand;

    Dealer() {
        // Initialize data members:
        theDeck = new Deck();
        dealersHand = new ArrayList<>();
    }

    public ArrayList<Card> dealHand() {
        int deckSize = theDeck.size();

        // If there are <= 34 cards left in the deck
        // Create a new deck of size 52.
        if (deckSize <= 34) {
            theDeck.newDeck();
        }
        
        // TO DO:
        // Should we clear it or return it to the bottom of the deck?
        dealersHand.clear();
        
        // Deal three cards from the top of the deck:
        for (int i = 0; i < 3; i++) {
            dealersHand.add(theDeck.remove(theDeck.size() - 1));
        }
        
        /*
        for (int i = 0; i < 3; i++) {
            System.out.println("dealers hand card " + (i + 1) + " is " + dealersHand.get(i).suit + " " + dealersHand.get(i).value);
        }

        // Verify that the deck should be 49
        System.out.println("test size  " + theDeck.size());
        */

        return dealersHand;
    }   
}
