//
//  ImageDetailPage.swift
//  AbumereErikaFinal
//
//  Created by Student on 12/5/23.
//
//
//

import Foundation
import SwiftUI
/*
struct ImageDetailPage: View {
    
    
    //@EnvironmentObject var flashcardViewModel: FlashcardViewModel
    
  
    private var image: Image?

    @State private var description = ""
    @State private var isFavorite = false
    
    @State private var refresh = false
    
    init(image: Image? = nil, description: String) {
        if let image = image {
            self.image = image
            self.description = description
        }
    }
    
    func saveOrCreate(){
        if let flashcard = flashcard{
            for index in 0..<flashcardViewModel.flashcards.count{
                if flashcard == flashcardViewModel.flashcards[index] {
                    let newFlashcard = Flashcard(id: flashcard.id, question: question, answer: answer, isFavorite: isFavorite)
                    
                    flashcardViewModel.flashcards[index] = newFlashcard
                    
                }
            }
        } else {
            let newFlashcard = Flashcard(id: UUID(), question: question, answer: answer, isFavorite: isFavorite)
            flashcardViewModel.append(flashcard: newFlashcard)
        }
        
    }

    
    

    var body: some View {
        VStack(spacing: 24){
            TextField(
                "Question",
                text: $question
            )
            TextField(
                "Answer",
                text: $answer
            )
            Toggle(isOn: $isFavorite){
                Text("Is Favorite?")
            }
            Spacer()
        }
        .padding()
        .navigationTitle(flashcard == nil ? "New Card" : "Edit Card")
        .toolbar{
            Button("Save") {
                saveOrCreate()
                dismiss()
                
            }
            .disabled(question.isEmpty || answer.isEmpty)
        }
  
    }
     
}

struct ImageDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        EditFlashCardPage()
        
    }
}
     */
