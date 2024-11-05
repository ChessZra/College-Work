import java.util.ArrayList;

public class Player {
    ArrayList<Card> hand;
    int anteBet;
    int playBet;
    int pairPlusBet;
    int totalWinnings;

    public Player() {
        // Initialize data members:
        hand = new ArrayList<>();
        totalWinnings = 0;
    }

}
