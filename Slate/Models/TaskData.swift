//
//  TaskData.swift
//  Slate
//
//  Created by James McHargue on 1/2/22.
//

import Foundation

struct TaskData: Identifiable, Codable {
    
    let id: UUID
    var text: String = ""
    var description: String = ""
    var pink: Bool = false
    var done: Bool = false
    var subtasks: [SubtaskData] = []
    
    init(id: UUID = UUID(), text: String, desc: String, pink: Bool, done: Bool, subtasks: [SubtaskData]) {
        self.id = id
        self.text = text
        self.description = desc
        self.pink = pink
        self.done = done
        self.subtasks = subtasks
    }
    
    struct Data {
        var text: String = ""
        var description: String = ""
        var pink: Bool = false
        var done: Bool = false
        var subtasks: [SubtaskData] = []
    }
    
    init(id: UUID = UUID(), data: Data) {
        self.id = id
        self.text = data.text
        self.description = data.description
        self.pink = data.pink
        self.done = data.done
        self.subtasks = data.subtasks
    }
    
    var data: Data {
        Data(text: text, description: description, pink: pink, done: done, subtasks: subtasks)
    }
    
    mutating func update(data: Data) {
        text = data.text
        description = data.description
        pink = data.pink
        done = data.done
        subtasks = data.subtasks
    }
    
    mutating func togglePink() {
        self.pink = !self.pink;
    }
    
    mutating func toggleDone() {
        self.done = !self.done;
    }
    
    mutating func addSubtask(subtask: SubtaskData) {
        subtasks.append(subtask)
    }
    
    //static func == (lhs: TaskData, rhs: TaskData) -> Bool {
        /*
        return ((lhs.text == rhs.text) &&
                (lhs.description == rhs.description) &&
                (lhs.done == rhs.done) &&
                (lhs.pink == rhs.done) &&
                (lhs.id == rhs.id))
         */
    //    return (lhs.id == rhs.id)
    //}
    
    static let sampleData: [TaskData] = [
        TaskData(text: "do laundry", desc: "", pink: true, done: false, subtasks: []),
        TaskData(text: "task with a very long name that probably should have been put in the description", desc: "", pink: true, done: false, subtasks: [SubtaskData(text: "generic subtask", desc: "", pink: false, done: false)]),
        TaskData(text: "make app", desc:"Create a simple, minimalist app for tracking and prioritizing things to do.", pink: false, done: false, subtasks: []),
        TaskData(text: "write essay", desc: "", pink: false, done: false, subtasks: []),
        TaskData(text: "pick up groceries", desc: "", pink: true, done: true, subtasks: []),
        TaskData(text: "submit application", desc: "Submit application to Oscorp for software engineering internship.", pink: false, done: false, subtasks: [
            SubtaskData(text: "revise resume", desc: "Go to the career office resume review", pink: true, done: false),
            SubtaskData(text: "get rec letter from Mr. Wylie", desc: "", pink: false, done: true),
            SubtaskData(text: "write cover letter", desc: "", pink: false, done: false)
        ])
    ]
    
    static let emptyTask: TaskData = TaskData(text: "", desc: "", pink: false, done: false, subtasks: [])
}
