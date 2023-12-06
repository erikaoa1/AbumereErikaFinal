//
//  TranscriptionViewModel.swift
//  AbumereErikaFinal
//
//  Created by Student on 12/4/23.
//


import Foundation
import UIKit

class TranscriptionViewModel: ObservableObject {
    
    struct Response: Codable {
        let caption_GPTS: String
        // Add other properties as needed
    }
    
    @Published var memories: [Transcription] = []
    
    private let url = "https://vision.astica.ai/describe"
    private let apiKey = "E843F250-F8D2-45FA-AB61-C722E201A70882591561-BA9A-4859-AE59-F64CB368E550"
    let params = "gpt"
    //works for describe
    //works for gpt
    // works for gpt_detailed
    //seems to only work with one param
    
    

    @Published var isLoading = false
    @Published var descriptions: String = ""

    func getDescription(image: UIImage) async -> String {
        
         guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data")
        }
        let imageAsString = imageData.base64EncodedString()

        do {
            isLoading = true

            var request = URLRequest(url: URL(string: url)!)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let parameters = [
                "tkn": apiKey,
                "input": imageAsString,
                "visionParams": params,
                "modelVersion": "2.0_full"
            ]


            let requestJSON = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = requestJSON
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            //print raw json data
            //print(String(data: data, encoding: .utf8) ?? "Data is not valid UTF-8")
            
            let decoder = JSONDecoder()
            let results = try decoder.decode(Response.self, from: data)
            
            print(results.caption_GPTS)
            return results.caption_GPTS
            
        } catch {
            //print("Error: \(error.localizedDescription)")
            print(String(describing: error))
        }

        isLoading = false
    }
    return results.caption_GPTS

}
