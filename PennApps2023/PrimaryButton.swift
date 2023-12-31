//
//  PrimaryButton.swift
//  TriviaGame
//
//  Created by Stephanie Diep on 2021-12-17.
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    var background: Color = .green
    
    var body: some View {
        Text(text)
            .foregroundColor(.black)
            .padding()
            .padding(.horizontal)
            .background(background)
            .cornerRadius(30)
            .shadow(radius: 10)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(text: "Next")
            .foregroundColor(.black)
    }
}
