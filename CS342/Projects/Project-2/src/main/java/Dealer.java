import java.util.ArrayList;

public class Dealer {
    Deck theDeck;
    ArrayList<Card> dealersHand;

    Dealer() {
        // Initialize data members:
        theDeck = new Deck();
        dealersHand = new ArrayList<>();
    }

    // Removes the top most card on the deck (like a stack)
    public Card getCardFromTheDeck() {
        return theDeck.remove(theDeck.size() - 1);
    }

    public ArrayList<Card> dealHand() {
        int deckSize = theDeck.size();

        // If there are <= 34 cards left in the deck
        // Create a new deck of size 52.
        if (deckSize <= 34) {
            theDeck.newDeck();
        }
        
        ArrayList<Card> newHand = new ArrayList<>();

        // Deal three cards from the top of the deck:
        for (int i = 0; i < 3; i++) {
            newHand.add(getCardFromTheDeck());
        }
        
        /* Print Statements below remaining:: 
        for (int i = 0; i < 3; i++) {
            System.out.println("new hand card " + (i + 1) + " is " + newHand.get(i).suit + " " + newHand.get(i).value);
        }
        System.out.println("test size  " + theDeck.size());
        */

        return newHand;
    }   
}
