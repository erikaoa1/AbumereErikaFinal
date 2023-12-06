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
    private var transcription: Transcription?
    
    @State private var image: UIImage?
    @State private var description = ""
    @State private var location = ""
    @State private var timestamp = ""
    @State private var isMemory = false

    
    init(transcription: Transcription? = nil) {
        if let transcription = transcription {
            self.transcription = transcription
            _description = State(initialValue: transcription.description)
            _location = State(initialValue: transcription.location)
            _timestamp = State(initialValue: transcription.timestamp)
            
            _isMemory = State(initialValue: transcription.isMemory)
            _image = State(initialValue: transcription.image)
        }
    }
    
    var body: some View {
        VStack{
            Image(uiImage: image ?? Image(systemName: "logo"))
            
        }
    }

    
}
