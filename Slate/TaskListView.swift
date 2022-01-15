//
//  TaskListView.swift
//  Slate
//
//  Created by James McHargue on 1/2/22.
//

import SwiftUI

struct TaskListView: View {
    let task: TaskData
    let taskColor: Color = Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 1.0)
    
    func chooseColor(pink: Bool, done: Bool, defaultColor: Color) -> Color {
        if (done) {
            return .green
        }
        else {
            return pink ? .pink : defaultColor
        }
    }
    
    var body: some View {
        HStack() {
                Text(task.text)
                if task.subtasks.count > 0 {
                    Image(systemName: "list.bullet")
                }
            }
            .padding()
            .foregroundColor(task.pink || task.done ? .white : .black)
            .background(chooseColor(pink: task.pink, done: task.done, defaultColor: taskColor))
            .cornerRadius(8)
        
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(task: TaskData.sampleData[5])
    }
}
