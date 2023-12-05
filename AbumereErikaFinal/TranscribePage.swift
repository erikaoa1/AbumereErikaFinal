//
//  TranscribePage.swift
//  AbumereErikaFinal
//
//  Created by Student on 12/4/23.
//
//

import Foundation
import SwiftUI

struct TranscribePage: View {
    let OFFSET_X = 500.0
    let OFFSET_Y = 900.0
    
    @State var isShowingQuestion = true
    
    @State var offsetX = 0.0
    @State var offsetY = 0.0
    @State var isHidden = false
    
    //var title: String {
        /*
        if let currentFlashcard = flashcardViewModel.currentFlashcard {
            let question = currentFlashcard.question
            let answer = currentFlashcard.answer
            
            if isShowingQuestion {
                return question
            } else {
                return answer
            }
        } else {
            // handling the case where currentFlashcard is nil
            return ""
        }
*/
  //  }
    
    func showRandomFlashCard() {
        withAnimation(.linear(duration: 1.0)){
            offsetY = -1 * OFFSET_Y
            isHidden = true
        }
        withAnimation(.linear.delay(1.0)){
            offsetY = OFFSET_Y
            isShowingQuestion = true
           // flashcardViewModel.randomize()
        }
        withAnimation(.easeInOut(duration:0.5).delay(1.4)){
            offsetY = 0.0
            isHidden = false
        }
        //fav = isFavorite
    }
    
    func toggleQuestionAnswer() {
        withAnimation(.linear(duration: 0.5)){
            isShowingQuestion = !isShowingQuestion
        }
    }
    
    func showNextCard(){
        withAnimation(.linear(duration: 1.0)){
            offsetX = -1 * OFFSET_X
            isHidden = true
        }
        withAnimation(.linear.delay(1.0)){
            offsetX = OFFSET_X
            isShowingQuestion = true
            //flashcardViewModel.next()
        }
        withAnimation(.easeInOut(duration:0.5).delay(1.4)){
            offsetX = 0.0
            isHidden = false
        }
       // fav = isFavorite
    }
    
    
    func showPreviousCard(){
        withAnimation(.linear(duration: 1.0)){
            offsetX = OFFSET_X
            isHidden = true
        }
        withAnimation(.linear.delay(1.0)){
            offsetX = -OFFSET_X
            isShowingQuestion = true
            //flashcardViewModel.previous()
        }
        withAnimation(.easeInOut(duration:0.5).delay(1.4)){
            offsetX = 0.0
            isHidden = false
        }
       // fav = isFavorite
    }
    
    
    
    
    
    
    
   // var isFavorite : Bool{
       // return flashcardViewModel.currentFlashcard?.isFavorite == true
   // }
    
    @State private var fav = false

    func favQ(){
      //  flashcardViewModel.toggleFavorite()
       // fav = isFavorite
    }
    
    var body: some View {
        
        ZStack{
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        favQ()
                    }) {
                        Image(systemName:"star.fill")
                            .font(.system(size: 30))
                            .padding()
                    }
                    .tint(fav ? .yellow : .gray)
                }
                .padding()
                
                Spacer()
                
                Text("title")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(isShowingQuestion ? Color.black : Color.red)
                Spacer()
                Spacer()
            }  //end of vstack
            .onAppear{
                //randomize first card
               // flashcardViewModel.randomize()
                //fav = isFavorite
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green)
            .onTapGesture(count: 2){
                toggleQuestionAnswer()
            }
            .onTapGesture{
                showRandomFlashCard()
            }
            .opacity(isHidden ? 0 : 1)
            .offset(x: offsetX, y: offsetY)
            .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                .onEnded { value in
                    print(value.translation)
                    switch(value.translation.width, value.translation.height) {
                    case (...0, -30...30):
                        showNextCard() // show next card here
                    case (0..., -30...30):
                        showPreviousCard() // show previous card here
                    default:
                        print("no clue")
                    }
                }
            )
            
        }
    }
}

struct FlashcardPage_Previews: PreviewProvider {
    static var previews: some View {
        TranscribePage()
    }
}
