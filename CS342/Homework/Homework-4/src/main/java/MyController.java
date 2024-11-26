import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.VBox;
import javafx.scene.control.Button;

public class MyController implements Initializable {

    @FXML
    private static BorderPane root;

    @FXML
    private VBox leftVBox;
    
    @FXML
    private TextField basicCoffee;
    
    @FXML
    private TextField cinnamon;
    
    @FXML
    private TextField cream;
    
    @FXML
    private TextField extraShot;
    
    @FXML
    private TextField honey;
    
    @FXML
    private TextField sugar;
    
    @FXML
    private VBox orderSummaryVBox;
    
    @FXML
    private TextArea orderSummaryTextArea;
    
    @FXML
    private VBox orderTotalVBox;
    
    @FXML
    private Label totalLabel;

    @FXML
    private Button createButton;

    @FXML
    private Button deleteButton;

    public static int parseStringToInt(String str) {
        try {
            return Integer.parseInt(str);
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        // Nothing to do in this state
    }

    public void createOnAction(ActionEvent e) throws IOException {

        int coffeeAmount = parseStringToInt(basicCoffee.getCharacters().toString());
        int cinnamonAmount = parseStringToInt(cinnamon.getCharacters().toString());
        int creamAmount = parseStringToInt(cream.getCharacters().toString());
        int extraShotAmount = parseStringToInt(extraShot.getCharacters().toString());
        int honeyAmount = parseStringToInt(honey.getCharacters().toString());
        int sugarAmount = parseStringToInt(sugar.getCharacters().toString());
        
        if (coffeeAmount == 0) return; // No order

        Order order = new Order(coffeeAmount, cinnamonAmount, creamAmount, extraShotAmount, honeyAmount, sugarAmount);

        orderSummaryTextArea.setText(order.getOrderSummary());
        totalLabel.setText(String.format("Single Coffee Total: $%.2f\nTotal Order Cost: $%.2f", order.getSingleCoffeeCost(), order.getTotalOrderCost()));

        createButton.setDisable(true);
        deleteButton.setText("Order again");
    }

    public void deleteOnAction(ActionEvent e) throws IOException {
        basicCoffee.clear();
        cinnamon.clear();
        cream.clear();
        extraShot.clear();
        honey.clear();
        sugar.clear();
        orderSummaryTextArea.clear();
        totalLabel.setText("Order Total: $0.00");
        deleteButton.setText("Delete");
        createButton.setDisable(false);
    }
}