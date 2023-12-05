//
//  Transcription.swift
//  AbumereErikaFinal
//
//  Created by Student on 12/4/23.
//

import Foundation

struct Transcription : Hashable, Identifiable, Codable {
    let id: UUID
    let question: String
    let answer: String
    let isFavorite: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Transcription, rhs: Transcription) -> Bool {
        return lhs.id == rhs.id
    }
}
