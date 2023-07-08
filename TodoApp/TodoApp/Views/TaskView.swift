//
//  ContentView.swift
//  TodoApp
//
//  Created by Apple on 7/8/23.
//

import SwiftUI

struct TaskView: View {
    
    @StateObject private var todoViewModel = TaskViewModel();
    @State var textController = "";
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            VStack (alignment: .leading){
                NavigationView{
                    List{
                        Section{
                            HStack{
                                Text("Tasks")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(Color(red: 0.34, green: 0.34, blue: 0.4))
                                Spacer()
                            }
                            if todoViewModel.todos.isEmpty{
                                HStack{
                                    Spacer()
                                    Text("No tasks available \(Image(systemName: "list.number"))").font(.headline)
                                    Spacer()
                                }.listRowSeparator(.hidden)
                            }else{
                                ForEach(todoViewModel.todos.indices, id: \.self){
                                    index in
                                    TaskItemView(
                                        isCompleted: $todoViewModel.todos[index].isCompleted,
                                        title: todoViewModel.todos[index].title,
                                        subtitle: formatDate(todoViewModel.todos[index].timeStamp)
                                    )
                                
                                }
                                .onDelete(perform: deleteTodo).onMove(perform: moveItem)
                            }
                            
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle(formatDateShort(Date.now))
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack(alignment: .bottom){
                TextField(text: $textController, prompt: Text("Enter a new task"), axis: .vertical){}
                    .textFieldStyle(.roundedBorder)
                Button("Add Task",action: {
                    todoViewModel.addTask(title: textController)
                    textController = ""
                }).buttonStyle(.borderedProminent)
            }
        }
        .padding(16)
        .edgesIgnoringSafeArea(.top)
    }
    
    
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    
    private func formatDateShort(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    
    func moveItem(from source: IndexSet, to destination: Int) {
        todoViewModel.todos.move(fromOffsets: source, toOffset: destination)
    }
    
    private func deleteTodo(at indexSet: IndexSet) {
        print(indexSet);
        indexSet.forEach { index in
            todoViewModel.removeTask(index: index)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}



