//
//  EventTask.swift
//  DatePlanner
//
//  Created by 석민솔 on 2/1/24.
//

import Foundation

struct EventTask: Identifiable, Hashable {
    var id = UUID()
    var text: String
    var isCompleted = false
    var isNew = false
}
