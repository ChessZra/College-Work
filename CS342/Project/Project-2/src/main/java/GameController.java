import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.ResourceBundle;

import javafx.animation.PauseTransition;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import javafx.util.Duration;

public class GameController implements Initializable {

    /* Main Menu FXML Decorators */
	@FXML
	private VBox root;

    /* Exit Screen FXML Decorators */
	@FXML
	private VBox exitRoot;

    /* Main Game FXML Decorators */ 
    @FXML
    private static BorderPane gameRoot;

    @FXML
    private VBox leftVBox;
    @FXML
    private VBox rightVBox;
    @FXML
    private VBox centerVBox;
    // Images:
    @FXML
    private ImageView dealerCard1Image;
    @FXML
    private ImageView dealerCard2Image;
    @FXML
    private ImageView dealerCard3Image;
    @FXML
    private ImageView player1Card1Image;
    @FXML
    private ImageView player1Card2Image;
    @FXML
    private ImageView player1Card3Image;
    @FXML
    private ImageView player2Card1Image;
    @FXML
    private ImageView player2Card2Image;
    @FXML
    private ImageView player2Card3Image;
    // TextFields:
    @FXML
    private TextField anteBetTextField1;
    @FXML
    private TextField anteBetTextField2;
    @FXML
    private TextField pairPlusTextField1;
    @FXML
    private TextField pairPlusTextField2;
    @FXML
    private TextField anteWinningsTextFieldPlayer1;
    @FXML
    private TextField anteWinningsTextFieldPlayer2;
    @FXML
    private TextField pairPlusWinningsTextFieldPlayer1;
    @FXML
    private TextField pairPlusWinningsTextFieldPlayer2;
    @FXML
    private TextField moneyTextField1;
    @FXML
    private TextField moneyTextField2;
    // Labels:
    @FXML
    private Label dealerOutput;
    // Buttons:
    @FXML
    private Button readyButtonPlayer1;
    @FXML
    private Button readyButtonPlayer2;
    @FXML
    private Button playButtonPlayer1;
    @FXML
    private Button playButtonPlayer2;
    @FXML
    private Button foldButtonPlayer1;
    @FXML
    private Button foldButtonPlayer2;
    @FXML
    private Button nextRoundButton;

    // Data members:
    private Player playerOne;
    private Player playerTwo;
    private Dealer theDealer;
    private boolean dealerWasQualifiedPreviously;
    private int currentStyle = 1;

    ArrayList<ImageView> player1Images;
    ArrayList<ImageView> player2Images;
    ArrayList<ImageView> theDealerImages;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
        // Initialize player1, player2 and the dealer:
		playerOne = new Player();
		playerTwo = new Player();
		theDealer = new Dealer();
        
        player1Images = new ArrayList<>();
        player1Images.add(player1Card1Image);
        player1Images.add(player1Card2Image);
        player1Images.add(player1Card3Image);

        player2Images = new ArrayList<>();
        player2Images.add(player2Card1Image);
        player2Images.add(player2Card2Image);
        player2Images.add(player2Card3Image);

        theDealerImages = new ArrayList<>();
        theDealerImages.add(dealerCard1Image);
        theDealerImages.add(dealerCard2Image);
        theDealerImages.add(dealerCard3Image);
	}
    
    /* Private helper methods:
    */ 
    private void updateTotalWinnings() {
        moneyTextField1.setText("YOUR MONEY $" + Integer.toString(playerOne.totalWinnings));
        moneyTextField2.setText("YOUR MONEY $" + Integer.toString(playerTwo.totalWinnings));
    }

    private void distributeTheCardsToPlayers() {

        if (playerOne.hand.size() == 3) {
            for (int i = 0; i < 3; i++) {
                // Create a pause that waits for (i * 1) seconds
                PauseTransition pause = new PauseTransition(Duration.seconds(i * 1));

                int index = i;
                pause.setOnFinished(event -> {
                    // In the format e.g: /images/C_10.png (10 of clubs)
                    String path = "/images/" + playerOne.hand.get(index).suit + "_" + playerOne.hand.get(index).value + ".png";
                    Image card = new Image(getClass().getResource(path).toExternalForm());
                    player1Images.get(index).setImage(card);
                });

                pause.play();
            }
        }
        if (playerTwo.hand.size() == 3) {
            for (int i = 0; i < 3; i++) {
                // Create a pause that waits for (i * 1) seconds
                PauseTransition pause = new PauseTransition(Duration.seconds(i * 1));
                
                int index = i;
                pause.setOnFinished(event -> {
                    String path = "/images/" + playerTwo.hand.get(index).suit + "_" + playerTwo.hand.get(index).value + ".png";
                    Image card = new Image(getClass().getResource(path).toExternalForm());
                    player2Images.get(index).setImage(card);
                });

                pause.play();

            }
        }
    }

    private void faceAllCardsDown() {
        Image card;
        String path = "/images/facedown.png";
        for (int i = 0; i < 3; i++) {
            card = new Image(getClass().getResource(path).toExternalForm());
            player1Images.get(i).setImage(card);
        }

        for (int i = 0; i < 3; i++) {
            card = new Image(getClass().getResource(path).toExternalForm());
            player2Images.get(i).setImage(card);
        }
        for (int i = 0; i < 3; i++) {
            card = new Image(getClass().getResource(path).toExternalForm());
            theDealerImages.get(i).setImage(card);
        }
    }

    private void revealDealerCards() {
        for (int i = 0; i < 3; i++) {
            int index = i;
            
            // Create a pause that waits for (i * 1) seconds
            PauseTransition pause = new PauseTransition(Duration.seconds(i * 1));
            
            // What to do after the pause
            pause.setOnFinished(event -> {
                String path = "/images/" + theDealer.dealersHand.get(index).suit + 
                             "_" + theDealer.dealersHand.get(index).value + ".png";
                Image card = new Image(getClass().getResource(path).toExternalForm());
                theDealerImages.get(index).setImage(card);

                if (index == 2) {
                    evaluateGame();
                }
            });
            pause.play();
        }
    }

    private void setupNewRound() {
        updateTotalWinnings();

        // Disable the FOLD and PLAY buttons:
        playButtonPlayer1.setDisable(true);
        playButtonPlayer2.setDisable(true);
        foldButtonPlayer1.setDisable(true);
        foldButtonPlayer2.setDisable(true);

        // Enable the ready buttons:   
        readyButtonPlayer1.setDisable(false);
        readyButtonPlayer2.setDisable(false);

        // Enable the betting textfields:
        anteBetTextField1.setDisable(false);
        anteBetTextField2.setDisable(false);
        pairPlusTextField1.setDisable(false);
        pairPlusTextField2.setDisable(false);
        
        // You can't edit your ante bet if your bet was pushed to the next round:
        if (dealerWasQualifiedPreviously == false && playerOne.decisionState == 1) {
            anteBetTextField1.setDisable(true);
        }
        if (dealerWasQualifiedPreviously == false && playerTwo.decisionState == 1) {
            anteBetTextField2.setDisable(true);
        }

        // Set data members to default value:
        playerOne.readyState = 0;
        playerTwo.readyState = 0;
        playerOne.decisionState = 1;
        playerTwo.decisionState = 1;

        faceAllCardsDown();
    }

    private void addPairPlusWinnings() {
        // Add the winnings from the pair plus bets:
        if (playerOne.pairPlusWinnings > 0) {
            playerOne.totalWinnings += (playerOne.pairPlusBet + playerOne.pairPlusWinnings);
        } 
        if (playerTwo.pairPlusWinnings > 0) {
            playerTwo.totalWinnings += (playerTwo.pairPlusBet + playerTwo.pairPlusWinnings);
        }
    }

    // A callback function - once the dealer's cards have been revealed 
    private void evaluateGame() {
        // System.out.println("Game evaluation starts!");
        // Check if anyone folded:
        if (playerOne.decisionState == 2) {
            anteWinningsTextFieldPlayer1.setText("Fold - lost your ante bet.");
            pairPlusWinningsTextFieldPlayer1.setText("Fold - lost your pair plus bet!");
        }

        if (playerTwo.decisionState == 2) {
            anteWinningsTextFieldPlayer2.setText("Fold - lost your ante bet.");
            pairPlusWinningsTextFieldPlayer2.setText("Fold - lost your pair plus bet!");
        }

        /*  If the dealer does not have at least 
            a Queen high or better, the play wager is returned to the players who did not fold and
            the ante bet is pushed to the next hand. */
        if (ThreeCardLogic.isDealerQualified(theDealer.dealersHand) == 0) {
            dealerOutput.setText("Dealer does not have at least Queen high; ante wager is pushed");
            if (playerOne.decisionState == 1) {
                playerOne.totalWinnings += (playerOne.playBet + playerOne.anteBet);
                anteWinningsTextFieldPlayer1.setText("+ $0 | Ante is pushed to the next hand.");
            }
            if (playerTwo.decisionState == 1) {
                playerTwo.totalWinnings += (playerTwo.playBet + playerTwo.anteBet);
                anteWinningsTextFieldPlayer2.setText("+ $0 | Ante is pushed to the next hand.");
            }
            addPairPlusWinnings();
            dealerWasQualifiedPreviously = false;

            // Enable the next round button.
            nextRoundButton.setDisable(false);
            return; 
        } 

        /* If the dealer does have at least a Queen high or better, then each players hand, that
           did not fold, is evaluated against the dealers hand. If the dealer wins, the player 
           loses both the ante and play wager. If the player wins, they get paid out 1 to 1 
           (they get back double what they wagered). Say the player bet $5 each for the ante and 
           play wager and won, they would get back $20. 
                0 if neither hand won
                1 if the dealer hand won
                2 if the player hand won */
        int playerOneDealerWinner = ThreeCardLogic.compareHands(theDealer.dealersHand, playerOne.hand);
        // System.out.println("Player One vs Dealer status:" + playerOneDealerWinner);
        if (playerOne.decisionState == 1) { 
            if (playerOneDealerWinner == 0) { // Tie breaker, everything is given back
                playerOne.anteWinnings = 0;
                anteWinningsTextFieldPlayer1.setText("Player one ties with the dealer. + $0");
            } else if (playerOneDealerWinner == 1) {
                playerOne.anteWinnings -= (playerOne.anteBet + playerOne.playBet);
                anteWinningsTextFieldPlayer1.setText("Player one loses to dealer. - $" + Math.abs(playerOne.anteWinnings));
            } else if (playerOneDealerWinner == 2) {
                playerOne.anteWinnings += (playerOne.anteBet + playerOne.playBet);
                playerOne.totalWinnings += playerOne.anteWinnings * 2;
                anteWinningsTextFieldPlayer1.setText("Player one beats dealer. + $" + playerOne.anteWinnings);
            }
        }

        int playerTwoDealerWinner = ThreeCardLogic.compareHands(theDealer.dealersHand, playerTwo.hand);
        // System.out.println("Player Two vs Dealer status:" + playerTwoDealerWinner);
        if (playerTwo.decisionState == 1) { 
            if (playerTwoDealerWinner == 0) { // Tie breaker, everything is given back
                playerTwo.anteWinnings = 0;
                anteWinningsTextFieldPlayer2.setText("Player two ties with the dealer. + $0");
            } else if (playerTwoDealerWinner == 1) {
                playerTwo.anteWinnings -= (playerTwo.anteBet + playerTwo.playBet);
                anteWinningsTextFieldPlayer2.setText("Player two loses to dealer. - $" + Math.abs(playerTwo.anteWinnings));
            } else if (playerTwoDealerWinner == 2) {
                playerTwo.anteWinnings += (playerTwo.anteBet + playerTwo.playBet);
                playerTwo.totalWinnings += playerTwo.anteWinnings * 2;
                anteWinningsTextFieldPlayer2.setText("Player two beats dealer. + $" + playerTwo.anteWinnings);
            }
        }
        addPairPlusWinnings();
    
        dealerWasQualifiedPreviously = true;
        // Enable the next round button.
        nextRoundButton.setDisable(false);
    }

    // Both players need to push the READY button
    private void checkBothPlayerReadyStatus() {
        if (playerOne.readyState == 1 && playerTwo.readyState == 1) { 
            // Game starts inside this if-statement:
            
            // Clear unnecessary texts:
            anteWinningsTextFieldPlayer1.clear();
            anteWinningsTextFieldPlayer2.clear();
            pairPlusWinningsTextFieldPlayer1.clear();
            pairPlusWinningsTextFieldPlayer2.clear();
            dealerOutput.setText("");

            // Enable the FOLD and PLAY buttons:
            playButtonPlayer1.setDisable(false);
            playButtonPlayer2.setDisable(false);
            foldButtonPlayer1.setDisable(false);
            foldButtonPlayer2.setDisable(false);

            // Disable the ready buttons:   
            readyButtonPlayer1.setDisable(true);
            readyButtonPlayer2.setDisable(true);

            // Subtract their bets to their networth
            playerOne.totalWinnings = playerOne.totalWinnings - playerOne.anteBet - playerOne.pairPlusBet;
            playerTwo.totalWinnings = playerTwo.totalWinnings - playerTwo.anteBet - playerTwo.pairPlusBet; 
            updateTotalWinnings();

            // Deal out the cards:
            theDealer.dealersHand = theDealer.dealHand();
            playerOne.hand = theDealer.dealHand();
            playerTwo.hand = theDealer.dealHand();

            // Display the cards:
            faceAllCardsDown();
            distributeTheCardsToPlayers();

            // Now, we need to hear from the player (fold or play?)
            playerOne.decisionState = 0;
            playerTwo.decisionState = 0;
        }
    }

    // Both players need to make their own decision before the dealer reveals their cards
    private void checkBothPlayerDecisionStatus() {
        // If both are done with their decisions:
        if (playerOne.decisionState != 0 && playerTwo.decisionState != 0) {
            playerOne.pairPlusWinnings= 0;
            playerOne.anteWinnings = 0;
            playerTwo.pairPlusWinnings= 0;
            playerTwo.anteWinnings = 0;

            // This block of code represents the sequence of events
            // that happen before the dealer's card has been revealed
            if (playerOne.decisionState == 1) { // If player one decides to play, match their ante with their play bet
                playerOne.playBet = playerOne.anteBet;
                playerOne.totalWinnings -= playerOne.playBet;
      
                int pairPlusWinnings = ThreeCardLogic.evalPPWinnings(playerOne.hand, playerOne.pairPlusBet);
                if (pairPlusWinnings != 0) {
                    playerOne.pairPlusWinnings += pairPlusWinnings;
                    pairPlusWinningsTextFieldPlayer1.setText("Player one wins pair plus! + $" + playerOne.pairPlusWinnings);
                } else {
                    playerOne.pairPlusWinnings -= playerOne.pairPlusBet;
                    pairPlusWinningsTextFieldPlayer1.setText("Player one loses pair plus! - $" + Math.abs(playerOne.pairPlusWinnings));
                }
            }
            if (playerTwo.decisionState == 1) { // If player two decides to play, match their ante with their play bet
                playerTwo.playBet = playerTwo.anteBet;
                playerTwo.totalWinnings -= playerTwo.playBet;
    
                int pairPlusWinnings = ThreeCardLogic.evalPPWinnings(playerTwo.hand, playerTwo.pairPlusBet);
                if (pairPlusWinnings != 0) {
                    playerTwo.pairPlusWinnings += pairPlusWinnings;
                    pairPlusWinningsTextFieldPlayer2.setText("Player two wins pair plus! + $" + playerTwo.pairPlusWinnings);
                } else {
                    playerTwo.pairPlusWinnings -= playerTwo.pairPlusBet;
                    pairPlusWinningsTextFieldPlayer2.setText("Player two loses pair plus! - $" + Math.abs(playerTwo.pairPlusWinnings));
                }
            }
            updateTotalWinnings();
            revealDealerCards();
        }   
    }

    /* Event handlers for the main menu: 
    */ 
    public void menuPlayButtonClick(ActionEvent e) throws IOException {
        // System.out.println("Menu Play button clicked");
        // Get instance of the loader class
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/FXML/Game.fxml"));
        GameController.gameRoot = loader.load(); // Load view into parent
        GameController.gameRoot.getStylesheets().add("/styles/style2.css");
        root.getScene().setRoot(GameController.gameRoot); // update scene graph
	}

    public void menuQuitButtonClick(ActionEvent e) throws IOException {
        // System.out.println("Quit button clicked");
        // Get the Stage and close it
        Stage stage = (Stage) root.getScene().getWindow();
        stage.close();
    }

    /* Event handlers for the game: 
    */ 
    public void playButtonPlayer1OnAction(ActionEvent e) throws IOException {
        // System.out.println("Play Player 1");
        // Invalid, we are not expecting their decision:
        if (playerOne.decisionState != 0) return;

        playerOne.decisionState = 1;
        checkBothPlayerDecisionStatus();
    }

    public void foldButtonPlayer1OnAction(ActionEvent e) throws IOException {
        // System.out.println("Fold Player 1");

        // Invalid, we are not expecting their decision:
        if (playerOne.decisionState != 0) return;

        playerOne.decisionState = 2;
        checkBothPlayerDecisionStatus();
    }

    public void readyButtonPlayer1OnAction(ActionEvent e) throws IOException {
        // Alternates from 1 to 0 when ready button is clicked
        playerOne.readyState = 1 - playerOne.readyState; 

        // Set the bet of the player
        playerOne.setAnteBet(ThreeCardLogic.parseStringToInt(anteBetTextField1.getCharacters().toString()));
        playerOne.setPairPlusBet(ThreeCardLogic.parseStringToInt(pairPlusTextField1.getCharacters().toString()));
        
        // Enable or disable textfields depending on ready state
        anteBetTextField1.setDisable(playerOne.readyState == 1);
        pairPlusTextField1.setDisable(playerOne.readyState == 1);

        // Set the text fields into the actual bets
        anteBetTextField1.setText(Integer.toString(playerOne.anteBet));
        pairPlusTextField1.setText(Integer.toString(playerOne.pairPlusBet));

        checkBothPlayerReadyStatus();
        
        //  System.out.println("Ready Player 1 status: " + playerOne.readyState);
    }

    public void playButtonPlayer2OnAction(ActionEvent e) throws IOException {
        // System.out.println("Play Player 2");
        // Invalid, we are not expecting their decision:
        if (playerTwo.decisionState != 0) return;

        playerTwo.decisionState = 1;
        checkBothPlayerDecisionStatus();
    }

    public void foldButtonPlayer2OnAction(ActionEvent e) throws IOException {
        // System.out.println("Fold Player 2");

        // Invalid, we are not expecting their decision:
        if (playerTwo.decisionState != 0) return;

        playerTwo.decisionState = 2;
        checkBothPlayerDecisionStatus();
    }

    public void readyButtonPlayer2OnAction(ActionEvent e) throws IOException {
        // Alternates from 1 to 0 when ready button is clicked
        playerTwo.readyState = 1 - playerTwo.readyState; 

        // Set the bet of the player
        playerTwo.setAnteBet(ThreeCardLogic.parseStringToInt(anteBetTextField2.getCharacters().toString()));
        playerTwo.setPairPlusBet(ThreeCardLogic.parseStringToInt(pairPlusTextField2.getCharacters().toString()));
        
        // Enable or disable textfields depending on ready state
        anteBetTextField2.setDisable(playerTwo.readyState == 1);
        pairPlusTextField2.setDisable(playerTwo.readyState == 1);

        // Set the text fields into the actual bets
        anteBetTextField2.setText(Integer.toString(playerTwo.anteBet));
        pairPlusTextField2.setText(Integer.toString(playerTwo.pairPlusBet));

        checkBothPlayerReadyStatus();
        
        // System.out.println("Ready Player 2 status: " + playerTwo.readyState);
    }

    public void nextRoundButtonOnAction(ActionEvent e) throws IOException {
        // System.out.println("Next round clicked");
        setupNewRound();
        nextRoundButton.setDisable(true);
    }

    public void exitGame(ActionEvent e) throws IOException {
        // System.out.println("exitGame clicked");
        // Get instance of the loader class
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/FXML/Exit.fxml"));
        exitRoot = loader.load(); // Load view into parent
        exitRoot.getStylesheets().add("/styles/style1.css");
        GameController.gameRoot.getScene().setRoot(exitRoot); // update scene
    }

    public void resetGame(ActionEvent e) throws IOException {
        // System.out.println("resetGame clicked");
        playerOne.totalWinnings = 0;
        playerTwo.totalWinnings = 0;
        dealerWasQualifiedPreviously = true;
        setupNewRound();
    }

    public void changeTheme(ActionEvent e) throws IOException {
        // System.out.println("changeTheme clicked " + currentStyle);
        String newStyle = (currentStyle == 1) ? "/styles/style3.css" : "/styles/style2.css";
        String oldStyle = (currentStyle == 1) ? "/styles/style2.css" : "/styles/style3.css";
    
        // Remove the old stylesheet
        GameController.gameRoot.getStylesheets().remove(oldStyle);
    
        // Add the new stylesheet
        GameController.gameRoot.getStylesheets().add(newStyle);
    
        currentStyle = 1 - currentStyle;
    }

    /* Event handlers for the exit screen: 
    */ 
    public void continueButtonClick(ActionEvent e) throws IOException {
        exitRoot.getScene().setRoot(GameController.gameRoot); // update scene graph
	}
}
