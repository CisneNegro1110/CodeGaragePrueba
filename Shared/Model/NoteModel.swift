//
//  NoteModel.swift
//  CodeGaragePrueba (iOS)
//
//  Created by Jesús Francisco Leyva Juárez on 20/05/22.
//

import Foundation
struct NoteModel: Codable {
    let id: String
    var isChecked: Bool
    let description: String
    
    init(id: String = UUID().uuidString, isChecked: Bool = false, description: String) {
        self.id = id
        self.isChecked = isChecked
        self.description = description
    }
}

