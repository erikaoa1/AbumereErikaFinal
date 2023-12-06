//
//  HomePage.swift
//  AbumereErikaFinal
//
//  Created by Student on 12/4/23.
//

import Foundation
import SwiftUI

struct HomePage: View {
    @EnvironmentObject var transcriptionViewModel: TranscriptionViewModel
 
    
    @State private var fav = false
    var body: some View {
        
        ZStack{
            VStack {
                    Spacer()
                    Image("logo")
                        .resizable() // Allows the image to be resizable
                        .aspectRatio(contentMode: .fit) // Keeps the image's aspect ratio
                        .frame(width: 200, height: 200) // Sets a fixed size for the image
                 Spacer()
                
                
            }  //end of vstack
            .onAppear{
                //randomize first card
               // flashcardViewModel.randomize()
                //fav = isFavorite
                transcriptionViewModel.requestPermission()
                
            }
            
            .background(Color.white)
          
            
          
                    }
                }
            
            
        }
 
struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
