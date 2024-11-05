import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

import org.junit.jupiter.api.DisplayName;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.BeforeEach;
import java.util.ArrayList;

class MyTest {
    
    private ArrayList<Card> hand;
    private int bet;

    /*
     * Three Card Logic Test Methods:
     */
    @BeforeEach
    void setUp() {
        hand = new ArrayList<>();
        bet = 10;
    }

    // Test ThreeCardLogic.evalHand():
    @Test
    void HighHandTest() {
        // Test Ace high
        hand.add(new Card('H', 14)); // Ace
        hand.add(new Card('D', 4));
        hand.add(new Card('S', 7));
        assertEquals(0, ThreeCardLogic.evalHand(hand));

        // Test high cards
        hand.clear();
        hand.add(new Card('H', 10));
        hand.add(new Card('D', 7));
        hand.add(new Card('S', 4));
        assertEquals(0, ThreeCardLogic.evalHand(hand));
    }

    @Test
    void StraightFlushTest() {
        // Test high straight flush (values are in random order)
        hand.add(new Card('S', 14)); // Ace 
        hand.add(new Card('S', 12)); // Queen
        hand.add(new Card('S', 13)); // King
        assertEquals(1, ThreeCardLogic.evalHand(hand));

        // Test low straight flush (values are ascending)
		hand.clear();
        hand.add(new Card('H', 4));
        hand.add(new Card('H', 5));
        hand.add(new Card('H', 6));
        assertEquals(1, ThreeCardLogic.evalHand(hand));
    }

    @Test
    void ThreeOfAKindTest() {
        // Test high three of a kind
        hand.clear();
        hand.add(new Card('H', 14)); // Aces
        hand.add(new Card('D', 14));
        hand.add(new Card('S', 14));
        assertEquals(2, ThreeCardLogic.evalHand(hand));

        // Test low three of a kind
        hand.clear();
        hand.add(new Card('H', 2));
        hand.add(new Card('D', 2));
        hand.add(new Card('S', 2));
        assertEquals(2, ThreeCardLogic.evalHand(hand));
    }

    @Test
    void StraightTest() {
        // Test high straight
        hand.clear();
        hand.add(new Card('H', 12)); // Queen
        hand.add(new Card('D', 14)); // Ace
        hand.add(new Card('S', 13)); // King
        assertEquals(3, ThreeCardLogic.evalHand(hand));

        // Test low straight
        hand.clear();
        hand.add(new Card('H', 4));
        hand.add(new Card('D', 3));
        hand.add(new Card('S', 2));
        assertEquals(3, ThreeCardLogic.evalHand(hand));
    }

    @Test
    void FlushTest() {
        // Test high flush
        hand.add(new Card('S', 14)); // Ace
        hand.add(new Card('S', 10));
        hand.add(new Card('S', 7));
        assertEquals(4, ThreeCardLogic.evalHand(hand));

		// Test low flush
		hand.clear();
		hand.add(new Card('H', 2));
		hand.add(new Card('H', 5));
		hand.add(new Card('H', 8));
		assertEquals(4, ThreeCardLogic.evalHand(hand));
    }

    @Test
    void PairTest() {
        // Test high pair (Aces)
        hand.clear();
        hand.add(new Card('H', 14));
        hand.add(new Card('D', 14));
        hand.add(new Card('S', 5));
        assertEquals(5, ThreeCardLogic.evalHand(hand));

        // Test low pair
        hand.clear();
        hand.add(new Card('H', 2));
        hand.add(new Card('D', 2));
        hand.add(new Card('S', 7));
        assertEquals(5, ThreeCardLogic.evalHand(hand));
    }

    @Test
    void EdgeCasesTest() {
        // Test empty hand
        assertEquals(0, ThreeCardLogic.evalHand(new ArrayList<>()));

        // Test hand with only 2 cards
        hand.add(new Card('H', 2));
        hand.add(new Card('D', 3));
        assertEquals(0, ThreeCardLogic.evalHand(hand));

        // Test hand with 4 cards
        hand.add(new Card('S', 4));
        hand.add(new Card('C', 5));
        assertEquals(0, ThreeCardLogic.evalHand(hand));
    }

    // Test ThreeCardLogic.evalPPWinnings():
    @Test
    void PairPlusStraightFlushTest() {
        hand.add(new Card('S', 12)); // Queen
        hand.add(new Card('S', 13)); // King
        hand.add(new Card('S', 14)); // Ace
        assertEquals(bet * 40, ThreeCardLogic.evalPPWinnings(hand, bet));
    }

    @Test
    void PairPlusThreeOfAKindTest() {
        hand.add(new Card('H', 14)); // Aces
        hand.add(new Card('D', 14));
        hand.add(new Card('S', 14));
        assertEquals(bet * 30, ThreeCardLogic.evalPPWinnings(hand, bet));
    }

    @Test
    void PairPlusStraightTest() {
        hand.add(new Card('H', 2));
        hand.add(new Card('D', 3));
        hand.add(new Card('S', 4));
        assertEquals(bet * 6, ThreeCardLogic.evalPPWinnings(hand, bet));
    }

    @Test
    void PairPlusFlushTest() {
        hand.add(new Card('H', 2));
        hand.add(new Card('H', 5));
        hand.add(new Card('H', 8));
        assertEquals(bet * 3, ThreeCardLogic.evalPPWinnings(hand, bet));
    }

    @Test
    void PairPlusPairTest() {
        hand.add(new Card('H', 14));
        hand.add(new Card('D', 14));
        hand.add(new Card('S', 5));
        assertEquals(bet * 1, ThreeCardLogic.evalPPWinnings(hand, bet));
    }

    @Test
    void PairPlusHighCardTest() {
        hand.add(new Card('H', 14)); // Ace
        hand.add(new Card('D', 4));
        hand.add(new Card('S', 7));
        assertEquals(0, ThreeCardLogic.evalPPWinnings(hand, bet));
    }

    @Test
    void PairPlusInvalidBetTest() {
        hand.add(new Card('H', 7));
        hand.add(new Card('D', 7));
        hand.add(new Card('S', 4));
        
        // Bet of 0 or under should not be valid:
        assertEquals(0, ThreeCardLogic.evalPPWinnings(hand, 0));
        assertEquals(0, ThreeCardLogic.evalPPWinnings(hand, -10));
    }

    @Test
    void PairPlusEmptyHandTest() {
        assertEquals(0, ThreeCardLogic.evalPPWinnings(hand, bet));
    }

    // Test ThreeCardLogic.compareHands():
    @Test
    void CompareDifferentTypesTest() {
        ArrayList<Card> dealer = new ArrayList<>();
        ArrayList<Card> player = new ArrayList<>();
        
        // Dealer straight flush 
        dealer.add(new Card('H', 4));
        dealer.add(new Card('H', 5));
        dealer.add(new Card('H', 6));
        
        // Player flush
        player.add(new Card('S', 14)); // Ace
        player.add(new Card('S', 10));
        player.add(new Card('S', 7));
        
        // Dealer wins because straight flush > flush
        assertEquals(1, ThreeCardLogic.compareHands(dealer, player));
    }
    
    @Test
    void CompareSameTypeTest() {
        ArrayList<Card> dealer = new ArrayList<>();
        ArrayList<Card> player = new ArrayList<>();
        
        // Dealer queen high card
        dealer.add(new Card('H', 12)); // Queen
        dealer.add(new Card('D', 4));
        dealer.add(new Card('S', 7));
        
        // Player ace high card
        player.add(new Card('S', 14)); // Ace
        player.add(new Card('D', 3));
        player.add(new Card('H', 6));
        
        // Player wins because Ace > Queen
        assertEquals(2, ThreeCardLogic.compareHands(dealer, player));
    }
    
    @Test
    void CompareSameTypePairTest() {
        ArrayList<Card> dealer = new ArrayList<>();
        ArrayList<Card> player = new ArrayList<>();
        
        // Dealer pair
        dealer.add(new Card('H', 10));
        dealer.add(new Card('D', 10));
        dealer.add(new Card('S', 14)); 
        
        // Player pair
        player.add(new Card('S', 10));
        player.add(new Card('C', 10));
        player.add(new Card('H', 13));
        
        // Both pairs but dealer wins because 14 > 13
        assertEquals(1, ThreeCardLogic.compareHands(dealer, player));
    }
    
    @Test
    void CompareSameTypePairTest2() {
        ArrayList<Card> dealer = new ArrayList<>();
        ArrayList<Card> player = new ArrayList<>();
        
        // Dealer pair
        dealer.add(new Card('H', 10));
        dealer.add(new Card('D', 10));
        dealer.add(new Card('S', 13)); 
        
        // Player pair
        player.add(new Card('S', 9));
        player.add(new Card('C', 10));
        player.add(new Card('H', 13));
        
        // Both pairs but dealer wins because on their third card, 10 > 9:
        assertEquals(1, ThreeCardLogic.compareHands(dealer, player));
    }

    @Test
    void CompareSameTypeStraightTest() {
        ArrayList<Card> dealer = new ArrayList<>();
        ArrayList<Card> player = new ArrayList<>();
        
        // Dealer straight
        dealer.add(new Card('H', 4));
        dealer.add(new Card('D', 5));
        dealer.add(new Card('S', 6));
        
        // Player straight
        player.add(new Card('S', 12)); // Queen
        player.add(new Card('H', 13)); // King
        player.add(new Card('D', 14)); // Ace
        
        // Both straight but player wins because higher straight
        assertEquals(2, ThreeCardLogic.compareHands(dealer, player));
    }
    
    @Test
    void CompareHandsTieTest() {
        ArrayList<Card> dealer = new ArrayList<>();
        ArrayList<Card> player = new ArrayList<>();
        
        // Dealer straight
        dealer.add(new Card('H', 10));
        dealer.add(new Card('H', 11));
        dealer.add(new Card('H', 12));
        
        // Player straight
        player.add(new Card('S', 10));
        player.add(new Card('S', 11));
        player.add(new Card('S', 12));
        
        // Tie because both are straight and both have the same values.
        assertEquals(0, ThreeCardLogic.compareHands(dealer, player));
    }
    
    @Test
    void CompareInvalidTest() {
        ArrayList<Card> dealer = new ArrayList<>();
        ArrayList<Card> player = new ArrayList<>();
        
        // Test null hands
        assertEquals(0, ThreeCardLogic.compareHands(null, player));
        assertEquals(0, ThreeCardLogic.compareHands(dealer, null));
        
        dealer.add(new Card('H', 10));
        dealer.add(new Card('D', 11));
        
        player.add(new Card('S', 10));
        player.add(new Card('C', 11));
        player.add(new Card('H', 12));
        
        assertEquals(0, ThreeCardLogic.compareHands(dealer, player));
    }
}