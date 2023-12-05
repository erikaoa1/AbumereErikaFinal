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
        }
        .onChange(of: imageItem) { _ in
            Task {
                if let data = try? await imageItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        //display the image
                        selectedImage = Image(uiImage: uiImage)
                        getDescription(image: uiImage)
                        return
                    }
                }

                print("Failed")
            }
        }
    }
    
    
    func getDescription(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data")
            return
        }

        let apiKey = "E843F250-F8D2-45FA-AB61-C722E201A70882591561-BA9A-4859-AE59-F64CB368E550"
        let apiUrl = "https://vision.astica.ai/describe"
        let modelVersion = "2.0_full" // Use version 2.0
        
        // Define the parameters for the API request
        let parameters: [String: Any] = [
            "tkn": apiKey,
            "modelVersion": modelVersion,
            "visionParams": "description", // Specify the desired metadata (description/caption)
            "input": imageData.base64EncodedString() // Use Base64 encoded string of the image
        ]
        
        // Convert parameters to JSON data
        guard let jsonBody = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Failed to convert parameters to JSON data")
            return
        }


        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonBody

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                    do {
                        // Parse the JSON data
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                        // Extract the caption from the response
                        if let caption = json?["caption"] as? String {
                            print("Generated Caption: \(caption)")
                        } else {
                            print("Caption not found in the response.")
                        }
                    } catch {
                        print("Error parsing JSON: \(error.localizedDescription)")
                    }
                } else if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }.resume()
    }

}


struct TranscribePage_Previews: PreviewProvider {
    static var previews: some View {
        TranscribePage()
    }
}
