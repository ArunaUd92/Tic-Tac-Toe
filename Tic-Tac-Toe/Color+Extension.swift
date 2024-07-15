//
//  Color+Extension.swift
//  Tic-Tac-Toe
//
//  Created by Aruna Udayanga on 15/07/2024.
//

import Foundation
import SwiftUI

struct GameButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

extension View {
    func gameButtonStyle() -> some View {
        self.modifier(GameButtonStyle())
    }
}

struct GradientBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .edgesIgnoringSafeArea(.all))
    }
}

extension View {
    func gradientBackground() -> some View {
        self.modifier(GradientBackground())
    }
}
