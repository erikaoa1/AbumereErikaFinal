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
    @StateObject var transcriptionViewModel = TranscriptionViewModel()
    @State private var imageItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    
    var body: some View {
        VStack {
            PhotosPicker("Upload an image", selection: $imageItem, matching: .images)
            
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
                
                let descriptions = transcriptionViewModel.descriptions
                                
            }
        }
        .onChange(of: imageItem) { _ in
            Task {
                if let data = try? await imageItem?.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        //display the image
                        //selectedImage = Image(uiImage: image)
                        
                        await transcriptionViewModel.getDescription(image: image)
                        //if else block use to be here
                    }
                    print("Failed")
                }
            }
        }
        
    }
}
