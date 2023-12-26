import SwiftUI

struct EditTaskView: View {
    @ObservedObject var tasksViewModel: TasksViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var editedTaskTitle: String
    @State private var editedTaskAssignee: String
    @State private var editedTaskDueDate: Date?

    var task: Task

    init(tasksViewModel: TasksViewModel, task: Task) {
        self.tasksViewModel = tasksViewModel
        self.task = task

        // Set initial values for the form fields
        self._editedTaskTitle = State(initialValue: task.title)
        self._editedTaskAssignee = State(initialValue: task.assignee)
        self._editedTaskDueDate = State(initialValue: task.dueDate)
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $editedTaskTitle)
                TextField("Assignee", text: $editedTaskAssignee)
                DatePicker("Due Date", selection: Binding<Date>(
                    get: { self.editedTaskDueDate ?? Date() },
                    set: { self.editedTaskDueDate = $0 }
                ), displayedComponents: .date)
            }
            .navigationBarTitle("Edit Task", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                tasksViewModel.editTask(
                    task: task,
                    newTitle: editedTaskTitle,
                    newAssignee: editedTaskAssignee,
                    newDueDate: editedTaskDueDate
                )
                presentationMode.wrappedValue.dismiss() // Dismiss the sheet using presentationMode
            }) {
                Text("Save Changes")
            })
        }
    }
}
