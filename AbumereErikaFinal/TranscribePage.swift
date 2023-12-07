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
    
    @State private var v2Checked = false
    
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
                Spacer()
                HStack{
                    Toggle(isOn: $v2Checked) {
                        Text("PicSense Pro")
                    }
                    .padding()
                    Text("Please note that PicSense Pro takes quite longer to generate a description.")
                        .font(.caption)
                }
            
                
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
                        
                        if (v2Checked){
                            //v2 -- gpt_detailed
                            NavigationLink("transcribe page", destination: DetailPage2(transcription: apiResults), isActive: $resultsReady)
                                .hidden()
                            
                        }else{
                            //v1 -- standard gpt
                            NavigationLink("transcribe page", destination: DetailPage1(transcription: apiResults), isActive: $resultsReady)
                                .hidden()
                        }
                    
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
                            if (v2Checked){
                                await imageInfo =  transcriptionViewModel.getDescription(image: image, param: "gpt_detailed")
                            }else{
                                await imageInfo =  transcriptionViewModel.getDescription(image: image, param: "gpt")
                            }
                            
                            
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
