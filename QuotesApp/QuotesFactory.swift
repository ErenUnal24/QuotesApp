//
//  QuotesFactory.swift
//  QuotesApp
//
//  Created by Eren on 31.05.2024.
//



import Foundation
import FirebaseFirestore


class QuotesFactory: ObservableObject {
    @Published var quotes: [Quote]
    
    init(quotes: [Quote] = []) {
        self.quotes = quotes
        let db = Firestore.firestore()
        db.collection("Quotes").addSnapshotListener {(snap, err) in
            if err != nil {
                print("Error")
                return
            }
            
            self.quotes.removeAll()
            
            let documents = snap!.documents
            let dbID = documents.map { $0["id"] as! String }
            let dbQuoteText = documents.map { $0["quoteText"] as! String }
            let dbLiked = documents.map { $0["liked"] as! Bool }
            
            for i in 0..<dbID.count {
                if let quoteID = UUID(uuidString: dbID[i]) {
                    self.quotes.append(Quote(id: quoteID, quoteText: dbQuoteText[i], liked: dbLiked[i]))
                }
            }
            
            
            /*
            for i in snap!.documentChanges {
          //      let documentID = i.document.documentID
                let dbID = i.document.get("id") as! String
                let dbQuoteText = i.document.get("quoteText") as! String
                let dbLiked = i.document.get("liked") as! Bool
                
                if i.type == .added {
                    print("Added")
                }
                if i.type == .modified {
                    print("Modified")
                }
                if i.type == .removed {
                    print("Removed")
                }
                
                if let quoteID = UUID(uuidString: dbID) {
                    DispatchQueue.main.async {
                        self.quotes.append(Quote(id: quoteID, quoteText: dbQuoteText, liked: dbLiked))
                    }
                }
                
            }
             
             */
            
        }
    }
    
    
    func index(of quote: Quote) -> Int {
        for index in 0..<self.quotes.count {
            if self.quotes[index].id == quote.id {
                return index
            }
        }
        return 0
    }
}

let testFactory = QuotesFactory(quotes: testData)


/*
import Foundation
import Firebase

class QuotesFactory: ObservableObject {
    @Published var quotes: [Quote]
    
    init(quotes: [Quote] = []) {
        self.quotes = quotes
        let db = Firestore.firestore()
        db.collection("Quotes").addSnapshotListener { [weak self] (snap, err) in
            guard let self = self else { return }
            if let err = err {
                print("Error fetching documents: \(err)")
                return
            }
            guard let snap = snap else {
                print("No snapshot found")
                return
            }
            for change in snap.documentChanges {
                let document = change.document
                guard let dbID = document.get("id") as? String,
                      let dbQuoteText = document.get("quoteText") as? String,
                      let dbLiked = document.get("liked") as? Bool,
                      
                      let quoteID = UUID(uuidString: dbID) else {
                    print("Invalid data in document")
                    continue
                }
                
                
                    
                    
                DispatchQueue.main.async {
                    self.quotes.append(Quote(id: quoteID, quoteText: dbQuoteText, liked: dbLiked))
                }
            }
        }
    }
    
    func index(of quote: Quote) -> Int {
        for index in 0..<self.quotes.count {
            if self.quotes[index].id == quote.id {
                return index
            }
        }
        return 0
    }
}

let testFactory = QuotesFactory(quotes: testData)

*/
