//
//  TodoViewModel.swift
//  TodoApp
//
//  Created by Apple on 7/8/23.
//

import Foundation
import SwiftUI

final class TaskViewModel : ObservableObject{
    
    
    @Published var todos: [Task] = []
    
    struct Task : Identifiable{
        var id = UUID();
        var title : String;
        var timeStamp : Date = Date.now;
        var isCompleted: Bool = false;
    }
    
    
    func addTask(title: String) -> Void {
        if title.isEmpty{
            return;
        }
        todos.append(Task(title: title));
    }
    
    func removeTask(index: Int) -> Void {
        todos.remove(at: index)
    }
    
    var incompleteTodos: [Task] {
        return todos.filter { !$0.isCompleted }
    }
    
    var completedTodos: [Task] {
        return todos.filter { $0.isCompleted }
    }
}
