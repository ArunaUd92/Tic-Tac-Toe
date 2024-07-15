//
//  ContentView.swift
//  Tic-Tac-Toe
//
//  Created by Aruna Udayanga on 13/07/2024.
//

import SwiftUI
import MultipeerConnectivity

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()
    @StateObject private var coordinator = Coordinator()
    
    @State private var peerID: MCPeerID!
    @State private var mcSession: MCSession!
    @State private var mcAdvertiserAssistant: MCAdvertiserAssistant?
    @State private var isHost = false
    
    var body: some View {
        VStack {
            Text("Tic Tac Toe")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text(viewModel.isPlayerOneTurn ? "Player X's Turn" : "Player O's Turn")
                .font(.title2)
                .foregroundColor(.gray)
                .padding(.bottom)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15) {
                ForEach(0..<9) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(viewModel.board[index] == "" ? Color.blue.opacity(0.7) : (viewModel.board[index] == "X" ? Color.red : Color.green))
                            .frame(width: 100, height: 100)
                            .shadow(radius: 5)
                        
                        Text(viewModel.board[index])
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .transition(.scale)
                            .animation(.easeIn)
                    }
                    .onTapGesture {
                        playerTap(index: index)
                    }
                }
            }
            .padding()
            
            if viewModel.gameOver {
                Text(viewModel.message)
                    .font(.title)
                    .foregroundColor(viewModel.message.contains("Wins") ? .green : .red)
                    .padding()
                    .transition(.opacity)
                    .animation(.easeIn)
                
                Button(action: {
                    withAnimation {
                        viewModel.resetGame()
                    }
                }) {
                    Text("Play Again")
                        .gameButtonStyle()
                }
                .padding()
            }
            
            HStack {
                Button("Host Game") {
                    startHosting()
                }
                .gameButtonStyle()
                
                Button("Join Game") {
                    joinGame()
                }
                .gameButtonStyle()
            }
            .padding()
        }
        .padding()
        .gradientBackground()
        .onAppear(perform: setupConnectivity)
        .environmentObject(coordinator)
    }

    func playerTap(index: Int) {
        if viewModel.board[index] == "" && !viewModel.gameOver {
            let symbol = viewModel.getCurrentSymbol()
            withAnimation {
                viewModel.board[index] = symbol
            }
            viewModel.togglePlayerTurn()
            sendMove(index: index)
            viewModel.checkForWinner()
        }
    }

    func setupConnectivity() {
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = coordinator
        coordinator.delegate = viewModel // Set delegate
    }

    func startHosting() {
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "tic-tac-toe", discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant?.start()
        isHost = true
    }

    func joinGame() {
        let mcBrowser = MCBrowserViewController(serviceType: "tic-tac-toe", session: mcSession)
        mcBrowser.delegate = coordinator
        UIApplication.shared.windows.first?.rootViewController?.present(mcBrowser, animated: true)
    }

    func sendMove(index: Int) {
        if mcSession.connectedPeers.count > 0 {
            if let data = "\(index)".data(using: .utf8) {
                do {
                    try mcSession.send(data, toPeers: mcSession.connectedPeers, with: .reliable)
                } catch {
                    print("Error sending move: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
