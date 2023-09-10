//
//  TriviaView.swift
//  TriviaGame
//
//
//

import SwiftUI

struct TriviaView: View {
    @EnvironmentObject var triviaManager: TriviaManager
    @EnvironmentObject var globalData: gv
    var body: some View {
        if triviaManager.reachedEnd {
            
            VStack(spacing: 20) {
                Text("Trivia Game")
                    .padding()
                    .font(.system(size: 40, weight: .semibold))
                Text("Congratulations, you completed the game! 🥳")
                    .font(.system(size: 30, weight: .semibold))
                Text("You scored \(triviaManager.score) points!")
                    .font(.system(size: 30, weight: .semibold))
                Button {
                    Task.init {
                        await triviaManager.fetchTrivia()
                    }
                    globalData.points += triviaManager.score
                } label: {
                    PrimaryButton(text: "Play again")
                }
            }
            .foregroundColor(.green)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.984313725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
        } else {
            QuestionView()
                .environmentObject(triviaManager)
        }
    }
}

struct TriviaView_Previews: PreviewProvider {
    static var previews: some View {
        TriviaView()
            .environmentObject(TriviaManager())
    }
}
