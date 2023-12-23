// TasksView.swift
import SwiftUI

struct TasksView: View {
    @ObservedObject var tasksViewModel = TasksViewModel()
    @State private var newTaskTitle = ""
    @State private var newTaskAssignee = ""
    @State private var newTaskDueDate: Date?

    var body: some View {
        VStack {
            List {
                ForEach(tasksViewModel.tasks) { task in
                    NavigationLink(destination: TaskDetailView(task: task)) {
                        Text(task.title)
                    }
                }
                .onDelete(perform: tasksViewModel.deleteTask)
            }

            Form {
                TextField("Task Title", text: $newTaskTitle)
                TextField("Assignee", text: $newTaskAssignee)
                DatePicker("Due Date", selection: Binding<Date>(
                    get: { self.newTaskDueDate ?? Date() },
                    set: { self.newTaskDueDate = $0 }
                ), displayedComponents: .date)

                Button("Add Task") {
                    tasksViewModel.addTask(
                        title: newTaskTitle,
                        assignee: newTaskAssignee,
                        dueDate: newTaskDueDate
                    )

                    // Clear the input fields after adding a task
                    newTaskTitle = ""
                    newTaskAssignee = ""
                    newTaskDueDate = nil
                }
            }
            .padding()
        }
        .navigationTitle("Tasks")
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
