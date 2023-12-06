//
//  TranscriptionModel.swift
//  AbumereErikaFinal
//
//  Created by Student on 12/4/23.
//

import Foundation
import CoreLocation
import UIKit

// Protocol that checks to make sure you are naming your functions like intended
protocol TranscriptionModel {
    
    func append(memory: Transcription)
    
    func requestPermission()
    
    func getTime() async -> String
    
    func convertTimestamp(_ timestamp: String) -> String
    
    func getLocationString() async -> String
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    
    func getDescription(image: UIImage) async -> [String]
        
    func replaceOrAdd(old: Transcription, new: Transcription)
    
    func toggleMemory(transcription: Transcription)
    
    func isLiked(transcription: Transcription) -> Bool
    
    
}
