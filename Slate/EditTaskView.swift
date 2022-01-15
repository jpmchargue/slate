//
//  NewTaskView.swift
//  Slate
//
//  Created by James McHargue on 1/4/22.
//

import SwiftUI

struct EditTaskView: View {
    @Binding var data: TaskData.Data
    @State private var newSubtaskText = ""
    let taskFieldColor: Color = Color(UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0))
    let subtaskFieldColor: Color = Color(UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0))
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                TextField("thing to do", text: $data.text)
                    .padding()
                    .foregroundColor(data.pink ? .white : .black)
                    .background(data.pink ? .pink : taskFieldColor)
                    .cornerRadius(8)
                    .shadow(radius: 1)
                
                Text("DESCRIPTION")
                    .font(.system(size: 12, weight:.bold))
                    .foregroundColor(.gray)
                    .padding(.top)
                
                TextEditor(text: $data.description)
                    .font(.caption)
                    .cornerRadius(8)
                    .frame(minHeight: 100, maxHeight: 200)
                    //.shadow(radius: 1)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 2)
                                .foregroundColor(taskFieldColor))
                
                Toggle("Prioritize", isOn: $data.pink)
                    .padding()
                    //.foregroundColor(data.pink ? .pink : .black)
                    .toggleStyle(SwitchToggleStyle(tint: .pink))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundColor(data.pink ? .pink : taskFieldColor))
                
                Text("SUBTASKS")
                    .font(.system(size: 12, weight:.bold))
                    .foregroundColor(.gray)
                    .padding(.top)
                
                //ForEach(data.subtasks) { subtask in
                ForEach($data.subtasks.indices, id: \.self) { i in
                    HStack {
                        Text(data.subtasks[i].text)
                            .font(.system(size: 14))
                            .padding(10)
                            .foregroundColor(data.subtasks[i].pink ? .white : .black)
                            .background(data.subtasks[i].pink ? .pink : subtaskFieldColor)
                            .cornerRadius(8)
                        
                        Spacer()
                        
                        Button(action: {
                            data.subtasks[i].togglePink()
                            
                        }) {
                            Image(systemName: "arrow.up")
                                .foregroundColor(data.subtasks[i].pink ? .pink : .blue)
                        }
                        .padding(.trailing, 10)
                        
                        Button(action: {
                            data.subtasks.remove(at: i)
                        }) {
                            Image(systemName: "trash")
                        }
                    }
                }
                
                HStack {
                    TextField("new subtask", text: $newSubtaskText)
                        .font(.system(size: 14))
                    
                    Button(action: {
                        withAnimation {
                            let newSubtask = SubtaskData(text: newSubtaskText, desc: "", pink: false, done: false)
                            data.subtasks.append(newSubtask)
                            newSubtaskText = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newSubtaskText.isEmpty)
                }
                .padding(10)
                .cornerRadius(8)
                //.background(subtaskFieldColor)
                .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 2)
                            .foregroundColor(taskFieldColor))
                
                
                 
                /*
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $data.text)
                                    .frame(minHeight: 30, alignment: .leading)
                                    // following line is a hack to force TextEditor to appear
                                    //  similar to .textFieldStyle(RoundedBorderTextFieldStyle())...
                                    .cornerRadius(6.0)
                                    .foregroundColor(Color(.gray))
                                    .multilineTextAlignment(.leading)
                                Text("objectDescription ?? placeholder")
                                    // following line is a hack to create an inset similar to the TextEditor inset...
                                    .padding(.leading, 4)
                                    .foregroundColor(Color(.gray))
                                    .opacity(0)
                }.shadow(radius: 1)
                 */
            }
            .padding(.leading)
            .padding(.trailing)
        }
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(data: Binding.constant(TaskData.sampleData[5].data))
    }
}
