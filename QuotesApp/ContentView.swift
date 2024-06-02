//
//  ContentView.swift
//  QuotesApp
//
//  Created by Eren on 31.05.2024.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    
    @ObservedObject var quotesFactory: QuotesFactory
    @State var showAdd = false
    @State var quoteTextField: String = ""
    
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(quotesFactory.quotes) { quote in
                        QuoteCell(quote: quote)
                    }
                    .onDelete(perform: { indexSet in
                      //  quotesFactory.quotes.remove(atOffsets: indexSet)
                        let quoteUUID = indexSet.map {
                            quotesFactory.quotes[$0].id
                        }
                        self.deleteQuote(with: quoteUUID[0].uuidString)
                    })
                    .onMove(perform: { indices, newOffset in
                        quotesFactory.quotes.move(fromOffsets: indices, toOffset: newOffset)
                    })
                    
                    Spacer()
                    Text("\(quotesFactory.quotes.count) Quotes")
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .navigationTitle("Quotes")
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button("Add", action: newQuote)
                    }
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        EditButton()
                    }
                    
                }
            }
            if showAdd {
                HStack{
                    TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $quoteTextField)
                    Button("Save Quote", action: saveQuote)
                }
                .padding(.all)
                .frame(height: 100)
            }
        }
    }
    
    
    func newQuote() {
        showAdd = true
    }
    
    func deleteQuote(with id:String) {
        let db = Firestore.firestore()
        db.collection("Quotes").whereField("id", isEqualTo: id).getDocuments {(snap, err) in
            
            if err != nil {
                print("Error")
                return
            }
            
            for i in snap!.documents {
                DispatchQueue.main.async {
                    i.reference.delete()
                }
            }
        }
    }
    
    func saveQuote() {
        let db = Firestore.firestore()
        let id = UUID().uuidString
        db.collection("Quotes").document().setData(["id": id, "quoteText": quoteTextField, "liked": false])
        showAdd = false
    }
    
}





 
struct QuoteCell: View {
    
    var quote: Quote
    
    var body: some View {
        NavigationLink(destination: QutoeDetail(quote: quote)) {
            HStack {
                Image(systemName: quote.liked ? "heart.fill" : "heart")
                    .foregroundStyle(.red)
                    .padding(.all)
                    .font(.title)
                Text(quote.quoteText)
                    .font(.title)
                    .padding(.vertical)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(quotesFactory: testFactory)
    }
}
