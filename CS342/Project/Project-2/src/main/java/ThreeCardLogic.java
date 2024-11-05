import java.util.ArrayList;

public class ThreeCardLogic {

    // Private helper methods:
    private static boolean isFlush(ArrayList<Card> hand) { 
        // if a == b and b == c, then a == c by the transitive property:
        return hand.get(0).suit == hand.get(1).suit && hand.get(1).suit == hand.get(2).suit;
    }
    
    private static boolean isStraight(ArrayList<Card> hand) {
        // if c - b == 1 and b - a == 1, then we have a strictly increasing hand by 1:
        return (hand.get(2).value - hand.get(1).value == 1) && (hand.get(1).value - hand.get(0).value == 1);
    }
    
    private static boolean isThreeOfAKind(ArrayList<Card> hand) {
        // Same idea as isFlush(), but the value matters instead of the suit:
        return hand.get(0).value == hand.get(1).value && hand.get(1).value == hand.get(2).value;
    }
    
    private static boolean isPair(ArrayList<Card> hand) {
        // if a == b or b == c or a == c: then it's a pair
        // a Three of a Kind Hand will be an isPair as well, but it is checked first in evalHand():
        return hand.get(0).value == hand.get(1).value || hand.get(1).value == hand.get(2).value || hand.get(0).value == hand.get(2).value;
    }

    private static int tieBreaker(ArrayList<Card> dealer, ArrayList<Card> player) {
        /*
         Source: https://www.contrib.andrew.cmu.edu/~gc00/reviews/pokerrules#:~:text=If%20nobody%20has%20a%20pair,flush%2C%20straight%2C%20etc).
            If multiple people tie for the highest card, they look at the second highest, 
            then the third highest etc. High card is also used to break ties when the high 
            hands both have the same type of hand (pair, flush, straight, etc).
        */

        // Sort the hand to have an easier time in decreasing order:
        player.sort((a, b) -> b.value - a.value);
        dealer.sort((a, b) -> b.value - a.value);

        for (int i = 0; i < player.size(); i++) {
            int playerHighestCard = player.get(i).value;
            int dealerHighestCard = dealer.get(i).value;
            if (playerHighestCard > dealerHighestCard) {
                return 2; // Player wins
            } else if (dealerHighestCard > playerHighestCard) {
                return 1; // Dealer wins
            }
        }
        return 0; // Ties
    }

    // Public methods:
    public static int evalHand(ArrayList<Card> hand) {
        /*
        This class represents the logic in the game. The method evalHand will return an integer
        value representing the value of the hand passed in. It will return:
        • 0 if the hand just has a high card
        • 1 for a straight flush
        • 2 for three of a kind
        • 3 for a straight
        • 4 for a flush
        • 5 for a pair
         */
        
        // Check if we have exactly 3 cards
        if (hand.size() != 3) {
            return 0; // Invalid hand, return high card
        }
    
        // Sort the hand to have an easier time:
        hand.sort((a, b) -> a.value - b.value);
    
        // Check for straight flush (1)
        if (isFlush(hand) && isStraight(hand)) {
            return 1;
        }
    
        // Check for three of a kind (2)
        if (isThreeOfAKind(hand)) {
            return 2;
        }
    
        // Check for straight (3)
        if (isStraight(hand)) {
            return 3;
        }
    
        // Check for flush (4)
        if (isFlush(hand)) {
            return 4;
        }
    
        // Check for pair (5)
        if (isPair(hand)) {
            return 5;
        }
    
        // If none of the above, it's a high card (0)
        return 0;
    }
    
    public static int evalPPWinnings(ArrayList<Card> hand, int bet) {
        /* 
        The method evalPPWinnings will return the amount won for the PairPlus bet. It will
        evaluate the hand and then evaluate the winnings and return the amount won. If the
        player lost the Pair Plus bet, it will just return 0.
        */
        int handType = evalHand(hand);

        if (handType == 0 || bet <= 0) return 0; 

        if (handType == 1) {
            return bet * 40;
        } else if (handType == 2) {
            return bet * 30;
        } else if (handType == 3) {
            return bet * 6;
        } else if (handType == 4) {
            return bet * 3;
        } else if (handType == 5)  {
            return bet;
        }

        // Should not get here.
        return bet;
    }

    public static int compareHands(ArrayList<Card> dealer, ArrayList<Card> player) {
        /*
        The method compareHands will compare the two hands passed in and return an
        integer based on which hand won:
        • 0 if neither hand won
        • 1 if the dealer hand won
        • 2 if the player hand won
         */

        // Check for invalid hands
        if (dealer == null || player == null || 
            dealer.size() != 3 || player.size() != 3) {
            return 0;
        }

        int dealerHandType = evalHand(dealer);
        int playerHandType = evalHand(player);

        if (dealerHandType == playerHandType) {
            return tieBreaker(dealer, player);
        }
        
        // If the dealer has the high card, then the player wins:
        if (dealerHandType == 0) return 2;

        // If the player has the high card, then the dealer wins:
        if (playerHandType == 0) return 1;
        
        // None of them has a high card (0),
        // The ranking of the handType [1, 2, 3, 4, 5] where 
        // type 1 beats type 2.
        if (playerHandType < dealerHandType) return 2;

        // Otherwise, dealer's handType is lower than player's handType:
        return 1;
    }
}
