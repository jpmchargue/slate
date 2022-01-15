//
//  MasterTasks.swift
//  Slate
//
//  Created by James McHargue on 1/5/22.
//

import Foundation
import SwiftUI

class MasterTasks: ObservableObject {
    @Published var tasks: [TaskData] = [
        TaskData(text: "sample task", desc: "sample description", pink: false, done: false, subtasks: []),
        TaskData(text: "sample pink task", desc: "sample pink description", pink: true, done: false, subtasks: []),
    ]

    @Published var activeTask: TaskData = TaskData(text: "", desc: "", pink: false, done: false, subtasks: [])
}
