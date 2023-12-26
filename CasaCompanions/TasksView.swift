// TasksView.swift
import SwiftUI
import Foundation

struct TasksView: View {
    @ObservedObject var tasksViewModel = TasksViewModel()
    @State private var selectedTab: Int = 0
    @State private var showAddTask = false
    @State private var showEditTask = false
    @State private var taskToEdit: Task?

    var body: some View {
        VStack {
            Picker("", selection: $selectedTab) {
                Text("Active").tag(0)
                Text("Completed").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            List {
                // TaskSectionView
                TaskSectionView(tasks: selectedTab == 0 ? tasksViewModel.activeTasks : tasksViewModel.completedTasks,
                                title: selectedTab == 0 ? "Active" : "Completed") { taskAction in
                    switch taskAction {
                        case .edit(let task):
                            print("Editing task: \(task)")
                            taskToEdit = task
                            showEditTask = true
                        case .delete(let task):
                            tasksViewModel.deleteTask(at: IndexSet([tasksViewModel.tasks.firstIndex(of: task)!]))
                        case .complete(let task):
                            tasksViewModel.completeTask(task: task)
                        case .markActive(let task):
                            tasksViewModel.markActive(task: task)
                    }
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
            .listStyle(InsetListStyle()) // Add list style for better appearance

            // Spacer to push the button to the bottom
            Spacer()

            // Plus button fixed at the bottom right corner
            HStack {
                Spacer()
                Button(action: {
                    showAddTask = true
                }) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showAddTask) {
            AddTaskView(tasksViewModel: tasksViewModel, isPresented: $showAddTask)
        }
        .sheet(item: $taskToEdit) { task in
            EditTaskView(tasksViewModel: tasksViewModel, task: task)
        }

    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
