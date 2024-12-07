import java.io.Serializable;
import java.util.ArrayList;

public class Player implements Serializable {
    ArrayList<Card> hand;
    int anteBet;
    int playBet;
    int pairPlusBet;
    int totalWinnings;

    // Defined for the game logic:
    int readyState;     // 1 if READY, 0 if not
    int decisionState;  // 0 - awaiting decision, 1 - play, 2 - fold
    int pairPlusWinnings;
    int anteWinnings; 

    public Player() {
        // Initialize data members:
        hand = new ArrayList<>();
        totalWinnings = 0;

        readyState = 0;    
        decisionState = 1; // default value
    }

    public void setAnteBet(int bet) {
        if (bet >= 5 && bet <= 25) {
            anteBet = bet;
        } else {
            anteBet = 0;
        }
    }

    public void setPairPlusBet(int bet) {
        if (bet >= 5 && bet <= 25) {
            pairPlusBet = bet;
        } else {
            pairPlusBet = 0;
        }
    }
}
