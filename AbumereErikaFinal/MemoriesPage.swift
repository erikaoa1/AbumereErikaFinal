//
//  MemoriesPage.swift
//  AbumereErikaFinal
//
//  Created by Student on 12/4/23.
//

import Foundation
import SwiftUI
struct MemoriesPage: View {
   // @EnvironmentObject var flashcardViewModel: FlashcardViewModel
    
    var body: some View {
        NavigationStack {
            List {
                //ForEach(flashcardViewModel.flashcards.filter { $0.isFavorite }) { flashcard in
                    //NavigationLink(destination: //EditFlashCardPage(flashcard: flashcard)) {
                        //FlashcardCell(flashcard: flashcard)
                    //}
                //}
            }
            .navigationTitle("Memories")
        }
    }
}

struct MemoriesPage_Previews: PreviewProvider {
    static var previews: some View {
        MemoriesPage()
    }
}
