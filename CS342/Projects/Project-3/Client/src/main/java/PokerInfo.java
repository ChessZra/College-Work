import java.io.Serializable;

public class PokerInfo implements Serializable {

    // From the server
    String response;
    Player playerOne;
    Player playerTwo;
    Dealer theDealer;
    boolean dealerWasQualifiedPreviously;
    int dealerVsPlayerOne;
    int dealerVsPlayerTwo; // 0 - tie, 1 - player two wins, 2 - player two loses
    
    // From the client
    String request;
    int playerOneAnteBet;
    int playerTwoAnteBet;
    int playerOnePairPlusBet;
    int playerTwoPairPlusBet;

    public PokerInfo() {}

    public PokerInfo(String request) {
        this.request = request;
    }
}