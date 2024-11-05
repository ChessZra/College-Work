import javafx.animation.FadeTransition;
import javafx.animation.PauseTransition;
import javafx.animation.RotateTransition;
import javafx.animation.SequentialTransition;
import javafx.application.Application;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.stage.Stage;
import javafx.util.Duration;
import javafx.scene.control.Button;
// just added:
import javafx.scene.control.TextField;
import javafx.scene.layout.HBox;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXMLLoader;

public class JavaFXTemplate extends Application {
	Player playerOne;
	Player playerTwo;
	Dealer theDealer;
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		launch(args);
	}

	@Override
	public void start(Stage primaryStage) throws Exception {
		
		playerOne = new Player();
		playerTwo = new Player();
		theDealer = new Dealer();
		try {
			// Read file fxml and draw interface.
			Parent root = FXMLLoader.load(getClass().getResource("/FXML/Menu.fxml"));
			primaryStage.setTitle("Three Card Poker");
			Scene s1 = new Scene(root, 1000, 500);
			s1.getStylesheets().add("/styles/style1.css");
			primaryStage.setScene(s1);
			primaryStage.show();
		} catch(Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
}
