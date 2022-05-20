//
//  ContentView.swift
//  Shared
//
//  Created by Jesús Francisco Leyva Juárez on 20/05/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var descriptionNote: String = ""
    @StateObject var notesViewModel = NotesViewModel()
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Agregar nuevo elemento a la lista", text: $descriptionNote)
                        .textFieldStyle(.roundedBorder)
                    Button("Crear") {
                        notesViewModel.saveNote(description: descriptionNote)
                        descriptionNote = ""
                    }
                    .buttonStyle(.bordered)
                    .tint(.green)
                }.padding()
                List {
                    ForEach($notesViewModel.notes, id: \.id) { $note in
                        HStack {
                            Text(note.description)
                            Spacer()
                            Button(action: {
                                notesViewModel.updateFinished(note: $note)
                            }, label: {
                                Image(systemName: note.isChecked ? "checkmark.circle.fill" : "checkmark.circle")
                            })
                            .foregroundColor(.green)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(action: {
                                notesViewModel.removeNote(id: note.id)
                            }, label: {
                               Label("Borrar", systemImage: "trash.fill")
                            })
                            .tint(.red)
                        }
                    }
                }
            }
            .navigationTitle("Lista del super")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



