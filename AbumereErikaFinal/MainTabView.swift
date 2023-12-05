//
//  MainTabView.swift
//
//
//

import Foundation
import SwiftUI

struct MainTabView: View {
    //@StateObject var flashcardViewModel = FlashcardViewModel()
    
    var body: some View {
        TabView{
            HomePage()
            TranscribePage()
                .tabItem {
                    Label("Transcribe", systemImage: "camera")
                }
            Spacer()
            MemoriesPage()
                .tabItem {
                    Label("Memories", systemImage: "heart")
                }
            Spacer()
          
        }
        //.environmentObject(flashcardViewModel)
        
    }
}
