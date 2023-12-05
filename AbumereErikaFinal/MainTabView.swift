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
            TranscribePage()
                .tabItem {
                    Label("Transcribe", systemImage: "questionmark")
                }
            //FlashcardListPage()
                .tabItem {
                    Label("Cards", systemImage: "square.stack.3d.up.fill")
                }
            //FavoritesFlashcardListPage()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
        //.environmentObject(flashcardViewModel)
        
    }
}
