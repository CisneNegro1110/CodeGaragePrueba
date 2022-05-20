//
//  NotesViewModel.swift
//  CodeGaragePrueba (iOS)
//
//  Created by Jesús Francisco Leyva Juárez on 20/05/22.
//

import Foundation
import SwiftUI
final class NotesViewModel: ObservableObject {
    @Published var notes: [NoteModel] = []
    
    private let userDefaults: UserDefaults = .standard
    
    init() {
        notes = getAllNotes()
    }
    
    func saveNote(description: String) {
        let newNote = NoteModel(description: description)
        notes.insert(newNote, at: 0)
        encodeAndSaveAllNotes()
    }
    
    private func encodeAndSaveAllNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            userDefaults.set(encoded, forKey: "notes")
        }
    }
    
    func getAllNotes() -> [NoteModel] {
        if let notesData = userDefaults.object(forKey: "notes") as? Data {
            if let notes = try? JSONDecoder().decode([NoteModel].self, from: notesData) {
                return notes
            }
        }
        return []
    }
    func removeNote(id : String) {
        notes.removeAll(where: { $0.id == id })
        encodeAndSaveAllNotes()
    }
    func updateFinished(note: Binding<NoteModel>) {
        note.wrappedValue.isChecked = !note.wrappedValue.isChecked
        encodeAndSaveAllNotes()
    }
}
