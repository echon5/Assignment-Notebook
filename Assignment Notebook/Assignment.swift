//
//  Assignment.swift
//  Assignment Notebook
//
//  Created by Erin Chon on 1/31/23.
//

import Foundation

class Assignment: ObservableObject {
    @Published var assignment : [AssignmentItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(assignment) {
                UserDefaults.standard.set(encoded, forKey: "Cake")
            }
        }
    }
    init() {
        if let assignment = UserDefaults.standard.data(forKey: "Cake") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([AssignmentItem].self, from: assignment) {
                self.assignment = decoded
                return
            }
        }
        assignment = []
    }
}
