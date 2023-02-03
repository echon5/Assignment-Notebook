//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Erin Chon on 1/31/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = Assignment()
    @State private var showingAddItem = false
    @State private var showingSettings = false
    @State var mode: EditMode = .inactive
    var body: some View {
        NavigationView {
            Image("d")
                .resizable()
                .frame(width: 400, height: 800, alignment: .center)
                .overlay(
                    List {
                        ForEach(assignmentList.assignment) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.subject)
                                        .foregroundColor(subjectColor(color: item.subject))
                                        .font(.headline)
                                    Text(item.homework)
                                }
                                Spacer()
                                Text(mode.isEditing ? "" : "\(item.dueDate, style: .date)")
                            }
                        }
                        .onMove(perform: { indices, newOffset in
                            assignmentList.assignment.move(fromOffsets: indices, toOffset: newOffset)
                        })
                        .onDelete(perform: { indexSet in
                            assignmentList.assignment.remove(atOffsets: indexSet)
                        })
                    }
                        .navigationBarTitle("Assignment Notebook", displayMode: .inline)
                    
                        .fullScreenCover(isPresented: $showingAddItem, content: {
                            AddItem(assignments: assignmentList)
                        })
                        .navigationBarItems(
                            leading:
                                EditButton(),
                            trailing:
                                Button(action: {
                                    showingAddItem = true
                                }) {
                                    Image(systemName: "plus.app")
                                        .imageScale(.large)
                                })
                        .environment(\.editMode, $mode)
                )
        }
        .preferredColorScheme(.light)
    }
    
    func subjectColor (color : String) -> Color {
        switch color {
        case "Math":
            return .blue
        case "Chem":
            return .green
        case "English":
            return .purple
        case "Chinese":
            return .orange
        case "History":
            return .yellow
        case "Dance":
            return .gray
        case "Mobile Apps":
            return .red
        default:
            return .black
        }
    }
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        
    }
}

struct AssignmentItem: Identifiable, Codable {
    var id = UUID()
    var subject = String()
    var homework = String()
    var dueDate = Date()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
