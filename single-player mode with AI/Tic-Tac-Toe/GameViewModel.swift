//
//  GameViewModel.swift
//  Tic-Tac-Toe
//
//  Created by Aruna Udayanga on 13/07/2024.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject, CoordinatorDelegate {
    @Published var board = Array(repeating: "", count: 9)
    @Published var isPlayerOneTurn = true
    @Published var gameOver = false
    @Published var message = ""
    @Published var isSinglePlayer = false // Flag for single-player mode
    
    func updateBoard(at index: Int, with symbol: String) {
        board[index] = symbol
    }

    func togglePlayerTurn() {
        isPlayerOneTurn.toggle()
        if isSinglePlayer && !isPlayerOneTurn && !gameOver {
            // Delay the AI move
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.aiMove()
            }
        }
    }

    func checkForWinner() {
        let winningCombinations = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8],
            [0, 3, 6], [1, 4, 7], [2, 5, 8],
            [0, 4, 8], [2, 4, 6]
        ]

        for combination in winningCombinations {
            if board[combination[0]] != "" &&
               board[combination[0]] == board[combination[1]] &&
               board[combination[1]] == board[combination[2]] {
                gameOver = true
                message = "\(board[combination[0]]) Wins!"
                return
            }
        }

        if !board.contains("") {
            gameOver = true
            message = "It's a Tie!"
        }
    }

    func resetGame() {
        board = Array(repeating: "", count: 9)
        isPlayerOneTurn = true
        gameOver = false
        message = ""
    }

    func getCurrentSymbol() -> String {
        return isPlayerOneTurn ? "X" : "O"
    }

    func aiMove() {
        let bestMove = findBestMove()
        if bestMove != -1 {
            board[bestMove] = "O"
            togglePlayerTurn()
            checkForWinner()
        }
    }
    
    func findBestMove() -> Int {
        var bestScore = Int.min
        var move = -1
        
        for i in 0..<board.count {
            if board[i] == "" {
                board[i] = "O"
                let score = minimax(isMaximizing: false)
                board[i] = ""
                if score > bestScore {
                    bestScore = score
                    move = i
                }
            }
        }
        
        return move
    }
    
    func minimax(isMaximizing: Bool) -> Int {
        if let winner = getWinner() {
            return winner == "O" ? 1 : winner == "X" ? -1 : 0
        }
        
        if isMaximizing {
            var bestScore = Int.min
            for i in 0..<board.count {
                if board[i] == "" {
                    board[i] = "O"
                    let score = minimax(isMaximizing: false)
                    board[i] = ""
                    bestScore = max(score, bestScore)
                }
            }
            return bestScore
        } else {
            var bestScore = Int.max
            for i in 0..<board.count {
                if board[i] == "" {
                    board[i] = "X"
                    let score = minimax(isMaximizing: true)
                    board[i] = ""
                    bestScore = min(score, bestScore)
                }
            }
            return bestScore
        }
    }
    
    func getWinner() -> String? {
        let winningCombinations = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8],
            [0, 3, 6], [1, 4, 7], [2, 5, 8],
            [0, 4, 8], [2, 4, 6]
        ]

        for combination in winningCombinations {
            if board[combination[0]] != "" &&
               board[combination[0]] == board[combination[1]] &&
               board[combination[1]] == board[combination[2]] {
                return board[combination[0]]
            }
        }
        
        return board.contains("") ? nil : "Tie"
    }
}
