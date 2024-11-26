import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class JavaFXTemplate extends Application {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		launch(args);
	}

	@Override
	public void start(Stage primaryStage) throws Exception {
		try {
			// Read file fxml and draw interface.
			Parent root = FXMLLoader.load(getClass().getResource("/FXML/gui.fxml"));
			primaryStage.setTitle("Coffee Maker");
			Scene s1 = new Scene(root, 700, 500);
			s1.getStylesheets().add("/styles/style.css");
			primaryStage.setScene(s1);
			primaryStage.show();
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
}
