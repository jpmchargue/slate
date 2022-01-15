//
//  SlateApp.swift
//  Slate
//
//  Created by James McHargue on 12/22/21.
//

import SwiftUI

@main
struct SlateApp: App {
    @StateObject private var taskModel = SlateFiles()
    
    var body: some Scene {
        WindowGroup {
            RootView(taskList: $taskModel.tasks) {
                SlateFiles.save(tasks: taskModel.tasks) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .onAppear {
                SlateFiles.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let tasks):
                        taskModel.tasks = tasks
                    }
                }
            }
        }
    }
}
