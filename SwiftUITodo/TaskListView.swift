//
//  TaskListView.swift
//  SwiftUITodo
//
//  Created by Suyeol Jeon on 03/06/2019.
//  Copyright © 2019 Suyeol Jeon. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var userData: UserData
    @State var draftTitle: String = ""
    @State var isEditing: Bool = false
    
    private func delete(at index: IndexSet) {
        guard let firstIndex = index.first else { return }
        self.userData.tasks.remove(at: firstIndex)
        if self.userData.tasks.isEmpty {
            self.isEditing = false
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                TextField("Create a New Task...", text: $draftTitle, onCommit: self.createTask)
                ForEach(self.userData.tasks) { task in
                    TaskItemView(task: task, isEditing: self.$isEditing)
                }.onDelete(perform: self.delete)
            }
            .navigationBarTitle(Text("Tasks 👀"))
            .navigationBarItems(trailing: Button(action: { self.isEditing.toggle() }) {
                if !self.isEditing {
                    Text("Edit")
                } else {
                    Text("Done").bold()
                }
            })
        }
    }
    
    private func createTask() {
        let newTask = Task(title: self.draftTitle, isDone: false)
        self.userData.tasks.insert(newTask, at: 0)
        self.draftTitle = ""
    }
}
