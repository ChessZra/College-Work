import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.VBox;

import java.io.IOException;

import javafx.event.ActionEvent;
import javafx.stage.Stage;

import javafx.application.Platform;
import javafx.scene.control.ListView;

public class ServerController {

    /* Server GUI FXML */
    @FXML VBox guiRoot;
    @FXML Label connectedClientsLabel;
    @FXML Label serverStatusLabel;
    @FXML ListView<String> gameEventsListView;
    @FXML Button stopServerButton;

    /* Intro Screen Decorators */
    @FXML private VBox root;
    @FXML private TextField portTextField;
    
    private static Server server;
    private static boolean isRunning;
    private static int port;

    @FXML
    public void initialize() {
        System.out.println("Initializing ServerController");
        System.out.println("GameEventsListView: " + gameEventsListView);
    }

    public void startServer() {    
        isRunning = true;    
        ServerController.server = new Server(ServerController.port, data -> {
            Platform.runLater(() -> {
                // Add the data to the game events log
                gameEventsListView.getItems().add(data.toString());
                
                // Update the number of clients
                connectedClientsLabel.setText("" + server.serverInfo.getConnectedClients());

                gameEventsListView.scrollTo(gameEventsListView.getItems().size() - 1);
            });
        });
    }

    public void launchServerGUI() throws IOException {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/FXML/ServerGUI.fxml"));
        guiRoot = loader.load(); 
        guiRoot.getStylesheets().add("/styles/style1.css");
        root.getScene().setRoot(guiRoot); // update scene
    }
    
    @FXML
    public void goButtonOnAction(ActionEvent e) throws IOException {
        try {
            String portText = portTextField.getText().trim();
            
            if (portText.isEmpty()) {
                alertPopUp("Please enter a port number.");
                return;
            }
            ServerController.port = Integer.parseInt(portText);           
            if (ServerController.port < 1 || ServerController.port > 65535) {
                alertPopUp("Port number must be between 1 and 65535.");
                return;
            }

            ServerController.isRunning = false;
            launchServerGUI();
        } catch (NumberFormatException ex) {
            alertPopUp("Invalid port number. Please enter a valid integer.");
        }
    }

    @FXML
    public void stopServerOnAction(ActionEvent event) throws IOException {
        if (isRunning) {
            isRunning = false;
            ServerController.server.stopServer();
            stopServerButton.setText("Start Server");
            stopServerButton.setStyle("-fx-background-color: green; -fx-text-fill: white;");

            // Update server status label
            serverStatusLabel.setText("Offline");
            serverStatusLabel.setStyle("-fx-text-fill: red;");
        } else {
            startServer();
            stopServerButton.setText("Stop Server");
            stopServerButton.setStyle("-fx-background-color: red; -fx-text-fill: white;");

            // Update server status label
            serverStatusLabel.setText("Online");
            serverStatusLabel.setStyle("-fx-text-fill: green;");
        }
    }

    @FXML
    public void exitButtonOnAction(ActionEvent e) {
        Stage stage = (Stage) portTextField.getScene().getWindow();
        stage.close();
    }
    
    private void alertPopUp(String message) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Alert");
        alert.setContentText(message);
        alert.showAndWait();
    }
}
