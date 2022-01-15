//
//  RootView.swift
//  Slate
//
//  Created by James McHargue on 1/4/22.
//

import SwiftUI

struct RootView: View {
    @Binding var taskList: [TaskData]
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    
    var body: some View {
        TabView {
            ToDoView(taskList: $taskList)
                .tabItem {
                    Image(systemName: "line.3.horizontal")
                }
            CompletedView(taskList: $taskList)
                .tabItem {
                    Image(systemName: "checkmark")
                }
        }
        .onChange(of: scenePhase) { phase in
            if (phase == .inactive) { saveAction() }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(taskList: .constant(TaskData.sampleData), saveAction: {})
    }
}
