//
//  book.swift
//  Placed
//
//  Created by Daniyal Mohammed on 2021-12-19.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseFirestore

struct Book : Identifiable {
    
    var id: String
    var title : String
    var authors : String
    var desc : String
    var imurl : String
    var url : String
    var pdate: String
    var favourite: Bool
    var userID: String
}

class BookList : ObservableObject{
    
    @Published var books = [Book]()
    //let userID = Auth.auth().currentUser?.uid
    
    func changeFav(obook: Book, changeTo: Bool){
        
        //get a reference to the database
        let db = Firestore.firestore()
        
        db.collection("booklist").document(obook.id).setData(["favourite":changeTo], merge: true) { error in
            
            //check for errors
            if error == nil{
                
                //call and retrieve latest data
                self.getData()
            }
            else{
                //handle error
            }
        }
    }
    
    func moveData(obook: Book, nspot: Book){
        
        //get a reference to the database
        let db = Firestore.firestore()
        
        db.collection("booklist").document(obook.id).setData(["title":nspot.title, "authors":nspot.authors, "desc":nspot.desc, "imurl":nspot.imurl, "url":nspot.url, "pdate":nspot.pdate, "favourite":nspot.favourite], merge: true) { error in
            
            //check for errors
            if error == nil{
                
                //call and retrieve latest data
                self.getData()
            }
            else{
                //handle error
            }
        }
        
        db.collection("booklist").document(nspot.id).setData(["title":obook.title, "authors":obook.authors, "desc":obook.desc, "imurl":obook.imurl, "url":obook.url, "pdate":obook.pdate, "favourite":obook.favourite], merge: true) { error in
            
            //check for errors
            if error == nil{
                
                //call and retrieve latest data
                self.getData()
            }
            else{
                //handle error
            }
        }
            
    }
    
    func deleteData(bookToDelete: Book){
        
        //get a reference to the database
        let db = Firestore.firestore()
        
        //specify document to delete
        db.collection("booklist").document(bookToDelete.id).delete() { error in
            
            //check for errors
            if error == nil{
                
                DispatchQueue.main.async {
                    
                    //remove the book that was deleted
                    self.books.removeAll { book in
                        //check for book to remove
                        return book.id == bookToDelete.id
                    }
                }
                
            }
            else{
                //handle error
            }
        }
            
    }
    
    
    func addData(title: String, authors: String, desc: String, imurl: String, url: String, pdate: String, favourite: Bool, userID: String){
        
        //get a reference to the database
        let db = Firestore.firestore()
        
        //add document to a collection
        db.collection("booklist").addDocument(data: ["title":title, "authors":authors, "desc":desc, "imurl":imurl, "url":url, "pdate":pdate, "favourite":favourite, "userID":userID]) { error in
            
            //check for errors
            if error == nil{
                
                //call and retrieve latest data
                self.getData()
            }
            else{
                //handle error
            }
        }
            
    }
    
    
    func getData() {
        
        //get a reference to the database
        let db = Firestore.firestore()

        //read the documents at a specific path
        db.collection("booklist").whereField("userID", isEqualTo: Auth.auth().currentUser?.uid ?? " ").getDocuments { snapshot, error in
            
            //check for errors
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    
                    //update list property in main thread
                    DispatchQueue.main.async {
                        //get all the documents and create Todos
                        self.books = snapshot.documents.map { d in
                            
                            //create book for each document returned
                            return Book(id: d.documentID,
                                        title: d["title"] as? String ?? "",
                                        authors: d["authors"]  as? String ?? "",
                                        desc: d["desc"] as? String ?? "",
                                        imurl: d["imurl"] as? String ?? "",
                                        url: d["url"] as? String ?? "",
                                        pdate: d["pdate"] as? String ?? "",
                                        favourite: d["favourite"] as? Bool ?? false,
                                        userID: d["userID"] as? String ?? "")
                        }
                    }
                    
                    
                }
            }
            else{
                //handle error
            }
        }
        
    }
}

