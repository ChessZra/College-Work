import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

public class Client extends Thread {

    int port;
    String ipAddress;
	ObjectInputStream in;
	ObjectOutputStream out;
    Socket connection;

    Client(int port, String ipAddress) {
        this.port = port;
        this.ipAddress = ipAddress;
    }

    public PokerInfo makeServerRequest(PokerInfo pf) {
        try {
            // Send the request to the server
            out.reset();
            out.writeObject(pf);
            out.flush();

            // Read the response from the server
            PokerInfo response = (PokerInfo) in.readObject();
            
            // Log the full response details for debugging
            System.out.println("Full Response from server: ");
            System.out.println("Request Type: " + response.request);
            System.out.println("Response: " + response.response);
            System.out.println("Player One Ante Bet: " + response.playerOneAnteBet);
            System.out.println("Player One Ready State: " + response.playerOne.readyState);
            
            return response;
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public void start() {

        try {
            Socket connection = new Socket(this.ipAddress, this.port);
            in = new ObjectInputStream(connection.getInputStream());
            out = new ObjectOutputStream(connection.getOutputStream());
            connection.setTcpNoDelay(true);
        } catch (IOException e) {
            System.out.println("Client exception: Streams didn't open");
        }

        System.out.println("Streams opened");
    }

}
