//
//  RootViewB.swift
//  Slate
//
//  Created by James McHargue on 1/3/22.
//

import SwiftUI

struct ToDoView: View {
    @Binding var taskList: [TaskData]
    @State var activeIndex: Int
    
    @State private var showAddSheet: Bool = false
    @State private var showTaskSheet: Bool = false
    @State private var showTaskOptions: Bool = false
    @State private var showEditSheet: Bool = false
    
    @State private var taskSheetTask: TaskData.Data = TaskData.Data()
    
    init(taskList: Binding<[TaskData]>) {
        self._taskList = taskList
        activeIndex = 0
        showAddSheet = false
        showTaskSheet = false
        taskSheetTask = TaskData.Data()
    }
    
    func resetEditTask() {
        taskSheetTask = TaskData.Data()
    }
    
    var body: some View {
        VStack(spacing:15) {
            HStack {
                Text("The Slate")
                    .font(Font.custom("PlayfairDisplay-Black", size: 42))
                    .fontWeight(.bold)
                    .padding(.leading)
                
                Spacer()
                Button(action: {
                    showAddSheet = true
                }) {
                    Image(systemName: "plus.circle")
                }
                .padding(.trailing)
            }
            .padding(.top)
            
            
            
            List {
                //ForEach($taskList) { $task in
                ForEach($taskList.indices, id: \.self) { i in
                //ForEach($taskList.indices, id: \.self) { i in
                    //let i = taskList.firstIndex(of: task) ?? 0
                    if !taskList[i].done {
                        TaskListView(task: taskList[i])
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                activeIndex = i
                                print(activeIndex)
                                showTaskSheet = true
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    taskList[i].toggleDone()
                                } label: {
                                    Image(systemName: "checkmark")
                                }
                                .tint(.green)
                            }
                            .swipeActions(edge: .trailing) {
                                Button {
                                    taskList[i].togglePink()
                                } label: {
                                    Image(systemName: "arrow.up")
                                }
                                .tint(.pink)
                            }
                    }
                }
                    
                if (taskList.count == 0) {
                    Text("tap the plus to add a task")
                        .foregroundColor(Color(red:0.8, green:0.8, blue: 0.8))
                        .padding()
                        .frame(maxWidth:.infinity)
                        .listRowSeparator(.hidden)
                }
                else {
                    Image(systemName: "minus")
                        .foregroundColor(Color(red:0.8, green:0.8, blue: 0.8))
                        .padding()
                        .frame(maxWidth:.infinity)
                        .listRowSeparator(.hidden)
                }
                
            }
            .listStyle(PlainListStyle())
        }
        
        .sheet(isPresented: $showAddSheet) {
            HStack {
                Text("New Task")
                    .font(Font.custom("PlayfairDisplay-Black", size: 36))
                    .fontWeight(.bold)
                    .padding(.leading)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        let newTask = TaskData(data: taskSheetTask)
                        taskList.append(newTask)
                        taskSheetTask = TaskData.Data()
                        showAddSheet = false
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(taskSheetTask.text.isEmpty)
                
                Spacer()
                
                Button(action: {
                    showAddSheet = false
                }) {
                    Image(systemName: "chevron.down")
                }
                .padding(.trailing)
            }
            .padding(.top, 25)
            
            EditTaskView(data: $taskSheetTask)
        }
        
        // Task Sheet
        .sheet(isPresented: $showTaskSheet) {
            HStack {
                Text("Task " + String(activeIndex + 1))
                    .font(Font.custom("PlayfairDisplay-Black", size: 36))
                    .fontWeight(.bold)
                    .padding(.leading)
                
                Spacer()
                
                // Edit Options Button
                Button(action: {
                    withAnimation {
                        showTaskOptions = !showTaskOptions
                    }
                }) {
                    Image(systemName: "ellipsis")
                }
                
                Spacer()
                
                // Hide Task Sheet
                Button(action: {
                    showTaskSheet = false
                    showTaskOptions = false
                }) {
                    Image(systemName: "chevron.down")
                }
                .padding(.trailing)
            }
            .padding(.top, 25)
            
            // Task Options
            if showTaskOptions {
                HStack() {
                    Spacer()
                    
                    // Edit Task
                    Button(action: {
                        taskSheetTask = taskList[activeIndex]
                        .data
                        showTaskOptions = false
                        showTaskSheet = false
                        showEditSheet = true
                    }) {
                        Label("Edit", systemImage: "pencil")
                            .font(.system(size: 24))
                    }
                    Spacer()
                    
                    // Delete Task
                    Button(action: {
                        showTaskOptions = false
                        showTaskSheet = false
                        taskList.remove(at: activeIndex)
                    }) {
                        Label("Delete", systemImage: "trash")
                            .font(.system(size: 24))
                    }
                    
                    Spacer()
                }
                .padding(.top, 2)
                .padding(.bottom, 24)
                
            }
            
            TaskView(task: $taskList[activeIndex])
        }
        
        .sheet(isPresented: $showEditSheet) {
            HStack {
                Text("Task " + String(activeIndex + 1))
                    .font(Font.custom("PlayfairDisplay-Black", size: 36))
                    .fontWeight(.bold)
                    .padding(.leading)
                
                Spacer()
                
                // Save Updates
                Button(action: {
                    withAnimation {
                        taskList[activeIndex].update(data: taskSheetTask)
                        resetEditTask()
                        showEditSheet = false
                    }
                }) {
                    //Text("Save")
                    Image(systemName: "plus")
                }
                .disabled(taskSheetTask.text.isEmpty)
                
                Spacer()
                
                // Cancel Updates
                Button(action: {
                    showEditSheet = false
                    showTaskSheet = true
                    resetEditTask()
                }) {
                    Image(systemName: "chevron.down")
                }
                .padding(.trailing)
            }
            .padding(.top, 25)
            
            EditTaskView(data: $taskSheetTask)
        }
        
    }
}


struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView(taskList: .constant(TaskData.sampleData))
    }
}

