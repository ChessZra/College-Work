import java.io.IOException;
import java.util.ArrayList;

public class ServerInfo {
    private int connectedClients;
    private int clientCount;
    private ArrayList<Server.ClientThread> clients;

    ServerInfo() {
        this.connectedClients = 0;
        this.clientCount = 0;
        clients = new ArrayList<Server.ClientThread>();
    }

    public synchronized int getConnectedClients() {
        return connectedClients;
    }

    public synchronized int getClientCount() {
        return clientCount;
    }

    public synchronized void clientConnected(Server.ClientThread t) {
        clients.add(t);
        connectedClients++;
        clientCount++;
    }

    public synchronized void clientDisconnected(Server.ClientThread t) {
        for (int i = 0; i < clients.size(); i++) {
            if (t == clients.get(i)) {
                try {
                    t.connection.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                clients.remove(i);
                break;
            }
        }
        connectedClients--;
    }

    public synchronized void stopAndRemoveClients() {
        clientCount = 0;
        for (int i = 0; i < clients.size(); i++) {
            try {
                System.out.println("Closing client " + clients.get(i).clientNumber);
                clients.get(i).connection.close();
            } catch (IOException e) {
                System.out.println("Failed closing client " + clients.get(i).clientNumber);
                e.printStackTrace();
            }
        }
        clients.clear();
    }
}


