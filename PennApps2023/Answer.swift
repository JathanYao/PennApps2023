//
//  Answer.swift
//  PennApps2023
//
//  Created by Jathan-Yao on 2023-09-09.
//

import Foundation

struct Answer: Identifiable {
    var id = UUID() // Setting the UUID ourselves inside of the model, because API doesn't return a unique ID for each answer
    var text: AttributedString
    var isCorrect: Bool
}
