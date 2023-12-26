import SwiftUI

struct TaskDetailView: View {
    @ObservedObject var tasksViewModel: TasksViewModel
    @State private var editedTitle: String
    @State private var editedAssignee: String
    @State private var editedDueDate: Date?

    var task: Task

    init(tasksViewModel: TasksViewModel, task: Task) {
        self.tasksViewModel = tasksViewModel
        self.task = task

        // Set initial values for the form fields
        self._editedTitle = State(initialValue: task.title)
        self._editedAssignee = State(initialValue: task.assignee)
        self._editedDueDate = State(initialValue: task.dueDate)
    }

    // Computed property to create a non-optional Binding<Date>
    private var nonOptionalEditedDueDate: Binding<Date> {
        Binding<Date>(
            get: { self.editedDueDate ?? Date() },
            set: { self.editedDueDate = $0 }
        )
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("Title", text: $editedTitle)
                    TextField("Assignee", text: $editedAssignee)
                    DatePicker("Due Date", selection: nonOptionalEditedDueDate, in: ...Date(), displayedComponents: .date)
                }

                Section {
                    Button("Save Changes") {
                        saveChanges()
                    }
                    .foregroundColor(.blue)
                }
            }
            .navigationBarTitle("Edit Task", displayMode: .inline)
        }
    }

    func saveChanges() {
        tasksViewModel.editTask(
            task: task,
            newTitle: editedTitle,
            newAssignee: editedAssignee,
            newDueDate: editedDueDate
        )
    }
}
