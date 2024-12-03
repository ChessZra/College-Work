import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import org.junit.jupiter.api.BeforeEach;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

class DeckDealerTest {

    private Dealer dealer;
    private Deck deck;

    @BeforeEach
    void setup() {
        dealer = new Dealer();
        deck = new Deck();
    }

    @Test
    void testDealerConstructor() {
        assertEquals(0, dealer.dealersHand.size());
        assertEquals(52, dealer.theDeck.size());
    }

    @Test
    void testDeckConstructor() {
        assertEquals(52, deck.size());
    }

    @Test
    void testDealCards() {
        ArrayList<Card> hand = dealer.dealHand();
        assertEquals(3, hand.size());
    }

    @Test
    void testDeckResetAfterThirtyFour() {
        for (int i = 0; i < 6; i++) {
            dealer.dealHand();
        } // Resets after 34
        dealer.dealHand();
        assertEquals(49, dealer.theDeck.size());
    }

    @Test
    void testDeckContainsUniqueCards() {
        Set<Card> uniqueCards = new HashSet<>(deck);
        assertEquals(52, uniqueCards.size());
    }

    @Test
    void testCreateNewDeck() {
        Deck newDeck = new Deck();
        newDeck.newDeck();
        assertEquals(52, newDeck.size());

        Set<Card> uniqueCards = new HashSet<>(newDeck);
        assertEquals(52, uniqueCards.size());
    }

    @Test
    void testDeckSizeAfterNewDeck() {
        deck.remove(0);
        int initialDeckSize = deck.size();

        deck.newDeck();
        assertNotEquals(initialDeckSize, deck.size());
    }

    @Test
    void testDealerHandSizeAfterDeal() {
        ArrayList<Card> hand = dealer.dealHand();
        assertEquals(3, hand.size());
        assertEquals(0, dealer.dealersHand.size());
    }

    @Test
    void testDeckSizeAfterDeal() {
        int initialDeckSize = dealer.theDeck.size();
        dealer.dealHand();
        assertEquals(initialDeckSize - 3, dealer.theDeck.size());
    }

    @Test
    void testCardsDealedFromDeck() {
        int initialDeckSize = dealer.theDeck.size();
        Card card1 = dealer.getCardFromTheDeck();
        assertEquals(initialDeckSize - 1, dealer.theDeck.size());
        Card card2 = dealer.getCardFromTheDeck();
        assertEquals(initialDeckSize - 2, dealer.theDeck.size());
        assertNotEquals(card1, card2);
    }
}