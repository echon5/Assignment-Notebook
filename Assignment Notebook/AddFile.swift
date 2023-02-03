//
//  AddFile.swift
//  Assignment Notebook
//
//  Created by Erin Chon on 1/31/23.
//

import SwiftUI

struct AddItem: View {
    @ObservedObject var assignments: Assignment
    @State private var subject = ""
    @State private var homework = ""
    @State private var dueDate = Date()
    @Environment(\.presentationMode) var presentationMode
    static let subjects = ["Math", "Chem", "English", "Chinese", "History", "Woodworking" , "Dance"]
    var body: some View {
        NavigationView {
            Form {
                Picker("Subject", selection: $subject) {
                    ForEach(Self.subjects, id: \.self) { subject in
                        Text(subject)
                            .foregroundColor(subjectColor(color: subject))
                    }
                }
                TextField("Homework", text: $homework)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("Add New Assignment", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "x.square")
                        .imageScale(.large)
                },
                trailing: Button("Save"){
                    let item = AssignmentItem(id: UUID(), subject: subject, homework: homework, dueDate: dueDate)
                    assignments.assignment.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
                    .disabled(!(subject.count > 0 && homework.count > 0)))
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
            }
        }
        .preferredColorScheme(.light)
    }
    
    func subjectColor (color : String) -> Color {
        switch color {
        case "Math":
            return .red
        case "Science":
            return .green
        case "English":
            return .blue
        case "World Language":
            return .pink
        case "History":
            return .orange
        case "Woodworking":
            return .brown
        case "Mobile Apps":
            return .purple
        default:
            return .black
        }
    }
    
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem(assignments: Assignment())
    }
}
