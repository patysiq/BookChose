//
//  AddNewBook.swift
//  BookChose
//
//  Created by PATRICIA S SIQUEIRA on 26/02/21.
//

import SwiftUI
import CoreData

struct AddNewBook: View {
    
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.presentationMode) var presentationMode

    @State private var showingAddScreen = false
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }

                Section {
                    Button("Save") {
                        addItem()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Book")
        }
    }

    private func addItem() {
        withAnimation {
            let newBook = Book(context: self.moc)
            newBook.id = UUID()
            newBook.title = self.title
            newBook.author = self.author
            newBook.rating = Int16(self.rating)
            newBook.genre = self.genre
            newBook.review = self.review
            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddNewBook_Previews: PreviewProvider {
static var previews: some View {
    AddNewBook()
}
}
