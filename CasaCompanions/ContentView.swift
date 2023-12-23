// ContentView.swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                ChatView()
            }
            .tabItem {
                Image(systemName: "message")
                Text("Chat")
            }

            NavigationView {
                ExpensesView()
            }
            .tabItem {
                Image(systemName: "dollarsign.circle")
                Text("Expenses")
            }

            NavigationView {
                            TasksView()
                        }
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Tasks")
            }

            NavigationView {
                EventsView()
            }
            .tabItem {
                Image(systemName: "calendar")
                Text("Events")
            }
        }
    }
}
