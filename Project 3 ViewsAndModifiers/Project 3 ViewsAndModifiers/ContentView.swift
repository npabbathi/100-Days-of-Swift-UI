//
//  ContentView.swift
//  Project 3 ViewsAndModifiers
//
//  Created by Nidhi Pabbathi on 6/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var showWatermark = false
    var body: some View {
        ZStack {
            Color(.systemMint)
                .ignoresSafeArea()
            VStack(spacing: 50) {
                Spacer()
                Image("turtle")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    .rainbowWatermark(with: "Nidhi Pabbathi 2021")
                
                LinearGradient(colors: [.blue, .gray], startPoint: .top, endPoint: .bottom)
                    .frame(width: 300, height: 300)
                    .cornerRadius(10)
                    .shadow(radius: 20)
                    .rainbowWatermark(with: "100 days of Hacking with Swift UI", isShown: showWatermark)
                
                
                
                HStack {
                    Button("With watermark") {
                        showWatermark = true
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Without watermark") {
                        showWatermark = false
                    }
                    .buttonStyle(.bordered)
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// custom views
struct RainbowBackgroundText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .padding(5)
            .background(LinearGradient(colors: [.red, .orange, .yellow, .green, .blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
            .shadow(radius: 2)
            .border(.black)
            .padding(5)
            .foregroundColor(.white)
            .font(.caption.bold())
    }
}

//custom view modifiers
struct RainbowWatermark: ViewModifier {
    let text: String
    let isShown: Bool
    
    func body(content: Content) -> some View {
        ZStack (alignment: .bottomTrailing) {
            content
            
            if (isShown) {
                RainbowBackgroundText(text: text)
            }
        }
    }
}

extension View {
    func rainbowWatermark(with text: String) -> some View {
        modifier(RainbowWatermark(text: text, isShown: true))
    }
    
    func rainbowWatermark(with text: String, isShown: Bool) -> some View {
        modifier(RainbowWatermark(text: text, isShown: isShown))
    }
}
