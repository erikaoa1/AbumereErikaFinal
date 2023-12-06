//
//  TranscriptionViewModel.swift
//  AbumereErikaFinal
//
//  Created by Student on 12/4/23.
//


import Foundation
import UIKit

class TranscriptionViewModel: ObservableObject {
    
    struct Response: Decodable {
        let caption_GPTS: String
        // Add other properties as needed
    }
    
    @Published var memories: [Transcription] = []
    
    private let url = "https://vision.astica.ai/describe"
    private let apiKey = "5E28F168-FB16-488D-8BD0-DF69D59185AECA2B5BAB-52BC-45FE-A025-4F0DE455E375"
    let params = "gpt"
    //works for describe
    //works for gpt
    // works for gpt_detailed
    //seems to only work with one param
    
    @Published var isLoading = false
    @Published var descriptions: String = ""
    
    

    func getDescription(image: UIImage) async -> String {
        
         guard let imageData = image.jpegData(compressionQuality: 0.8) else {
             return "Image conversion failed"
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
            let caption = results.caption_GPTS
           
            //print(caption)
            isLoading = false
            return caption
            
        } catch {
            //print("Error: \(error.localizedDescription)")
            print(String(describing: error))
        }

        return "results.caption_GPTS"
    }
    

}
