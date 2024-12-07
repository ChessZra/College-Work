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
	@FXML private VBox root;

    /* Exit Screen FXML Decorators */
	@FXML private VBox exitRoot;

    /* Main Game FXML Decorators */ 
    @FXML private static BorderPane gameRoot;

    @FXML private VBox leftVBox;
    @FXML private VBox rightVBox;
    @FXML private VBox centerVBox;
    // Images:
    @FXML private ImageView dealerCard1Image;
    @FXML private ImageView dealerCard2Image;
    @FXML private ImageView dealerCard3Image;
    @FXML private ImageView player1Card1Image;
    @FXML private ImageView player1Card2Image;
    @FXML private ImageView player1Card3Image;
    @FXML private ImageView player2Card1Image;
    @FXML private ImageView player2Card2Image;
    @FXML private ImageView player2Card3Image;
    // TextFields:
    @FXML private TextField anteBetTextField1;
    @FXML private TextField anteBetTextField2;
    @FXML private TextField pairPlusTextField1;
    @FXML private TextField pairPlusTextField2;
    @FXML private TextField anteWinningsTextFieldPlayer1;
    @FXML private TextField anteWinningsTextFieldPlayer2;
    @FXML private TextField pairPlusWinningsTextFieldPlayer1;
    @FXML private TextField pairPlusWinningsTextFieldPlayer2;
    @FXML private TextField moneyTextField1;
    @FXML private TextField moneyTextField2;
    // Labels:
    @FXML private Label dealerOutput;
    // Buttons:
    @FXML private Button readyButtonPlayer1;
    @FXML private Button readyButtonPlayer2;
    @FXML private Button playButtonPlayer1;
    @FXML private Button playButtonPlayer2;
    @FXML private Button foldButtonPlayer1;
    @FXML private Button foldButtonPlayer2;
    @FXML private Button nextRoundButton;

    // Data members:
    private static boolean initialized = false;
    private static PokerInfo pf;

    // Local/Client side variables:
    private int currentStyle = 1;

    ArrayList<ImageView> player1Images;
    ArrayList<ImageView> player2Images;
    ArrayList<ImageView> theDealerImages;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
        if (!GameController.initialized) {
            System.out.println("Initializing PokerInfo");
            pf = ClientController.client.makeServerRequest(new PokerInfo("Initialize"));
            GameController.initialized = true;
        }

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
    private void updateTotalWinningsTextField() {
        moneyTextField1.setText("YOUR MONEY $" + Integer.toString(pf.playerOne.totalWinnings));
        moneyTextField2.setText("YOUR MONEY $" + Integer.toString(pf.playerTwo.totalWinnings));
    }

    private void distributeTheCardsToPlayers() {

        if (pf.playerOne.hand.size() == 3) {
            for (int i = 0; i < 3; i++) {
                // Create a pause that waits for (i * 1) seconds
                PauseTransition pause = new PauseTransition(Duration.seconds(i * 1));

                int index = i;
                pause.setOnFinished(event -> {
                    // In the format e.g: /images/C_10.png (10 of clubs)
                    String path = "/images/" + pf.playerOne.hand.get(index).suit + "_" + pf.playerOne.hand.get(index).value + ".png";
                    Image card = new Image(getClass().getResource(path).toExternalForm());
                    player1Images.get(index).setImage(card);
                });

                pause.play();
            }
        }
        if (pf.playerTwo.hand.size() == 3) {
            for (int i = 0; i < 3; i++) {
                // Create a pause that waits for (i * 1) seconds
                PauseTransition pause = new PauseTransition(Duration.seconds(i * 1));
                
                int index = i;
                pause.setOnFinished(event -> {
                    String path = "/images/" + pf.playerTwo.hand.get(index).suit + "_" + pf.playerTwo.hand.get(index).value + ".png";
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
                String path = "/images/" + pf.theDealer.dealersHand.get(index).suit + 
                             "_" + pf.theDealer.dealersHand.get(index).value + ".png";
                Image card = new Image(getClass().getResource(path).toExternalForm());
                theDealerImages.get(index).setImage(card);

                if (index == 2) {
                    displayGameResults();
                }
            });
            pause.play();
        }
    }

    private void setupNewRound() {
        updateTotalWinningsTextField();

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
        if (pf.dealerWasQualifiedPreviously == false && pf.playerOne.decisionState == 1) {
            anteBetTextField1.setDisable(true);
        }
        if (pf.dealerWasQualifiedPreviously == false && pf.playerTwo.decisionState == 1) {
            anteBetTextField2.setDisable(true);
        }

        faceAllCardsDown();
    }

    // A callback function - once the dealer's cards have been revealed 
    private void displayGameResults() {
        PokerInfo updateServer = new PokerInfo("EvaluateHands");
        updateServer.playerTwoAnteBet = parseStringToInt(anteBetTextField2.getCharacters().toString());
        updateServer.playerTwoPairPlusBet = parseStringToInt(pairPlusTextField2.getCharacters().toString());
        pf = ClientController.client.makeServerRequest(updateServer);

        // Check if anyone folded:
        if (pf.playerOne.decisionState == 2) {
            anteWinningsTextFieldPlayer1.setText("Fold - lost your ante bet.");
            pairPlusWinningsTextFieldPlayer1.setText("Fold - lost your pair plus bet!");
        }

        if (pf.playerTwo.decisionState == 2) {
            anteWinningsTextFieldPlayer2.setText("Fold - lost your ante bet.");
            pairPlusWinningsTextFieldPlayer2.setText("Fold - lost your pair plus bet!");
        }

        if (pf.response.equals("DEALER_DID_NOT_QUALIFY")) {
            dealerOutput.setText("Dealer does not have at least Queen high; ante wager is pushed");

            if (pf.playerOne.decisionState == 1) {
                anteWinningsTextFieldPlayer1.setText("+ $0 | Ante is pushed to the next hand.");
            }
            if (pf.playerTwo.decisionState == 1) {
                anteWinningsTextFieldPlayer2.setText("+ $0 | Ante is pushed to the next hand.");
            }
            // Enable the next round button.
            nextRoundButton.setDisable(false);
            return; 
        }

        if (pf.playerOne.decisionState == 1) {
            if (pf.dealerVsPlayerOne == 0) {
                anteWinningsTextFieldPlayer1.setText("Player one ties with the dealer. + $0");
            } else if (pf.dealerVsPlayerOne == 2) {
                anteWinningsTextFieldPlayer1.setText("Player one loses to dealer. - $" + Math.abs(pf.playerOne.anteWinnings));
            } else if (pf.dealerVsPlayerOne == 1) {
                anteWinningsTextFieldPlayer1.setText("Player one beats dealer. + $" + pf.playerOne.anteWinnings);
            }
        }

        if (pf.playerTwo.decisionState == 1) {
            if (pf.dealerVsPlayerTwo == 0) {
                anteWinningsTextFieldPlayer2.setText("Player two ties with the dealer. + $0");
            } else if (pf.dealerVsPlayerTwo == 2) {
                anteWinningsTextFieldPlayer2.setText("Player two loses to dealer. - $" + Math.abs(pf.playerTwo.anteWinnings));
            } else if (pf.dealerVsPlayerTwo == 1) {
                anteWinningsTextFieldPlayer2.setText("Player two beats dealer. + $" + pf.playerTwo.anteWinnings);
            }
        }

        // Enable the next round button.
        nextRoundButton.setDisable(false);
    }

    // Both players need to push the READY button
    private void makeFoldOrPlayDecision() {        
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

        // Disable READY buttons:   
        readyButtonPlayer1.setDisable(true);
        readyButtonPlayer2.setDisable(true);

        // update TotalWinningsField based on server's response
        updateTotalWinningsTextField();

        System.out.println("STAGE 1:");
        System.out.println("Server: " + pf.playerOne.totalWinnings + " " + pf.playerTwo.totalWinnings);
        
        // Display the cards:
        faceAllCardsDown(); 
        distributeTheCardsToPlayers();
    }

    // The function that gets called when both players are done making their decision (PLAY, FOLD)
    // AND that we have heard from the server already.
    private void bothPlayerDecisionAreReady() {

        if (pf.playerOne.pairPlusWinnings > 0) {
            pairPlusWinningsTextFieldPlayer1.setText("Player one wins pair plus! + $" + pf.playerOne.pairPlusWinnings);
        } else if (pf.playerOne.pairPlusWinnings < 0) {
            pairPlusWinningsTextFieldPlayer1.setText("Player one loses pair plus! - $" + Math.abs(pf.playerOne.pairPlusWinnings));
        }

        if (pf.playerTwo.pairPlusWinnings > 0) {
            pairPlusWinningsTextFieldPlayer2.setText("Player two wins pair plus! + $" + pf.playerTwo.pairPlusWinnings);
        } else if (pf.playerTwo.pairPlusWinnings < 0) {
            pairPlusWinningsTextFieldPlayer2.setText("Player two loses pair plus! - $" + Math.abs(pf.playerTwo.pairPlusWinnings));
        }

        updateTotalWinningsTextField();
        revealDealerCards();
    }

    /* Event handlers for the game: 
    */ 
    public void readyButtonPlayer1OnAction(ActionEvent e) throws IOException {
         
        PokerInfo updateServer = new PokerInfo("ReadyPlayerOne");
        updateServer.playerOneAnteBet = parseStringToInt(anteBetTextField1.getCharacters().toString());
        updateServer.playerOnePairPlusBet = parseStringToInt(pairPlusTextField1.getCharacters().toString());
        pf = ClientController.client.makeServerRequest(updateServer);

        // Enable or disable textfields depending on ready state
        anteBetTextField1.setDisable(pf.playerOne.readyState == 1);
        pairPlusTextField1.setDisable(pf.playerOne.readyState == 1);

        // Set the text fields into the actual bets
        anteBetTextField1.setText(Integer.toString(pf.playerOne.anteBet));
        pairPlusTextField1.setText(Integer.toString(pf.playerOne.pairPlusBet));
        
        if (pf.response.equals("MAKE_DECISION")) {
            makeFoldOrPlayDecision();
        }
    }

    public void readyButtonPlayer2OnAction(ActionEvent e) throws IOException {

        PokerInfo updateServer = new PokerInfo("ReadyPlayerTwo");
        updateServer.playerTwoAnteBet = parseStringToInt(anteBetTextField2.getCharacters().toString());
        updateServer.playerTwoPairPlusBet = parseStringToInt(pairPlusTextField2.getCharacters().toString());
        pf = ClientController.client.makeServerRequest(updateServer);
        
        // Enable or disable textfields depending on ready state
        anteBetTextField2.setDisable(pf.playerTwo.readyState == 1);
        pairPlusTextField2.setDisable(pf.playerTwo.readyState == 1);

        // Set the text fields into the actual bets
        anteBetTextField2.setText(Integer.toString(pf.playerTwo.anteBet));
        pairPlusTextField2.setText(Integer.toString(pf.playerTwo.pairPlusBet));

        if (pf.response.equals("MAKE_DECISION")) {
            makeFoldOrPlayDecision();
        }
    }

    public void playButtonPlayer1OnAction(ActionEvent e) throws IOException {

        PokerInfo updateServer = new PokerInfo("PlayPlayerOne");
        pf = ClientController.client.makeServerRequest(updateServer);

        // Invalid, server was not expecting their decision:
        if (pf.response.equals("NOT_EXPECTING")) return;
        
        if (pf.response.equals("REVEAL_DEALER_CARDS")) {
            bothPlayerDecisionAreReady();
        }
    }

    public void playButtonPlayer2OnAction(ActionEvent e) throws IOException {

        PokerInfo updateServer = new PokerInfo("PlayPlayerTwo");
        pf = ClientController.client.makeServerRequest(updateServer);

        // Invalid, server was not expecting their decision:
        if (pf.response.equals("NOT_EXPECTING")) return;

        if (pf.response.equals("REVEAL_DEALER_CARDS")) {
            bothPlayerDecisionAreReady();
        }
    }

    public void foldButtonPlayer1OnAction(ActionEvent e) throws IOException {

        PokerInfo updateServer = new PokerInfo("FoldPlayerOne");
        pf = ClientController.client.makeServerRequest(updateServer);

        // Invalid, server was not expecting their decision:
        if (pf.response.equals("NOT_EXPECTING")) return;

        if (pf.response.equals("REVEAL_DEALER_CARDS")) {
            bothPlayerDecisionAreReady();
        }
    }

    public void foldButtonPlayer2OnAction(ActionEvent e) throws IOException {
        PokerInfo updateServer = new PokerInfo("FoldPlayerTwo");
        pf = ClientController.client.makeServerRequest(updateServer);

        // Invalid, server was not expecting their decision:
        if (pf.response.equals("NOT_EXPECTING")) return;

        if (pf.response.equals("REVEAL_DEALER_CARDS")) {
            bothPlayerDecisionAreReady();
        }
    }

    public void nextRoundButtonOnAction(ActionEvent e) throws IOException {
        PokerInfo updateServer = new PokerInfo("NextRoundButton");
        pf = ClientController.client.makeServerRequest(updateServer);
        
        setupNewRound();
        nextRoundButton.setDisable(true);
    }

    public void resetGame(ActionEvent e) throws IOException {
        PokerInfo updateServer = new PokerInfo("ResetGameButton");
        pf = ClientController.client.makeServerRequest(updateServer);

        setupNewRound();
    }

    public int parseStringToInt(String str) {
        try {
            return Integer.parseInt(str);
        } catch (NumberFormatException e) {
            return 0;
        }
    }
    
    public void exitGame(ActionEvent e) throws IOException {
        // Get instance of the loader class
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/FXML/Exit.fxml"));
        exitRoot = loader.load(); // Load view into parent
        exitRoot.getStylesheets().add("/styles/style10.css");
        GameController.gameRoot.getScene().setRoot(exitRoot); // update scene
    }

    public void changeTheme(ActionEvent e) throws IOException {
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

    public void exitQuitButtonClick(ActionEvent e) throws IOException {
        // Get the Stage and close it
        Stage stage = (Stage) exitRoot.getScene().getWindow();
        stage.close();
    }

    /* Event handlers for the main menu: 
    */ 
    public void menuPlayButtonClick(ActionEvent e) throws IOException {
        // Get instance of the loader class
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/FXML/Game.fxml"));
        GameController.gameRoot = loader.load(); // Load view into parent
        GameController.gameRoot.getStylesheets().add("/styles/style2.css");
        root.getScene().setRoot(GameController.gameRoot); // update scene graph
	}

    public void menuQuitButtonClick(ActionEvent e) throws IOException {
        // Get the Stage and close it
        Stage stage = (Stage) root.getScene().getWindow();
        stage.close();
    }
}
