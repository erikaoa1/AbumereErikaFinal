//
//  Transcription.swift
//  AbumereErikaFinal
//
//  Created by Student on 12/4/23.
//

import Foundation
import UIKit
import SwiftUI


struct Transcription : Hashable, Identifiable {
    let id: UUID
    let image: UIImage
    let description: String
    let location: String
    let timestamp: String
    let isMemory: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Transcription, rhs: Transcription) -> Bool {
        return lhs.id == rhs.id
    }
}


