//
//  ContentView.swift
//  Project 5 WordScramble
//
//  Created by Nidhi Pabbathi on 3/20/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Text("words: \(usedWords.count)")
                
                Section("words so far") {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle("your word is: \(rootWord)")
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) { } message: {
                Text(errorMessage)
            }
            .toolbar(content: {
//                Button("new word", action: startGame)
                Button(action: startGame, label: {
                    Image(systemName: "arrow.clockwise")
                })
            })
        }
        
    }
    
    /// validates and adds new word into usedWords
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        guard validWordLength(word: answer) else {
            wordError(title: "invalid original word length", message: "choose an original word with at least 3 characters. try again")
            return
        }
        guard isOriginal(word: answer) else {
            wordError(title: "word already used", message: "you have already used \(answer). try again")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "word cannot be formed", message: "\(rootWord) does not contain the letters in \(answer). try again")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "word does not exist", message: "\(answer) is not a real word. try again")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    ///sets up the game before the list loads
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords = [String]()
                return
            }
        }
        
        fatalError("could not load start.txt from bundle.")
    }
    
    func validWordLength(word: String) -> Bool {
        return word != rootWord && word.count > 2
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var wordCopy = rootWord
        
        for letter in word {
            if let pos = wordCopy.firstIndex(of: letter) {
                wordCopy.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
