// TaskSectionView.swift
import SwiftUI

enum TaskAction {
    case edit(Task)
    case delete(Task)
    case complete(Task)
    case markActive(Task)
}

struct TaskSectionView: View {
    var tasks: [Task]
    var title: String
    var action: (TaskAction) -> Void

    var body: some View {
        Section(header: Text(title)) {
            ForEach(tasks) { task in
                HStack {
                    Text(task.title)
                    Spacer()

                    Menu {
                        if title == "Active"{
                            Button(action: {
                                action(.edit(task))
                            }) {
                                Label("Edit", systemImage: "pencil")
                            }
                        }
                       

                        Button(action: {
                            action(.delete(task))
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                        
                        if title == "Completed" {
                            Button(action:{
                                action(.markActive(task))
                            }){
                                Label("Mark as Active", systemImage: "arrow.uturn.left.circle")
                            }
                        }
                        else{
                        
                            Button(action: {
                                action(.complete(task))
                            }) {
                                Label("Mark as Completed", systemImage: "checkmark.circle")
                            }
                        }
                        
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
    }
}
