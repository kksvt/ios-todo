//
//  ContentView.swift
//  ios-todo
//
//  Created by user279407 on 11/22/25.
//

import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID();
    var title: String;
    var message: String;
    var imageName: String;
    var completed: Bool;
};

struct ContentView: View {
    @State private var TodoList: [TodoItem] = [
        TodoItem(title: "Garbage", message: "Take out the garbage", imageName: "trash", completed: false),
        TodoItem(title: "Dog", message: "Walk the dog", imageName: "dog", completed: false),
        TodoItem(title: "Groceries", message: "Buy vegetables and milk", imageName: "bag", completed: false),
        TodoItem(title: "Hw", message: "Do your homework", imageName: "folder", completed: false)
    ];
    
    func deleteItem(offsets: IndexSet) {
        TodoList.remove(atOffsets: offsets);
    }
    
    var body: some View {
            NavigationStack {
                List {
                    ForEach($TodoList) { $item in
                        HStack {
                            Image(systemName: item.imageName);

                            VStack(alignment: .leading) {
                                Text(item.title)
                                Text(item.message)
                                    .font(.caption)
                                    .foregroundColor(.gray);
                            }

                            Spacer();

                            Toggle("", isOn: $item.completed)
                                .labelsHidden();

                            NavigationLink {
                                DetailView(item: $item);
                            } label: {
                                EmptyView();
                            }
                            .frame(width: 0)
                            .opacity(0);
                        }
                    }
                    .onDelete(perform: deleteItem)
                }
                .navigationTitle("Todos")
            }
        }
}

struct DetailView: View {
    @Binding var item: TodoItem

    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Image(systemName: item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40);
                        Text(item.title)
                            .font(.largeTitle)
                            .fontWeight(.bold);
                    }
                }
                
                Section("Task Description") {
                    TextEditor(text: $item.message);
                }
                
                Section {
                    Toggle("Completed", isOn: $item.completed)
                }
            }
            .navigationTitle("Edit Task")
        }
    }
}

#Preview {
    ContentView()
}
