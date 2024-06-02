//
//  QutoeDetail.swift
//  QuotesApp
//
//  Created by Eren on 31.05.2024.
//

import SwiftUI
import FirebaseFirestore

struct QutoeDetail: View {
    
    var quote: Quote
    @ObservedObject var quotesFactory = testFactory

    var body: some View {
        let quoteIdx = quotesFactory.index(of: quote)
        VStack {
            
            Text(quotesFactory.quotes[quoteIdx].quoteText)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Image(systemName: quotesFactory.quotes[quoteIdx].liked ? "heart.fill" : "heart")
                .foregroundColor(.red)
                .padding(.all)
                .onTapGesture {
                    //     quotesFactory.quotes[quoteIdx].liked.toggle()
                    let quoteUUID = quotesFactory.quotes[quoteIdx].id
                    self.updateQuote(with: quoteUUID.uuidString)
                    
                }
        }
        .font(.largeTitle)
    }
    
    func updateQuote(with id:String) {
        let db = Firestore.firestore()
        db.collection("Quotes").whereField("id", isEqualTo: id).getDocuments {(snap, err) in
            
            if err != nil {
                print("Error")
                return
            }
            
            for i in snap!.documents {
                var dbLiked = i.get("liked") as! Bool
                dbLiked = !dbLiked
                DispatchQueue.main.async {
                    i.reference.updateData(["liked":dbLiked])
                }
            }
            
        }
    }
    
}


struct QutoeDetail_Previews: PreviewProvider {
    static var previews: some View {
        QutoeDetail(quote: testFactory.quotes[0])
    }
}
