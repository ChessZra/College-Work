import javafx.animation.FadeTransition;
import javafx.animation.PauseTransition;
import javafx.animation.RotateTransition;
import javafx.animation.SequentialTransition;
import javafx.application.Application;

import javafx.scene.Scene;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.stage.Stage;
import javafx.util.Duration;


public class JavaFXTemplate extends Application {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		launch(args);
	}

	//feel free to remove the starter code from this method
	@Override
	public void start(Stage primaryStage) throws Exception {
		// TODO Auto-generated method stub
		primaryStage.setTitle("Welcome to JavaFX");
		
		 Rectangle rect = new Rectangle (100, 40, 100, 100);
	     rect.setArcHeight(50);
	     rect.setArcWidth(50);
	     rect.setFill(Color.VIOLET);

	     RotateTransition rt = new RotateTransition(Duration.millis(5000), rect);
	     rt.setByAngle(270);
	     rt.setCycleCount(4);
	     rt.setAutoReverse(true);
	     SequentialTransition seqTransition = new SequentialTransition (
	         new PauseTransition(Duration.millis(500)),
	         rt
	     );
	     seqTransition.play();
	     
	     FadeTransition ft = new FadeTransition(Duration.millis(5000), rect);
	     ft.setFromValue(1.0);
	     ft.setToValue(0.3);
	     ft.setCycleCount(4);
	     ft.setAutoReverse(true);

	     ft.play();
	     BorderPane root = new BorderPane();
	     root.setCenter(rect);
	     
	     Scene scene = new Scene(root, 700,700);
			primaryStage.setScene(scene);
			primaryStage.show();
		
				
		
	}

}
