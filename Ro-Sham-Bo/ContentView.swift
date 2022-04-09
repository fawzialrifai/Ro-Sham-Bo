//
//  ContentView.swift
//  Ro-Sham-Bo
//
//  Created by Fawzi Rifai on 09/04/2022.
//

import SwiftUI

struct ContentView: View {
    var choices = ["🪨", "📄", "✂️"]
    var winningChoices = ["📄", "✂️", "🪨"]
    var losingChoices = ["✂️", "🪨", "📄"]
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var questionNumber = 1
    @State private var score = 0
    @State private var isGameOver = false
    var body: some View {
        ZStack {
            LinearGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.5), .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.5)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                VStack {
                    HStack {
                        Text("Score: \(score)")
                        Spacer()
                        Text("\(questionNumber)/10")
                    }
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    Spacer()
                    HStack(spacing: 16) {
                        ForEach(choices, id: \.self) {
                            Text($0)
                                .font(.system(size: 70))
                                .padding()
                                .background(choices[appChoice] == $0 ? .blue : .secondary)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    Spacer()
                }
                Spacer()
                VStack {
                    Spacer()
                    Text(shouldWin ? "Play to win!" : "Play to lose!")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    Spacer()
                    HStack(spacing: 16) {
                        ForEach(choices, id: \.self) { choice in
                            Button(choice) {
                                choiceSelected(choice)
                            }
                            .font(.system(size: 70))
                            .padding()
                            .background(.secondary)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .alert("Game Over!", isPresented: $isGameOver) {
                                Button("Restart") {
                                    restartGame()
                                }
                            } message: {
                                Text("Your score is \(score).")
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    func choiceSelected(_ choice: String) {
        if shouldWin {
            if winningChoices[appChoice] == choice {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if losingChoices[appChoice] == choice {
                score += 1
            } else {
                score -= 1
            }
        }
        if questionNumber < 10 {
            askNewQuestion()
        } else {
            isGameOver = true
        }
    }
    func askNewQuestion() {
        let currentChoice = appChoice
        while appChoice == currentChoice {
            appChoice = Int.random(in: 0...2)
        }
        shouldWin = Bool.random()
        questionNumber += 1
    }
    func restartGame() {
        score = 0
        questionNumber = 0
        askNewQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
