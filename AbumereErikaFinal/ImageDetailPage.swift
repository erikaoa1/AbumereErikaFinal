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

struct ImageDetailPage: View {
    @EnvironmentObject var transcriptionViewModel: TranscriptionViewModel
     private var transcription: Transcription?
    
    @State private var id: UUID?
    @State private var image: UIImage?
    @State private var description = ""
    @State private var location = ""
    @State private var timestamp = ""
    @State private var isMemory = false

    
    init(transcription: Transcription? = nil) {
        if let transcription = transcription {
            self.transcription = transcription
            _id = State(initialValue: transcription.id)
            _description = State(initialValue: transcription.description)
            _location = State(initialValue: transcription.location)
            _timestamp = State(initialValue: transcription.timestamp)
            
            _isMemory = State(initialValue: transcription.isMemory)
            _image = State(initialValue: transcription.image)
        }
    }
    
    var isHearted : Bool{
        return transcriptionViewModel.isLiked(transcription: transcription!) == true
    }
    
    @State private var fav = false
    
    func heartClicked(){
        transcriptionViewModel.toggleMemory(transcription: transcription!)
        fav = isHearted
    }
    
    var body: some View {
        VStack{
            //display heart icon
            HStack {
                Spacer()
                Button(action: {
                    heartClicked()
                }) {
                    Image(systemName:"heart.fill")
                        .font(.system(size: 30))
                        .padding()
                }
                .tint(fav ? .red : .gray)
            }
            .padding()
            
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
            }
            Text(location)
                .font(.caption)
            Text(timestamp)
                .font(.caption)
            Spacer()
            
            Text(description)
                .font(.title3)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                )
            
        }
        .navigationBarBackButtonHidden(false)
    }

    
}
