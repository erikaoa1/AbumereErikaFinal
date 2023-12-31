//
//  TranscriptionViewModel.swift
//  AbumereErikaFinal
//
//  Created by Student on 12/4/23.
//


import Foundation
import UIKit
import CoreLocation
import MapKit


class TranscriptionViewModel: UIViewController, TranscriptionModel, ObservableObject, CLLocationManagerDelegate  {

    struct Response: Decodable {
        let caption_GPTS: String
        // Add other properties as needed
    }
    struct Time: Decodable {
        let datetime: String
    }
    
    
    @Published var memories: [Transcription] = []
    
    //append given memory to memories array
    func append(memory: Transcription){
        memories.append(memory)
    }
    
    func replaceOrAdd(old: Transcription, new: Transcription){
        var added = false
        
        for i in 0..<memories.count{
            if memories[i].id == new.id {
                memories[i] = new
                added = true
            }
        }
        
        if added == false{
            append(memory: new)
        }
    }
    
    func toggleMemory(transcription: Transcription){
        let tID = transcription.id
        let tDiscription = transcription.description
        let tImage = transcription.image
        let tLocation = transcription.location //toggling favorite
        let tTime = transcription.timestamp
        
        //always going to be true, bc transcription passed as parameter is the og transcription passed to ImageDetailPage
        
        var value = false
        for i in 0..<memories.count{
            //already in memories
            if memories[i].id == transcription.id {
                value = memories[i].isMemory
                break
            }
        }
        let tMemory = !value //toggling favorite
        
        let newT : Transcription = Transcription(id:tID, image: tImage, description: tDiscription, location: tLocation, timestamp: tTime, isMemory: tMemory)
        
        //add or replace this toggled transcription
        replaceOrAdd(old: transcription, new: newT)
    }
    
    func isLiked(transcription: Transcription) -> Bool{
        for i in 0..<memories.count{
            if memories[i].id == transcription.id {
                return memories[i].isMemory == true
            }
        }
        return false
    }
    
    
    private let url = "https://vision.astica.ai/describe"
    private let apiKey = "A4AFD649-BA3D-4F7E-AA97-F7A41020CB1653F47061-5460-44B7-821B-B4019478BDE5"
    //let params = "gpt"
    //works for describe
    //works for gpt
    // works for gpt_detailed
    //seems to only work with one param
    
    @Published var isLoading = false
    @Published var descriptions: String = ""
    
    //FOR LOCATION
    let locationManager = CLLocationManager()

    func requestPermission() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getTime() async -> String {
        var request = URLRequest(url: URL(string: "https://worldtimeapi.org/api/timezone/America/Los_Angeles")!)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            
            print(String(data: data, encoding: .utf8) ?? "Data is not valid UTF-8")
            
            let decoder = JSONDecoder()
            let results = try decoder.decode(Time.self, from: data)
            let timeStamp = results.datetime
            return timeStamp
        } catch {
            
        }
        

       return "failed to get time stamp"
    }
    
    func convertTimestamp(_ timestamp: String) -> String {
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds, .withTimeZone]
        
        if let date = inputFormatter.date(from: timestamp) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMMM d, y hh:mm a"
            return outputFormatter.string(from: date)
        } else {
            return "incorrect input format" // Return nil if the input timestamp is not in the expected format
        }
    }
    
    func getLocationString() async -> String {
        if let location = locationManager.location {
            let geocoder = CLGeocoder()
            if let placemark = try? await geocoder.reverseGeocodeLocation(location).first {
                if let city = placemark.locality, let state = placemark.administrativeArea {
                    return "\(city), \(state)"
                }
            }
        }
        print(locationManager.location)

        return "no location found"
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager Error: \(error.localizedDescription)")
    }

    func getDescription(image: UIImage, param: String) async -> [String] {
        
         guard let imageData = image.jpegData(compressionQuality: 0.8) else {
             return ["Image conversion failed"]
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
                "visionParams": param,
                "modelVersion": "2.0_full"
            ]


            let requestJSON = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = requestJSON
            
            //call to astica -- UNCOMMENT THIS 1
            let (data, _) = try await URLSession.shared.data(for: request)
            
            //print raw json data
            //print(String(data: data, encoding: .utf8) ?? "Data is not valid UTF-8")
            
            //UNCOMMENT THESE 3
            let decoder = JSONDecoder()
            let results = try decoder.decode(Response.self, from: data)
            let caption = results.caption_GPTS
           
            //print(caption)
            isLoading = false
            let timestamp = await getTime()
        
            let formattedTime = convertTimestamp(timestamp)
            let location = await getLocationString()
            
            //REMOVE QUOTES FROM CAPTION
            return [caption, formattedTime, location]
            
        } catch {
            print("Error: \(error.localizedDescription)")
          
            //print(String(describing: error))
        }

        return ["results.caption_GPTS"]
    } //end of get description
    

}
