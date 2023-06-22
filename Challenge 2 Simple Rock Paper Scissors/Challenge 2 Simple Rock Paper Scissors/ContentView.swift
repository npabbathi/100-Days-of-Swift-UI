//
//  ContentView.swift
//  Challenge 2 Simple Rock Paper Scissors
//
//  Created by Nidhi Pabbathi on 6/22/23.
//

import SwiftUI

struct ContentView: View {
    //answer and choices
    private let choices = ["rock", "paper", "scissors"]
    @State private var compChoice = Int.random(in: 0 ..< 3)
    @State private var playerChoice = 0
    @State private var shouldWin = Bool.random()
    
    //message displayed
    @State private var showAlert = false
    @State private var message = ""
    
    //score and round
    @State private var score = 0
    @State private var round = 1
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("rockpaperscissors")
                    .font(.caption)
                    .formatText()
                HStack {
                    Text("SCORE: \(score)")
                        .font(.subheadline.bold())
                        .formatText()
                        .padding()
                    Spacer()
                    Text("ROUND: \(round)")
                        .font(.subheadline.bold())
                        .formatText()
                        .padding()
                }
                VStack {
                    //Text and question
                    Text("Computer selects: **\(choices[compChoice].uppercased())**")
                        .font(.title2)
                        .formatText()
                    Text("Tap the option to **\(shouldWin ? "WIN" : "LOSE")**")
                        .font(.title3)
                        .formatText()
                    
                    //answer choices
                    Button {
                        playerChoice = 0
                        updateGame()
                    } label: {
                        AnswerChoiceLabel(emoji: "🪨", caption: "ROCK")
                    }
                    Button {
                        playerChoice = 1
                        updateGame()
                    } label: {
                        AnswerChoiceLabel(emoji: "📄", caption: "PAPER")
                    }
                    Button {
                        playerChoice = 2
                        updateGame()
                    } label: {
                        AnswerChoiceLabel(emoji: "✂️", caption: "SCISSORS")
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(radius: 5)
                
                Spacer()
            }
            .alert(message, isPresented: $showAlert) {
                Button("Continue") {
                    compChoice = Int.random(in: 0 ..< 3)
                    shouldWin.toggle()
                    round += 1
                }
            }
            
        }
    }
    
    //function to update the game for the correct message for the alert, update score, and then show alert
    func updateGame() {
        if (compChoice + (shouldWin ? 1 : 2)) % 3 == playerChoice {
            message = "Correct!"
            score += 1
        } else {
            message = "Incorrect"
        }
        
        if round == 10 {
            message = "Game over! Final Score: \(score)"
            score = 0
            round = 1
        }
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AnswerChoiceLabel: View {
    let emoji : String
    let caption : String
    
    var body: some View {
        VStack {
            Text(emoji)
                .font(.largeTitle)
            Text(caption)
                .font(.title3)
                .kerning(2)
        }
        .padding()
        .frame(minWidth: 200)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct WhitenText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .shadow(radius: 2)
            .kerning(2)
    }
}

extension View {
    func formatText() -> some View {
        modifier(WhitenText())
    }
}
