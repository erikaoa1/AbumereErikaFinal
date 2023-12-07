//
//  TranscribePage.swift
//  AbumereErikaFinal
//
//  Created by Student on 12/4/23.
//
//

import Foundation
import SwiftUI
import PhotosUI

struct TranscribePage: View {
    @EnvironmentObject var transcriptionViewModel: TranscriptionViewModel
    @State private var imageItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    @State private var imageInfo: [String]?
    @State private var userImage: UIImage?
    
    @State private var showSecondPage = false
    @State var apiResults: Transcription?
    @State private var resultsReady = false
    
    var body: some View {
        NavigationView {
            VStack {
                //Spacer()
                //Spacer()
                //Spacer()
                PhotosPicker(selection: $imageItem, matching: .images, label: {
                    // Custom button design using an Image
                    Image("uploadButton")
                        .frame(width: 100, height: 100)
                })
                
                if let selectedImage {
                    selectedImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                }
                
                if transcriptionViewModel.isLoading {
                    //print("loading")
                    ProgressView()
                } else {
                    //fully loaded and api has returned descriptinos json
                    //let descriptions = transcriptionViewModel.descriptions
                    //Text("loaded")
                    if imageInfo != nil{
                        
                        NavigationLink("transcribe page", destination: ImageDetailPage(transcription: apiResults), isActive: $resultsReady)
                            .hidden()
                    }
                    
                }
            }
            .onChange(of: imageItem) { _ in
                Task {
                    if let data = try? await imageItem?.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data) {
                            //display the image
                            //selectedImage = Image(uiImage: image)
                            userImage = image
                            await imageInfo =  transcriptionViewModel.getDescription(image: image)
                            
                            
                            apiResults = Transcription(id: UUID(),image: image, description: imageInfo![0], location: imageInfo![2], timestamp: imageInfo![1], isMemory: false)
                            
                            resultsReady = true
                            //if else block use to be here
                        }
                    }
                }
            }
            
        }
    }
}

extension Optional {
    var isNotNil: Bool {
        self != nil
    }
}
