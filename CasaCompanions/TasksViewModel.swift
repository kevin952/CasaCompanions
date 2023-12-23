// TasksViewModel.swift
import Foundation

struct Task: Identifiable {
    var id = UUID()
    var title: String
    var assignee: String
    var dueDate: Date?
}

class TasksViewModel: ObservableObject {
    @Published var tasks = [Task]()

    func addTask(title: String, assignee: String, dueDate: Date?) {
        let newTask = Task(title: title, assignee: assignee, dueDate: dueDate)
        tasks.append(newTask)
    }

    func deleteTask(at index: IndexSet) {
        tasks.remove(atOffsets: index)
    }
}
