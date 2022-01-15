//
//  SubtaskData.swift
//  Slate
//
//  Created by James McHargue on 1/2/22.
//

import Foundation

struct SubtaskData: Identifiable, Codable {
    
    let id: UUID
    var text: String
    var description: String
    var pink: Bool
    var done: Bool
    
    init(id: UUID = UUID(), text: String, desc: String, pink: Bool, done: Bool) {
        self.id = id
        self.text = text
        self.description = desc
        self.pink = pink
        self.done = done
    }
    
    mutating func togglePink() {
        self.pink = !self.pink;
    }
    
    mutating func toggleDone() {
        self.done = !self.done;
    }
}
