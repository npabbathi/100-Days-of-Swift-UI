//
//  ContentView.swift
//  Project 2 GuessTheFlag
//
//  Created by Nidhi Pabbathi on 6/4/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var roundNumber = 1
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.mint, .secondary]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("round \(roundNumber)")
                        .font(.title2.bold())
                        .kerning(4)
                        .multilineTextAlignment(.leading)
                        .shadow(color: .secondary, radius: 3)
                Spacer()
                }
                Spacer()
                Text("GUESS THE FLAG")
                    .foregroundColor(.primary)
                    .font(.largeTitle.weight(.bold))
                    .kerning(5)
                    .shadow(color: .secondary, radius: 3)
                VStack(spacing: 40){
                    VStack {
                        Text("TAP THE FLAG OF")
                            .font(.subheadline.weight(.heavy))
                            .kerning(2)
                            .padding(5)
                            .foregroundColor(.secondary)
                        Text(countries[correctAnswer].uppercased())
                            .font(.largeTitle.weight(.semibold))
                            .foregroundColor(.primary)
                            .kerning(10)
                            .padding(10)
                            .frame(minWidth: 200)
                            .background(LinearGradient(gradient: Gradient(colors: [.secondary, .mint]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    ForEach(0 ..< 3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .shadow(radius: 20)
                        }
                        .cornerRadius(10)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                Spacer()
                Spacer()
                Text("SCORE: \(score)")
                    .font(.largeTitle.weight(.bold))
                    .kerning(5)
                    .shadow(color: .secondary, radius: 3)
                Spacer()
            }
            .padding(20)
        }
        .alert(scoreTitle, isPresented: $showScore) {
            Button("Continue", action: roundNumber != 9 ? askQuestions : resetGame)
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "You are correct! +1"
            score += 1
        } else {
            scoreTitle = "Incorrect, that's \(countries[number])'s flag"
        }
        showScore = true
        roundNumber += 1
    }
    
    func askQuestions() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        score = 0
        askQuestions()
        roundNumber = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
