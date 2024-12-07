import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.function.Consumer;

import javafx.event.ActionEvent;

public class Server {

    ServerInfo serverInfo;
    TheServer serverThread;
    private Consumer<Serializable> callback;
    private volatile boolean isRunning = true; // Add this field

    Server(int port, Consumer<Serializable> callback) {
        this.serverThread = new TheServer(port);
        this.serverInfo = new ServerInfo(); // Race condition
        this.callback = callback;
        startServer();
    }

    public void startServer() {
        serverThread.start();
    }

    public void stopServer() {
        isRunning = false;
        try {
            // Close the server socket to stop accepting new connections
            if (serverThread.serverSocket != null) {
                serverThread.serverSocket.close();
            }
        } catch (IOException e) {
            callback.accept("Error closing server socket: " + e.getMessage());
        }
        // Interrupt the server thread
        serverThread.interrupt();
        serverInfo.stopAndRemoveClients();
    }

	public class TheServer extends Thread {
		private int port;
        ServerSocket serverSocket;

        TheServer(int port) {
            this.port = port;
        }

		public void run() {
            try {
                serverSocket = new ServerSocket(this.port);
                callback.accept("Server thread running at port: " + port);
                callback.accept("Accepting clients...");
                while (true) {
                    Socket connection = serverSocket.accept();
                    ClientThread client = new ClientThread(connection, serverInfo.getClientCount());
                    serverInfo.clientConnected(client);
                    client.start();
                }
            } catch (IOException e){
                if (isRunning) { // Only print if not intentionally stopped
                    callback.accept("Server thread: interrupted, still running");
                } else {
                    callback.accept("Server thread: interrupted, stopping");
                }
            } 
		}
	}

    public class ClientThread extends Thread {
        int clientNumber;
        Socket connection;
        ObjectInputStream in;
        ObjectOutputStream out;

        PokerInfo pf;

        ClientThread(Socket connection, int clientNumber) {
            this.clientNumber = clientNumber;
            this.connection = connection;
        }
 
        public void run() {
            try {
                out = new ObjectOutputStream(connection.getOutputStream());
                in = new ObjectInputStream(connection.getInputStream());
            } catch (IOException e) {
                callback.accept("Client thread " + clientNumber + ": Streams didn't open");
            } 

            callback.accept("Client thread " + clientNumber + ": Streams opened");
            
            while (true) {
                try {
                    PokerInfo request = (PokerInfo) in.readObject();
                    handleRequest(request);
                } catch (Exception e) {
                    serverInfo.clientDisconnected(this);
                    callback.accept("Client thread " + clientNumber + ": Disconnected.");
                    break;
                }
            }
        }

        public void handleRequest(PokerInfo request) {
            try {
                // React to request 
                if (pf != null) {
                    synchronizePokerInfoRequests(request);
                }
                callback.accept("Client thread " + clientNumber + ": (REQUEST) " + request.request);
                if (request.request.equals("Initialize")) {
                    handleInitialization();
                } else if (request.request.equals("ReadyPlayerOne")) {
                    readyButtonPlayer1OnAction();
                } else if (request.request.equals("ReadyPlayerTwo")) {
                    readyButtonPlayer2OnAction();
                } else if (request.request.equals("PlayPlayerOne")) {
                    playButtonPlayer1OnAction();
                } else if (request.request.equals("PlayPlayerTwo")) {
                    playButtonPlayer2OnAction();
                } else if (request.request.equals("FoldPlayerOne")) {
                    foldButtonPlayer1OnAction();
                } else if (request.request.equals("FoldPlayerTwo")) {
                    foldButtonPlayer2OnAction();
                } else if (request.request.equals("EvaluateHands")) {
                    evaluateGame();
                } else if (request.request.equals("NextRoundButton")) {
                    setupNewRound();
                } else if (request.request.equals("ResetGameButton")) {
                    resetGameOnAction();
                }

            } catch (Exception e) {
                callback.accept("Client thread " + clientNumber + ": (REQUEST) Exception occured");
            }

            // Send back response (new PokerInfo Game State)
            try {
                callback.accept("Client thread " + clientNumber + ": (RESPONSE) " + pf.response);
                out.reset();
                out.writeObject(pf);
                out.flush();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } 

        // Functions below are the main thread logic for the client game:
        private void synchronizePokerInfoRequests(PokerInfo request) {
            pf.request = request.request;
            pf.playerOneAnteBet = request.playerOneAnteBet;
            pf.playerTwoAnteBet = request.playerTwoAnteBet;
            pf.playerOnePairPlusBet = request.playerOnePairPlusBet;
            pf.playerTwoPairPlusBet = request.playerTwoPairPlusBet;
        }

        public void handleInitialization() {
            callback.accept("Client thread " + clientNumber + ": Initializing poker info");
            pf = new PokerInfo();
            pf.playerOne = new Player();
            pf.playerTwo = new Player();
            pf.theDealer = new Dealer();
            pf.response = "Success";
        }

        public void readyButtonPlayer1OnAction() throws IOException {
            // Alternates from 1 to 0 when ready button is clicked
            pf.playerOne.readyState = 1 - pf.playerOne.readyState; 

            // Set the bet of the player
            pf.playerOne.setAnteBet(pf.playerOneAnteBet);
            pf.playerOne.setPairPlusBet(pf.playerOnePairPlusBet);
            
            pf.response = "NOT_ALL_PLAYERS_READY";
            checkBothPlayerReadyStatus();
        }

        public void readyButtonPlayer2OnAction() throws IOException {
            // Alternates from 1 to 0 when ready button is clicked
            pf.playerTwo.readyState = 1 - pf.playerTwo.readyState; 

            // Set the bet of the player
            pf.playerTwo.setAnteBet(pf.playerTwoAnteBet);
            pf.playerTwo.setPairPlusBet(pf.playerTwoPairPlusBet);
        
            pf.response = "NOT_ALL_PLAYERS_READY";
            checkBothPlayerReadyStatus();
        }

        public void playButtonPlayer1OnAction() throws IOException {
            // Invalid, we are not expecting their decision:
            if (pf.playerOne.decisionState != 0) {
                pf.response = "NOT_EXPECTING";
                return;
            }
            
            pf.playerOne.decisionState = 1;
            checkBothPlayerDecisionStatus();
        }
    
        public void playButtonPlayer2OnAction() throws IOException {
            // Invalid, we are not expecting their decision:
            if (pf.playerTwo.decisionState != 0) {
                pf.response = "NOT_EXPECTING";
                return;
            }
            
            pf.playerTwo.decisionState = 1;
            checkBothPlayerDecisionStatus();
        }
    
        public void foldButtonPlayer1OnAction() throws IOException {
            // Invalid, we are not expecting their decision:
            if (pf.playerOne.decisionState != 0) {
                pf.response = "NOT_EXPECTING";
                return;
            }
    
            pf.playerOne.decisionState = 2;
            checkBothPlayerDecisionStatus();
        }
    
        public void foldButtonPlayer2OnAction() throws IOException {
            // Invalid, we are not expecting their decision:
            if (pf.playerTwo.decisionState != 0) {
                pf.response = "NOT_EXPECTING";
                return;
            }
    
            pf.playerTwo.decisionState = 2;
            checkBothPlayerDecisionStatus();
        }

        private void evaluateGame() {
            // If both players folded, no winnings will be added already:
            // Check if anyone folded:
            if (pf.playerOne.decisionState == 2) {
                callback.accept("Client thread " + clientNumber + ": " + "Fold - p1 lost ante bet.");
                callback.accept("Client thread " + clientNumber + ": " + "Fold - p1 lost pair plus bet!");
            }

            if (pf.playerTwo.decisionState == 2) {
                callback.accept("Client thread " + clientNumber + ": " + "Fold - p2 lost ante bet.");
                callback.accept("Client thread " + clientNumber + ": " + "Fold - p2 lost pair plus bet!");
            }

            /*  If the dealer does not have at least 
                a Queen high or better, the play wager is returned to the players who did not fold and
                the ante bet is pushed to the next hand. */
            if (ThreeCardLogic.isDealerQualified(pf.theDealer.dealersHand) == 0) {
                pf.response = "DEALER_DID_NOT_QUALIFY";

                if (pf.playerOne.decisionState == 1) {
                    pf.playerOne.totalWinnings += (pf.playerOne.playBet + pf.playerOne.anteBet);
                }
                if (pf.playerTwo.decisionState == 1) {
                    pf.playerTwo.totalWinnings += (pf.playerTwo.playBet + pf.playerTwo.anteBet);
                }
                addPairPlusWinnings();
                pf.dealerWasQualifiedPreviously = false;

                return; 
            } 

            /*  0 if neither hand won
                1 if the dealer hand won
                2 if the player hand won */
            int playerOneDealerWinner = ThreeCardLogic.compareHands(pf.theDealer.dealersHand, pf.playerOne.hand);
            if (pf.playerOne.decisionState == 1) { 
                if (playerOneDealerWinner == 0) { // Tie breaker, everything is given back
                    pf.playerOne.anteWinnings = 0;
                    pf.dealerVsPlayerOne = 0;
                    callback.accept("Client thread " + clientNumber + ": " + "Player one ties with the dealer. + $0");
                } else if (playerOneDealerWinner == 1) {
                    pf.playerOne.anteWinnings -= (pf.playerOne.anteBet + pf.playerOne.playBet);
                    pf.dealerVsPlayerOne = 2;
                    callback.accept("Client thread " + clientNumber + ": " + "Player one loses to dealer. - $" + Math.abs(pf.playerOne.anteWinnings));
                } else if (playerOneDealerWinner == 2) {
                    pf.playerOne.anteWinnings += (pf.playerOne.anteBet + pf.playerOne.playBet);
                    pf.playerOne.totalWinnings += pf.playerOne.anteWinnings * 2;
                    pf.dealerVsPlayerOne = 1;
                    callback.accept("Client thread " + clientNumber + ": " + "Player one beats dealer. + $" + pf.playerOne.anteWinnings);
                }
            }

            int playerTwoDealerWinner = ThreeCardLogic.compareHands(pf.theDealer.dealersHand, pf.playerTwo.hand);
            if (pf.playerTwo.decisionState == 1) { 
                if (playerTwoDealerWinner == 0) { // Tie breaker, everything is given back
                    pf.playerTwo.anteWinnings = 0;
                    pf.dealerVsPlayerTwo = 0;
                    callback.accept("Client thread " + clientNumber + ": " + "Player two ties with the dealer. + $0");
                } else if (playerTwoDealerWinner == 1) {
                    pf.playerTwo.anteWinnings -= (pf.playerTwo.anteBet + pf.playerTwo.playBet);
                    pf.dealerVsPlayerTwo = 2;
                    callback.accept("Client thread " + clientNumber + ": " + "Player two loses to dealer. - $" + Math.abs(pf.playerTwo.anteWinnings));
                } else if (playerTwoDealerWinner == 2) {
                    pf.playerTwo.anteWinnings += (pf.playerTwo.anteBet + pf.playerTwo.playBet);
                    pf.playerTwo.totalWinnings += pf.playerTwo.anteWinnings * 2;
                    pf.dealerVsPlayerTwo = 1;
                    callback.accept("Client thread " + clientNumber + ": " + "Player two beats dealer. + $" + pf.playerTwo.anteWinnings);
                }
            }
            addPairPlusWinnings();
            pf.dealerWasQualifiedPreviously = true;
            pf.response = "SUCCESSFULLY_UPDATED_WINNINGS";
        }

        public void setupNewRound() {
            // Set data members to default value:
            pf.playerOne.readyState = 0;
            pf.playerTwo.readyState = 0;
            pf.playerOne.decisionState = 1;
            pf.playerTwo.decisionState = 1;
            pf.response = "SUCCESSFULLY_SETUP_NEW_ROUND";
        }

        public void resetGameOnAction() {
            pf.playerOne.totalWinnings = 0;
            pf.playerTwo.totalWinnings = 0;
            pf.dealerWasQualifiedPreviously = true;
            setupNewRound();
            pf.response = "SUCCESSFULLY_RESET_GAME";
        }

        private String formatCard(Card card) {
            String[] valueNames = {"", "", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"};
            String valueName = valueNames[card.value];

            String suitName = "";
            switch(card.suit) {
                case 'C': suitName = "Clubs"; break;
                case 'D': suitName = "Diamonds"; break;
                case 'S': suitName = "Spades"; break;
                case 'H': suitName = "Hearts"; break;
            }
            
            return valueName + " of " + suitName;
        }

        private void checkBothPlayerReadyStatus() {
            if (pf.playerOne.readyState == 1 && pf.playerTwo.readyState == 1) { 
                
                // Subtract their bets to their networth
                pf.playerOne.totalWinnings = pf.playerOne.totalWinnings - pf.playerOne.anteBet - pf.playerOne.pairPlusBet;
                pf.playerTwo.totalWinnings = pf.playerTwo.totalWinnings - pf.playerTwo.anteBet - pf.playerTwo.pairPlusBet; 
                
                // Deal out the cards:
                pf.theDealer.dealersHand = pf.theDealer.dealHand();
                pf.playerOne.hand = pf.theDealer.dealHand();
                pf.playerTwo.hand = pf.theDealer.dealHand();
                
                // Now, we need to hear from the client (fold or play?)
                pf.playerOne.decisionState = 0;
                pf.playerTwo.decisionState = 0;
                
                // Detailed hand information callback
                callback.accept("🃏 Game Begins: Hands Dealt 🃏");
                callback.accept("----------------------------------------");
                
                // Dealer's Hand
                callback.accept("🃏 Dealer's Hand:");
                for (Card card : pf.theDealer.dealersHand) {
                    callback.accept("   " + formatCard(card));
                }
                callback.accept("----------------------------------------");
                
                // Player One's Hand
                callback.accept("🃏 Player One's Hand:");
                for (Card card : pf.playerOne.hand) {
                    callback.accept("   " + formatCard(card));
                }
                callback.accept("   Ante Bet: $" + pf.playerOne.anteBet);
                callback.accept("   Pair Plus Bet: $" + pf.playerOne.pairPlusBet);
                callback.accept("----------------------------------------");
                
                // Player Two's Hand
                callback.accept("🃏 Player Two's Hand:");
                for (Card card : pf.playerTwo.hand) {
                    callback.accept("   " + formatCard(card));
                }
                callback.accept("   Ante Bet: $" + pf.playerTwo.anteBet);
                callback.accept("   Pair Plus Bet: $" + pf.playerTwo.pairPlusBet);
                callback.accept("----------------------------------------");
                
                callback.accept("🎲 Waiting for player decisions...");

                pf.response = "MAKE_DECISION";
            }
        }

        private void checkBothPlayerDecisionStatus() {
            // If both are done with their decisions:
            if (pf.playerOne.decisionState != 0 && pf.playerTwo.decisionState != 0) {
                pf.response = "REVEAL_DEALER_CARDS";
                pf.playerOne.pairPlusWinnings = 0;
                pf.playerOne.anteWinnings = 0;
                pf.playerTwo.pairPlusWinnings = 0;
                pf.playerTwo.anteWinnings = 0;

                // This block of code represents the sequence of events
                // that happen before the dealer's card has been revealed
                if (pf.playerOne.decisionState == 1) { // If player one decides to play, match their ante with their play bet
                    pf.playerOne.playBet = pf.playerOne.anteBet;
                    pf.playerOne.totalWinnings -= pf.playerOne.playBet;
        
                    int pairPlusWinnings = ThreeCardLogic.evalPPWinnings(pf.playerOne.hand, pf.playerOne.pairPlusBet);
                    if (pairPlusWinnings != 0) {
                        pf.playerOne.pairPlusWinnings += pairPlusWinnings;
                        callback.accept("Client thread " + clientNumber + ": " + "Player one wins pair plus! + $" + pf.playerOne.pairPlusWinnings);
                        
                    } else {
                        pf.playerOne.pairPlusWinnings -= pf.playerOne.pairPlusBet;
                        callback.accept("Client thread " + clientNumber + ": " + "Player one loses pair plus! - $" + Math.abs(pf.playerOne.pairPlusWinnings));
                    }
                }
                if (pf.playerTwo.decisionState == 1) { // If player two decides to play, match their ante with their play bet
                    pf.playerTwo.playBet = pf.playerTwo.anteBet;
                    pf.playerTwo.totalWinnings -= pf.playerTwo.playBet;
        
                    int pairPlusWinnings = ThreeCardLogic.evalPPWinnings(pf.playerTwo.hand, pf.playerTwo.pairPlusBet);
                    if (pairPlusWinnings != 0) {
                        pf.playerTwo.pairPlusWinnings += pairPlusWinnings;
                        callback.accept("Client thread " + clientNumber + ": " + "Player two wins pair plus! + $" + pf.playerTwo.pairPlusWinnings);
                    } else {
                        pf.playerTwo.pairPlusWinnings -= pf.playerTwo.pairPlusBet;
                        callback.accept("Client thread " + clientNumber + ": " + "Player two loses pair plus! - $" + Math.abs(pf.playerTwo.pairPlusWinnings));
                    }
                }
            }  else {
                pf.response = "NOT_ALL_PLAYERS_READY";
            }
        }

        private void addPairPlusWinnings() {
            // Add the winnings from the pair plus bets:
            if (pf.playerOne.pairPlusWinnings > 0) {
                pf.playerOne.totalWinnings += (pf.playerOne.pairPlusBet + pf.playerOne.pairPlusWinnings);
            } 
            if (pf.playerTwo.pairPlusWinnings > 0) {
                pf.playerTwo.totalWinnings += (pf.playerTwo.pairPlusBet + pf.playerTwo.pairPlusWinnings);
            }
        }
    }
}
