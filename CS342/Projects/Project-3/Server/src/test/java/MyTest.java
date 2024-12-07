import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import java.net.Socket;

class ServerInfoTest {
    private ServerInfo serverInfo;
    private Server.ClientThread mockClientThread;
	private Server.ClientThread mockClientThread2;

    @BeforeEach
    void setUp() {
        serverInfo = new ServerInfo();
        
        // Create a mock Server instance first
        Server mockServer = new Server(8080, data -> {});
        
        // Create a mock ClientThread using the mock Server
        mockClientThread = mockServer.new ClientThread(null, 1);
		mockClientThread2 = mockServer.new ClientThread(null, 1);
    }

    @Test
    void testInitialState() {
        assertEquals(0, serverInfo.getConnectedClients());
        assertEquals(0, serverInfo.getClientCount());
    }

    @Test
    void testClientConnection() {
        serverInfo.clientConnected(mockClientThread);
        assertEquals(1, serverInfo.getConnectedClients());
        assertEquals(1, serverInfo.getClientCount());
    }

    @Test
    void testTwoClientConnection() {
        // Connect the first client
        serverInfo.clientConnected(mockClientThread);
        assertEquals(1, serverInfo.getConnectedClients());
        assertEquals(1, serverInfo.getClientCount());

        // Connect the second client
        serverInfo.clientConnected(mockClientThread2);
        assertEquals(2, serverInfo.getConnectedClients());
        assertEquals(2, serverInfo.getClientCount());
    }

	@Test
	void testMultipleClientConnections() {
		// Simulate adding a large number of clients
		int numberOfClients = 100;
		for (int i = 0; i < numberOfClients; i++) {
			Server.ClientThread newClient = new Server(8080, data -> {}).new ClientThread(null, i);
			serverInfo.clientConnected(newClient);
		}

		// Verify the counts
		assertEquals(numberOfClients, serverInfo.getConnectedClients());
		assertEquals(numberOfClients, serverInfo.getClientCount());
	}

	@Test
	void testDuplicateClientConnection() {
		// Connect the same client twice
		serverInfo.clientConnected(mockClientThread);
		serverInfo.clientConnected(mockClientThread);
	
		// Verify the behavior
		assertEquals(2, serverInfo.getConnectedClients());
		assertEquals(2, serverInfo.getClientCount());
	}

}
