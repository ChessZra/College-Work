import java.io.Serializable;

public class Card implements Serializable {
    char suit;
    int value;

    /* 
     * suit:
     * C - Clubs
     * D - Diamonds
     * S - Spades
     * H - Hearts
     * value:
     * The data member value will be an integer value between 2 - 14, with the value of an
       ace being 14, king 13, queen 12, jack 11, ten 10…..and so on. 
     */
    public Card(char suit, int value) {
        this.suit = suit;
        this.value = value;
    }
}
