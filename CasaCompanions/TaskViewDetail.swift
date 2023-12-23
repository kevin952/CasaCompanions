// TaskDetailView.swift
import SwiftUI

struct TaskDetailView: View {
    var task: Task

    var body: some View {
        VStack {
            Text("Task Title: \(task.title)")
            Text("Assignee: \(task.assignee)")

            if let dueDate = task.dueDate {
                Text("Due Date: \(formattedDate(dueDate))")
            }
        }
        .navigationBarTitle("Task Details", displayMode: .inline)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
