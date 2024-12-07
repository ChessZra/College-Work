import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;
import javafx.scene.layout.StackPane;

import java.io.IOException;

import javafx.event.ActionEvent;

public class ClientController {
    @FXML private StackPane root;
    @FXML private TextField portTextField;
    @FXML private TextField ipTextField;
    
    public static Client client;
    
    public void connectToServer(int port, String ipAddress) throws IOException {
        ClientController.client = new Client(port, ipAddress);
        ClientController.client.start();

        FXMLLoader loader = new FXMLLoader(getClass().getResource("/FXML/Menu.fxml"));
        Parent menuRoot = loader.load();
        Scene currentScene = root.getScene();
        currentScene.getStylesheets().add("/styles/style10.css");
        currentScene.setRoot(menuRoot);
    }
    
    @FXML
    public void goButtonOnAction(ActionEvent event) {
        try {
            String portText = portTextField.getText().trim();
            if (portText.isEmpty()) {
                alertPopUp("Please enter a port number.");
                return;
            }
            int port = Integer.parseInt(portText);
            
            String ipAddress = ipTextField.getText().trim();
            if (ipAddress.isEmpty()) {
                ipAddress = "127.0.0.1";
            }
            connectToServer(port, ipAddress);
        } catch (Exception e) {
            alertPopUp("An error occurred: " + e.getMessage());
        }
    }

    private void alertPopUp(String message) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Alert");
        alert.setContentText(message);
        alert.showAndWait();
    }
}