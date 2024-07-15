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

    func updateBoard(at index: Int, with symbol: String) {
        board[index] = symbol
    }

    func togglePlayerTurn() {
        isPlayerOneTurn.toggle()
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
}
