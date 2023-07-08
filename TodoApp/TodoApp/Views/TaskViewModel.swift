//
//  TodoViewModel.swift
//  TodoApp
//
//  Created by Apple on 7/8/23.
//

import Foundation
import SwiftUI

final class TaskViewModel : ObservableObject{
    
    
    @Published var todos: [Todo] = []
    
    struct Todo : Identifiable{
        var id = UUID();
        var title : String;
        var timeStamp : Date = Date.now;
        var isCompleted: Bool = false;
    }
    
    
    func addTask(title: String) -> Void {
        if title.isEmpty{
            return;
        }
        todos.append(Todo(title: title));
    }
    
    func removeTask(index: Int) -> Void {
        todos.remove(at: index)
    }
    
    var incompleteTodos: [Todo] {
        return todos.filter { !$0.isCompleted }
    }
    
    var completedTodos: [Todo] {
        return todos.filter { $0.isCompleted }
    }
}
