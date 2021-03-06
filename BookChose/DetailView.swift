//
//  DetailView.swift
//  BookChose
//
//  Created by PATRICIA S SIQUEIRA on 01/03/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let book: Book
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(getGenre())
                        .frame(maxWidth: geometry.size.width)

                    Text(getGenre().uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.formatedDate())
                    .foregroundColor(.secondary)

                Text(self.book.review ?? "No review")
                    .padding()

                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                Spacer()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
    }
    
    func formatedDate() -> String {
        if let launchDate = book.date {
                let formatter = DateFormatter()
                formatter.dateStyle = .long
                return formatter.string(from: launchDate)
        }
        return "N/A"
    }
    
    func getGenre() -> String {
        if let genre = self.book.genre {
            switch genre {
            case "":
                return "Fantasy"
            default:
                return genre
            }
        }
        return "Fantasy"
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."

        return NavigationView {
            DetailView(book: book)
        }
    }
}
