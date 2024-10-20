import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

public class JavaFXTemplate extends Application {

	private Stage stage;
	private Scene scene;
	private BorderPane root;
	private Button button1;
	private Button button2;
	private TextField promptTextField;
	private TextField outputTextField;

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		launch(args);
	}
	
	@Override
	public void start(Stage primaryStage) throws Exception {
		// Set the title for the application:
		primaryStage.setTitle("John Ezra See Homework 3");
		stage = primaryStage;
		
		// Create the root and scene:
		this.root = new BorderPane();
		this.scene = new Scene(this.root, 700,700);

		// Create the textfields:
		this.promptTextField = new TextField("enter text here then press button 1");	// User can type here
		this.outputTextField = new TextField("final string goes here");	// User cannot type here
		this.outputTextField.setEditable(false);

		// Create the buttons:
		this.button1 = new Button("button 1");
		this.button2 = new Button("button 2");
		VBox vbox = new VBox(8, button1, button2);

        // Make it look good:
        vbox.setAlignment(Pos.CENTER);
        vbox.setPadding(new Insets(10));
		BorderPane.setAlignment(this.outputTextField, Pos.CENTER);
		BorderPane.setAlignment(this.promptTextField, Pos.CENTER);
		BorderPane.setMargin(this.outputTextField, new Insets(10));
		BorderPane.setMargin(this.promptTextField, new Insets(10));
		this.outputTextField.setPrefSize(350, 100);
		this.promptTextField.setPrefSize(200, 100);	
		this.root.setStyle("-fx-background-color: #F0F8FF;"); // Light blue background

		// Add functionality:
		this.button1.setOnAction(new EventHandler<ActionEvent>() {
			@Override
			public void handle(ActionEvent event) {
				outputTextField.setText(promptTextField.getCharacters().toString() + ": from the center text field!");
				button1.setText("pressed");
				button1.setDisable(true);
			}
		});

        this.button2.setOnAction(event -> { 
			promptTextField.clear();
			outputTextField.setText("final string goes here");
			button1.setText("button1");
			button1.setDisable(false);
        });

		// Set the borderPane children:
		this.root.setCenter(this.promptTextField);
		this.root.setRight(this.outputTextField);
		this.root.setLeft(vbox);
		
		// Set the scene then display the GUI:
		this.stage.setScene(this.scene);
		this.stage.show();
	
	}
}
