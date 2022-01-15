//
//  CompletedView.swift
//  Slate
//
//  Created by James McHargue on 1/3/22.
//

import SwiftUI

struct CompletedView: View {
    @Binding var taskList: [TaskData]
    @State var activeIndex: Int
    
    @State private var showTaskSheet: Bool = false
    
    init(taskList: Binding<[TaskData]>) {
        self._taskList = taskList
        activeIndex = 0
    }
    
    var body: some View {
        VStack(spacing:15) {
            HStack {
                Text("Completed")
                    .font(Font.custom("PlayfairDisplay-Black", size: 42))
                    .fontWeight(.bold)
                    .padding(.leading)
                
                Spacer()
            }
            .padding(.top)
            
            List {
                ForEach($taskList.indices, id: \.self) { i in
                    if taskList[i].done {
                        TaskListView(task: taskList[i])
                            //.listRowBackground(Color.black)
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                activeIndex = i
                                print(activeIndex)
                                showTaskSheet = true
                            }
                            // Delete
                            .swipeActions(edge: .leading) {
                                Button {
                                    taskList.remove(at: i)
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                            }
                            // Un-complete
                            .swipeActions(edge: .trailing) {
                                Button {
                                    taskList[i].toggleDone()
                                } label: {
                                    Image(systemName: "arrow.uturn.backward")
                                }
                                .tint(.black)
                            }
                    }
                }
                    
                Image(systemName: "minus")
                    .foregroundColor(Color(red:0.8, green:0.8, blue:0.8))
                    .padding()
                    .frame(maxWidth:.infinity)
                    //.listRowBackground(Color.black)
                    .listRowSeparator(.hidden)
                
            }
            .listStyle(PlainListStyle())
            //.background(.black)
        }
        //.background(.black)
        
        // Task Sheet
        .sheet(isPresented: $showTaskSheet) {
            HStack {
                Text("Task " + String(activeIndex + 1))
                    .font(Font.custom("PlayfairDisplay-Black", size: 36))
                    .fontWeight(.bold)
                    .padding(.leading)
                
                Spacer()
                
                // Hide Task Sheet
                Button(action: {
                    showTaskSheet = false
                }) {
                    Image(systemName: "chevron.down")
                }
                .padding(.trailing)
            }
            .padding(.top, 25)
            
            TaskView(task: $taskList[activeIndex])
        }
        
        
    }
}

struct CompletedView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedView(taskList: .constant(TaskData.sampleData))
    }
}
