import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.VBox;
import javafx.scene.layout.HBox;

public class MyController implements Initializable {

    // Root and nodes for the main menu:
	@FXML
	private VBox root;

    // Root for the main game
    @FXML
    private BorderPane root2;
    @FXML
    private VBox leftVBox;
    @FXML
    private VBox rightVBox;
    @FXML
    private VBox centerVBox;
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

    private Player playerOne;
    private Player playerTwo;
    private Dealer theDealer;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub
	}

    // public void initializeGameState(Player p1, Player p2, Dealer dealer) {
    //     this.playerOne = p1;
    //     this.playerTwo = p2;
    //     this.theDealer = dealer;
    //     // Now you can use these objects in your event handlers
    // }

    // Event handlers for the main menu:
    public void menuPlayButtonClick(ActionEvent e) throws IOException {
        System.out.println("Menu Play button clicked");
    
        // Get instance of the loader class
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/FXML/Game.fxml"));
        Parent root2 = loader.load(); // Load view into parent
        root2.getStylesheets().add("/styles/style2.css");
        root.getScene().setRoot(root2); //update scene graph
	}

    public void menuQuitButtonClick(ActionEvent e) throws IOException {
        System.out.println("Quit button clicked");
    }

    // Event handlers for the game:
    public void playButtonPlayer1(ActionEvent e) throws IOException {
        System.out.println("Play Player 1");
    }

    public void foldButtonPlayer1(ActionEvent e) throws IOException {
        System.out.println("Fold Player 1");
    }

    public void readyButtonPlayer1(ActionEvent e) throws IOException {
        System.out.println("Ready Player 1");
    }

    public void playButtonPlayer2(ActionEvent e) throws IOException {
        System.out.println("Play Player 2");
    }

    public void foldButtonPlayer2(ActionEvent e) throws IOException {
        System.out.println("Fold Player 2");
    }

    public void readyButtonPlayer2(ActionEvent e) throws IOException {
        System.out.println("Ready Player 2");
    }

    public void optionButton(ActionEvent e) throws IOException {
        System.out.println("Option Button Clicked");
    }
}
