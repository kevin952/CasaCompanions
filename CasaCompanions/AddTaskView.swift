import SwiftUI
import Foundation

struct AddTaskView: View {
    @ObservedObject var tasksViewModel: TasksViewModel
    @Binding var isPresented: Bool
    @State private var newTaskTitle = ""
    @State private var newTaskAssignee = ""
    @State private var newTaskDueDate: Date?

    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $newTaskTitle)
                TextField("Assignee", text: $newTaskAssignee)
                DatePicker("Due Date", selection: Binding<Date>(
                        get: { self.newTaskDueDate ?? Date() },
                        set: { self.newTaskDueDate = $0 }
                    ), displayedComponents: .date)
            }
            .navigationBarTitle("Add Task", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                tasksViewModel.addTask(title: newTaskTitle, assignee: newTaskAssignee, dueDate: newTaskDueDate)
                isPresented = false
            }) {
                Text("Add")
            })
        }
    }
}
