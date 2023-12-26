// TasksViewModel.swift
import Foundation

struct Task: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var assignee: String
    var dueDate: Date?
    var status: TaskStatus

    // Implementing Equatable to compare tasks by their id
    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.id == rhs.id
    }
}

enum TaskStatus {
    case active
    case completed
}

class TasksViewModel: ObservableObject {
    @Published var tasks = [Task]()
    
    var activeTasks: [Task] {
        return tasks.filter { $0.status == .active }
    }
    
    var completedTasks: [Task] {
        return tasks.filter { $0.status == .completed }
    }
    
    func addTask(title: String, assignee: String, dueDate: Date?) {
        let newTask = Task(title: title, assignee: assignee, dueDate: dueDate, status: .active)
        tasks.append(newTask)
    }
    
    func deleteTask(at indexSet: IndexSet) {
        tasks.remove(atOffsets: indexSet)
    }
    
    func moveTask(fromOffsets source: IndexSet, toOffset destination: Int) {
        tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    func editTask(task: Task, newTitle: String, newAssignee: String, newDueDate: Date?) {
        // Implement your edit logic here
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            // Update the task's properties
            tasks[index].title = newTitle
            tasks[index].assignee = newAssignee
            tasks[index].dueDate = newDueDate
            tasks[index].status = .active
        }
    }
    
    func completeTask(task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks[index].status = .completed
        }
    }
    
    func markActive(task: Task) {
        if let index = tasks.firstIndex(of: task) {
            tasks[index].status = .active
        }
    }
    
    func performTaskAction(taskAction: TaskAction, newTitle: String? = nil, newAssignee: String? = nil, newDueDate: Date? = nil) {
        switch taskAction {
        case .edit(let task):
            guard let newTitle = newTitle, let newAssignee = newAssignee, let newDueDate = newDueDate else {
                print("Missing new values for task editing.")
                return
            }
            editTask(task: task, newTitle: newTitle, newAssignee: newAssignee, newDueDate: newDueDate)
        case .delete(let task):
            deleteTask(at: IndexSet([tasks.firstIndex(of: task)!]))
        case .complete(let task):
            completeTask(task: task)
        case .markActive(let task):
            markActive(task: task)
        }
    }

}
