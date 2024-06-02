//
//  Qutoe.swift
//  QuotesApp
//
//  Created by Eren on 31.05.2024.
//

import Foundation
struct Quote: Identifiable {
    var id = UUID()
    
    let quoteText: String
    var liked: Bool = false
}

var testData = [
Quote(quoteText: "Do or not do. There is no try.", liked: true),
Quote(quoteText: "Every man dies, no every man really lives."),
Quote(quoteText: "Carpe diem, seize the day boys. Make your lives extraordinary."),
Quote(quoteText: "Carpe diem, seize the day boys. Make your lives extraordinary."),
Quote(quoteText: "Carpe diem, seize the day boys. Make your lives extraordinary."),
Quote(quoteText: "Carpe diem, seize the day boys. Make your lives extraordinary.")
]

