//
//  Transcription.swift
//  AbumereErikaFinal
//
//  Created by Student on 12/4/23.
//

import Foundation
import UIKit


struct Transcription: Decodable  {
    let caption: String
    let caption_list: [String]
    let caption_tags: String
    let caption_GPTS: String
    let tags: [String]
    let categories: [String]
    let moderate: String
    let objects: [String]
    let faces: [String]
    let brands: [String]
    let astica: String
    
   
    
}


