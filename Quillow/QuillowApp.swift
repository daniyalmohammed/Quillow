//
//  QuillowApp.swift
//  Quillow
//
//  Created by Daniyal Mohammed on 2021-12-27.
//

import SwiftUI
import Firebase

@main
struct QuillowApp: App {
    init() {
      FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            let booklist = BookList()
            Home().environmentObject(booklist)
        }
    }
}
