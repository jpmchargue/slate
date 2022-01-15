//
//  TaskView.swift
//  Slate
//
//  Created by James McHargue on 1/2/22.
//

import SwiftUI

struct TaskView: View {
    @Binding var task: TaskData
    let taskFieldColor: Color = Color(red: 0.9, green: 0.9, blue: 0.9)
    let subtaskFieldColor: Color = Color(red: 0.75, green: 0.75, blue: 0.75)
    
    func chooseColor(pink: Bool, done: Bool, defaultColor: Color) -> Color {
        if (done) {
            return .green
        }
        else {
            return pink ? .pink : defaultColor
        }
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(task.text)
                    .padding()
                    .foregroundColor(task.pink || task.done ? .white : .black)
                    .background(chooseColor(pink: task.pink, done: task.done, defaultColor: taskFieldColor))
                    .cornerRadius(8)
                
                if (task.description.count > 0) {
                    TaskSubheading(text: "DESCRIPTION")
                
                    Text(task.description)
                        .font(.caption)
                        .cornerRadius(8)
                        .padding(.bottom)
                }
                
                /*
                Toggle("Done", isOn: $task.done)
                    .padding()
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(task.done ? .green : taskFieldColor))
                */
                
                Button(action: {
                    task.toggleDone()
                }) {
                    Text(task.done ? "Reverse completion" : "Mark as completed")
                        .padding()
                        .frame(maxWidth:.infinity)
                        .foregroundColor(.green)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(.green)
                                 )
                }
                
                if (!task.done) {
                    Toggle("Prioritize", isOn: $task.pink)
                        .padding()
                        .toggleStyle(SwitchToggleStyle(tint: .pink))
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 2)
                                    .foregroundColor(task.pink ? .pink : taskFieldColor))
                }
            }
            .padding(.leading)
            .padding(.trailing)
            
            if task.subtasks.count > 0 {
                TaskSubheading(text: "SUBTASKS")
                    .padding(.leading)
            }
            
                List {
                    ForEach($task.subtasks) { $subtask in
                        Text(subtask.text)
                            .font(.system(size: 14))
                            .padding(10)
                            .foregroundColor(subtask.pink || subtask.done ? .white : .black)
                            .background(chooseColor(pink: subtask.pink, done: subtask.done, defaultColor: subtaskFieldColor))
                            .cornerRadius(8)
                            .swipeActions(edge: .leading) {
                                Button {
                                    subtask.toggleDone()
                                } label: {
                                    Image(systemName: "checkmark")
                                }
                                .tint(.green)
                            }
                            .swipeActions(edge: .trailing) {
                                Button {
                                    subtask.togglePink()
                                } label: {
                                    Image(systemName: "arrow.up")
                                }
                                .tint(.pink)
                            }
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.leading, 0)
            
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: .constant(TaskData.sampleData[5]))
    }
}
