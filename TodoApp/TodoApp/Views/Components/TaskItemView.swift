//
//  TaskItemView.swift
//  TodoApp
//
//  Created by Apple on 7/8/23.
//

import Foundation
import SwiftUI

struct TaskItemView: View {
    @Binding var isCompleted: Bool
    var title: String
    var subtitle: String?
    
    var body: some View {
        Toggle( isOn: $isCompleted){
            VStack(alignment: .leading){
                Text(title)
                    .fontWeight(.medium)
                if subtitle != nil {
                    Spacer().frame(height: 4)
                    Text(subtitle!)
                        .font(.caption)
                        .foregroundColor(Color.gray).bold()
                    
                }
            }
        }.toggleStyle(CheckboxStyle())
    }
}


struct CheckboxStyle: ToggleStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        return HStack(alignment: .top) {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .font(.system(size: 20, weight: .regular, design: .default))
            configuration.label.strikethrough(configuration.isOn)
            Spacer()
        }
        .listRowSeparator(.hidden)
        .onTapGesture { configuration.isOn.toggle() }
        
    }
}
