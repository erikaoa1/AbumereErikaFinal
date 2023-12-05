//
//  TranscriptionViewModel.swift
//  AbumereErikaFinal
//
//  Created by Student on 12/4/23.
//


import Foundation
class TranscriptionViewModel: TranscriptionModel, ObservableObject {
    /*
     
     HAS TO CONFORM TO TRANSCRIPTION MODEL
    
    
    @Published var flashcards: [Flashcard] = [] {
        didSet {
            // Whenever flashcards array is changed, invoke the save method
            save()
        }
    }
    
    @Published var currentIndex : Int = 0{
        didSet{
            if currentIndex < 0{
                currentIndex = 0
            } else if currentIndex >= flashcards.count {
                currentIndex = flashcards.count - 1
            }
        }
    }
    
    private var flashcardsFilePath: URL;
    init(){
        self.flashcards = [Flashcard(id: UUID(), question: "What is the best University in California?", answer: "USC", isFavorite: false),
                       Flashcard(id: UUID(), question: "What is the best programming language?", answer: "Swift", isFavorite: false),
                       Flashcard(id: UUID(), question: "What is the best class at USC?", answer: "ITP 342", isFavorite: false),
                       Flashcard(id: UUID(), question: "Who is the president of USC?", answer: "Carol Folt", isFavorite: false),
                       Flashcard(id: UUID(), question: "What UI Framework are we learning?", answer: "SwiftUI", isFavorite: false)
        
        ]
        
            
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                  self.flashcardsFilePath = documentsDirectory.appendingPathComponent("flashcards.json")
              } else {
                  // Handle the case where the documents directory cannot be found
                  fatalError("Unable to find documents directory")
              }
        
        if let loadedFlashcards = load() {
            self.flashcards = loadedFlashcards
        }
    }
    
    // Attempts to read from disk and decodes from JSON into Swift objects
    private func load() -> [Flashcard]? {
        do {
            // Attempt to read from disk and decode from JSON into Swift objects
            let flashcardString = try Data(contentsOf: flashcardsFilePath)
            let flashcards = try JSONDecoder().decode([Flashcard].self, from: flashcardString)
            return flashcards
        } catch {
            // Handle any errors that occur during the process
            print("Error loading flashcards: \(error)")
            return nil
        }
    }
    
    
    private func save() {
        do {
            // Encode the flashcards array into JSON data
            let jsonData = try JSONEncoder().encode(flashcards)
            
            // Write the JSON data to the file path
            try jsonData.write(to: flashcardsFilePath)
        } catch {
            // Handle any errors that occur during the process
            print("Error saving flashcards: \(error)")
        }
    }
    
    
    // Returns the number of flashcards in your flashcards array
    var numberOfFlashcards: Int { return flashcards.count }
    
    // Returns the current flashcard indicated by your currentIndex
    var currentFlashcard: Flashcard? {
        if flashcards.count == 0 || currentIndex < 0 || currentIndex >= flashcards.count {
            return nil
        } else {
            return flashcards[currentIndex] }
        
    }
    // Returns flashcards that has been marked as favorited
    var favoriteFlashcards: [Flashcard] {
        var favs = [Flashcard]()
        for i in 0..<flashcards.count{
            if flashcards[i].isFavorite == true {
                favs.append(flashcards[i])
            }
        }
       return favs
    }
    // Randomizes the currentIndex
    func randomize(){
        if flashcards.count == 0 {
            
        }
        else {
            currentIndex = Int.random(in: 0..<flashcards.count)
        }
    }
    // Set currentIndex to be next
        // if currentIndex reaches the end of array
        // it should loop back to the beginning of array
    func next(){
        if currentIndex == flashcards.count-1{
            currentIndex = 0
        } else{
            currentIndex+=1
        }
    }
    // Set currentIndex to be previous
        // if currentIndex reaches past the beginning
        // it should loop back to the end of array
    func previous(){
        if currentIndex == 0 {
            currentIndex = flashcards.count - 1
        } else {
            currentIndex-=1
        }
    }
    // Returns a flashcard at a given index
    func flashcard(at index: Int) -> Flashcard?{
        if index < 0 || index >= flashcards.count{
            return nil
        } else{
            return flashcards[index]
        }
    }
    // Initializes a flashcard at end of your flashcards array
    func append(flashcard: Flashcard){
        flashcards.append(flashcard)
    }
    
    // Initializes a flashcard at specific index of your flashcards array
    func insert(flashcard: Flashcard, at index: Int){
        if index < 0 || index >= flashcards.count {
            flashcards.append(flashcard)
        } else{
            flashcards.insert(flashcard, at: index)
        }
        
    }
    // Removes flashcard at a specific index
    func removeFlashcard(at index: Int){
        if index < 0 || index >= flashcards.count{
            
        } else {
            flashcards.remove(at: index)
        }
    }
    // Returns an index for a given flashcard
    func getIndex(for flashcard: Flashcard) -> Int?{
        var fcIndex : Int? = nil
        for i in 0..<flashcards.count{
            if flashcards[i] == flashcard {
                fcIndex = i
            }
        }
        return fcIndex
    }
    // Updates a flashcard at a specific index
    func update(flashcard: Transcription, at index: Int){
        var flashcardd = flashcards[index]
        flashcardd = flashcard
    }
    
    // Toggles the favorite attribute of your flashcard
    func toggleFavorite(){
        //toggle turn on or off not just on (does opposite of current)
        let fcID = flashcards[currentIndex].id
        let fcQuestion = flashcards[currentIndex].question
        let fcAnswer = flashcards[currentIndex].answer
        let fcIsFav = !(flashcards[currentIndex].isFavorite) //toggling favorite
        let newFc : Transcription = Flashcard(id:fcID, question: fcQuestion, answer: fcAnswer, isFavorite: fcIsFav)
        
        //replacing old flashcard with new
        flashcards[currentIndex] = newFc
        
    }
    */
}
