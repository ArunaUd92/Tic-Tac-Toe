//
//  extension.swift
//  Tic-Tac-Toe
//
//  Created by Aruna Udayanga on 13/07/2024.
//

import Foundation
import MultipeerConnectivity
import SwiftUI

protocol CoordinatorDelegate: AnyObject {
    func updateBoard(at index: Int, with symbol: String)
    func togglePlayerTurn()
    func checkForWinner()
    func getCurrentSymbol() -> String
}

import Foundation
import MultipeerConnectivity

class Coordinator: NSObject, ObservableObject, MCSessionDelegate, MCBrowserViewControllerDelegate {
    weak var delegate: CoordinatorDelegate?

    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let indexString = String(data: data, encoding: .utf8), let index = Int(indexString) {
            DispatchQueue.main.async {
                if let delegate = self.delegate {
                    let symbol = delegate.getCurrentSymbol()
                    delegate.updateBoard(at: index, with: symbol)
                    delegate.togglePlayerTurn()
                    delegate.checkForWinner()
                }
            }
        }
    }

    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}

    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}

    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}

    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true)
    }

    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true)
    }
}
