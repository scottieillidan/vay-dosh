//
//  File.swift
//  VayDosh
//
//  Created by Adam Miziev on 7/22/24.
//

import SwiftUI

struct Word: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case dictionary
        case ingush
        case russian
    }
    
    var id = UUID()
    var dictionary: String
    var ingush: String
    var russian: String
}

class ReadData: ObservableObject {
    @Published var words = [Word]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "data",
                                        withExtension: "json")
        else {
            print("Json file not found")
            return
        }
        
        let data = try? Data(contentsOf: url)
        let words = try? JSONDecoder().decode([Word].self, from: data!)
        self.words = words!
    }
}

struct CheckView: View {
    @ObservedObject var words = ReadData()
    var body: some View {
        List(words.words) { word in
            VStack(alignment: .leading) {
                Text(word.dictionary)
                Text(word.ingush)
                Text(word.russian)
            }
            
        }
    }
}

struct CheckView_Previews: PreviewProvider {
    static var previews: some View {
        CheckView()
    }
}

