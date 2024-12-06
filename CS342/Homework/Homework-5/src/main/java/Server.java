import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.function.Consumer;

import javafx.application.Platform;
import javafx.scene.control.ListView;
/*
 * Clicker: A: I really get it    B: No idea what you are talking about
 * C: kind of following
 */

public class Server {

	int count = 1;	
	ArrayList<ClientThread> clients = new ArrayList<ClientThread>();
	TheServer server;
	private Consumer<Serializable> callback;
	
	private synchronized int getAndIncrementCount() {
		return count++;
	}
	
	Server(Consumer<Serializable> call) {
	
		callback = call;
		server = new TheServer();
		server.start();
	}
	
	
	public class TheServer extends Thread {
		
		public void run() {
	
			try(ServerSocket mysocket = new ServerSocket(5555);){
		    System.out.println("Server is waiting for a client!");
		  
	
		    while(true) {

				ClientThread c = new ClientThread(mysocket.accept(), getAndIncrementCount());
				callback.accept("client has connected to server: " + "client #" + count);
					// Added synchronization for clients
					// This will ensure proper count and client updates.
					synchronized (clients) {
						clients.add(c);
						c.start();
					}
					
			    }
			}//end of try
				catch(Exception e) {
					callback.accept("Server socket did not launch");
				}
			}//end of while
		}
	

		class ClientThread extends Thread {
			
		
			Socket connection;
			int count;
			ObjectInputStream in;
			ObjectOutputStream out;
			
			ClientThread(Socket s, int count){
				this.connection = s;
				this.count = count;	
			}
			
			public void updateClients(String message) {
				// Added this to ensure that clients doesn't change
				// when we're updating the messages
				synchronized (clients) {
					for(int i = 0; i < clients.size(); i++) {
						ClientThread t = clients.get(i);
						try {
						 t.out.writeObject(message);
						}
						catch(Exception e) {}
					}
				}
			}
			
			public void run(){
					
				try {
					in = new ObjectInputStream(connection.getInputStream());
					out = new ObjectOutputStream(connection.getOutputStream());
					connection.setTcpNoDelay(true);	
				}
				catch(Exception e) {
					System.out.println("Streams not open");
				}
				
				updateClients("new client on server: client #"+count);
					
				 while(true) {
					    try {
					    	String data = in.readObject().toString();
					    	callback.accept("client: " + count + " sent: " + data);
					    	updateClients("client #"+count+" said: "+data);
					    	
					    	}
					    catch(Exception e) {
					    	callback.accept("OOOOPPs...Something wrong with the socket from client: " + count + "....closing down!");
					    	updateClients("Client #"+count+" has left the server!");
							
							// Added this because we're modifying clients
							synchronized(clients) {
								clients.remove(this);
							}
					    	break;
					    }
					}
				}//end of run
			
			
		}//end of client thread
}


	
	

	
