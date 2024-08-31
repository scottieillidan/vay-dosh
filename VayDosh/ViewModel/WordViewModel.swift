//
//  WordViewModel.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/2/23.
//

import SwiftUI
import CoreData

class WordViewModel: ObservableObject {
    
    @Published var words : [WordModel] = []
    
    func saveData(context: NSManagedObjectContext) {
        words.forEach { (data) in
            let entity = Item(context: context)
            entity.id = UUID()
            entity.isFavorite = false
            entity.dictionary = data.dictionary
            entity.ingush = data.ingush
            entity.russian = data.russian
        }
        
        do {
            try context.save()
            print("Success! JSON Data was saved to Core Data.")
        } catch {
            print("Couldn't save the data: \(error.localizedDescription).")
        }
    }
    
    func loadData(context: NSManagedObjectContext) {
        if let url = Bundle.main.url(forResource: "data", 
                                     withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let words = try JSONDecoder().decode([WordModel].self, 
                                                     from: data)
                
                
                DispatchQueue.main.async {
                    self.words = words
                    self.saveData(context: context)
                }
            } catch {
                print("Error loading data: \(error.localizedDescription).")
            }
        } else {
            print("Error locating file.")
        }
    }
}


