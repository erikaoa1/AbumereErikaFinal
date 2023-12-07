//
//  MemoriesPage.swift
//  AbumereErikaFinal
//
//  Created by Student on 12/4/23.
//

import Foundation
import SwiftUI
struct MemoriesPage: View {
    @EnvironmentObject var transcriptionViewModel: TranscriptionViewModel
    
    //make grid 2 per row
    private let items: [GridItem] = Array(repeating: .init(.flexible(minimum: 120)), count: 2)
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: items, spacing: 10) {
                    ForEach(transcriptionViewModel.memories.filter { $0.isMemory }) { photo in
                        NavigationLink(destination: ImageDetailPage(transcription: photo)) {
                            Image(uiImage: photo.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 160)
                                .clipped()
                        }
                    }
                }
            }
        }
        .navigationTitle("Memories")
    }
    
    struct MemoriesPage_Previews: PreviewProvider {
        static var previews: some View {
            MemoriesPage()
        }
    }
    
}
