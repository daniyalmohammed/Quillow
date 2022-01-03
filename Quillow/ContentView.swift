//
//  ContentView.swift
//  Quillow
//
//  Created by Daniyal Mohammed on 2021-12-27.
//

import SwiftUI
import FirebaseAuth
import SwiftyJSON
import SDWebImageSwiftUI
import Combine
import Firebase


struct ContentView_Previews: PreviewProvider {
    static let bookList = BookList()
    static var previews: some View {
        Group {
            Home().environmentObject(bookList).navigationViewStyle(StackNavigationViewStyle()).colorScheme(.dark)
        }
    }
}


struct Home : View {
    
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View{
    
        NavigationView{
            
            VStack{
                if self.status{
                    
                    Homescreen()
                    
                }
                else{
                    ZStack{
                        
                        NavigationLink (destination: SignUp(show: self.$show), isActive: self.$show)
                            {
                                Text("")
                            }.hidden()
                            
                        
                        Login(show: self.$show)
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true).navigationBarBackButtonHidden(true)
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Homescreen : View {
    
    @ObservedObject var bookList = BookList()
    @State var showHome = true
    @State var noshowFavourites = true
    @State var showMyBookView = false
    let userIDD = Auth.auth().currentUser?.uid
    @State var bookie = (Book (id: "", title: "", authors: "", desc: "", imurl: "", url: "", pdate: "", favourite: true, userID: ""))
    var body: some View{
        
        if self.showHome && noshowFavourites
        {
        NavigationView{
             VStack
            {
                Text("").navigationTitle("Your Book List")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading){
                    Button(action: {
                        
                        try! Auth.auth().signOut()
                        UserDefaults.standard.set(false, forKey: "status")
                        NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    })
                    {
                        Image(systemName: "chevron.left").foregroundColor(Color("Color")).font(Font.title)
                    }
                }
                    ToolbarItemGroup(placement: .navigationBarLeading){
                        EditButton().foregroundColor(Color("Color")).font(Font.title2)
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button(action: {
                            
                            self.noshowFavourites.toggle()
                        })
                        {
                            Image(systemName: "star").foregroundColor(Color("Color")).font(Font.title)
                        }
                    }
                    
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button(action: {
                            
                            self.showHome.toggle()
                        })
                        {
                            Image(systemName: "plus.circle").foregroundColor(Color("Color")).font(Font.title)
                        }
                    }
                    
                    
                    
                }
                List {
                    
                    
                    ForEach(bookList.books, id: \.id)  {book in
                    
                    Button(action: {
                        self.bookie = (Book (id: book.id, title: book.title, authors: book.authors, desc: book.desc, imurl: book.imurl, url: book.url, pdate: book.pdate, favourite: book.favourite, userID: book.userID))
                        self.showMyBookView.toggle()
                        self.showHome.toggle()
                    })
                    {
                        HStack
                        {
                        if book.imurl != ""
                        {
                            WebImage(url: URL(string: book.imurl)!).resizable().frame(width: 120, height: 170).cornerRadius(10)
                        }
                        
                            else{
                            
                                Image("books").resizable().frame(width: 120, height: 170).cornerRadius(10)
                                
                            }
                            
                            if book.favourite
                            {
                                VStack(alignment: .leading, spacing: 10){
                                    HStack{
                                
                                    Text(book.title).fontWeight(.bold).lineLimit(3).multilineTextAlignment(.leading).foregroundColor(.primary)
                                        
                                        Spacer()
                                        
                                    Image(systemName: "star.fill").foregroundColor(.yellow).font(Font.title3)
                                        
                                    }
                                    
                                    Text(book.authors).foregroundColor(.primary)
                                    
                                    Text(book.desc).font(.caption).lineLimit(4).multilineTextAlignment(.leading).foregroundColor(.primary)
                                    
                                }
                            }
                            
                                else{
                                
                                    VStack(alignment: .leading, spacing: 10){
                                        
                                        Text(book.title).fontWeight(.bold).lineLimit(3).multilineTextAlignment(.leading).foregroundColor(.primary)
                                        
                                        Text(book.authors).foregroundColor(.primary)
                                        
                                        Text(book.desc).font(.caption).lineLimit(4).multilineTextAlignment(.leading).foregroundColor(.primary)
                                        
                                    }
                                    
                                }
                        }
                    }
                    }.onDelete(perform: removeItems).onMove(perform: Move)
                      }
                    
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        }
        else if self.showHome{
            NavigationView{
                 VStack
                {
                    Text("").navigationTitle("Your Book List")
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarLeading ){
                        Button(action: {
                            
                            try! Auth.auth().signOut()
                            UserDefaults.standard.set(false, forKey: "status")
                            NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                        })
                        {
                            Image(systemName: "chevron.left").foregroundColor(Color("Color")).font(Font.title)
                        }
                    }
                        ToolbarItemGroup(placement: .navigationBarLeading){
                            EditButton().foregroundColor(Color("Color")).font(Font.title2)
                        }
                        
                        ToolbarItemGroup(placement: .navigationBarTrailing){
                            Button(action: {
                                
                                self.noshowFavourites.toggle()
                            })
                            {
                                Image(systemName: "star.fill").foregroundColor(Color("Color")).font(Font.title)
                            }
                        }
                        
                        ToolbarItemGroup(placement: .navigationBarTrailing){
                            Button(action: {
                                
                                self.showHome.toggle()
                            })
                            {
                                Image(systemName: "plus.circle").foregroundColor(Color("Color")).font(Font.title)
                            }
                        }
                        
                        
                        
                    }
                    List {
                        
                        ForEach(bookList.books, id: \.id)  {book in
                        
                            if book.favourite{
                        Button(action: {
                            self.bookie = (Book (id: book.id, title: book.title, authors: book.authors, desc: book.desc, imurl: book.imurl, url: book.url, pdate: book.pdate, favourite: book.favourite, userID: book.userID))
                            self.showMyBookView.toggle()
                            self.showHome.toggle()
                        })
                        {
                            
                            HStack
                            {
                    
                            if book.imurl != ""
                            {
                                WebImage(url: URL(string: book.imurl)!).resizable().frame(width: 120, height: 170).cornerRadius(10)
                            }
                            
                                else{
                                
                                    Image("books").resizable().frame(width: 120, height: 170).cornerRadius(10)
                                    
                                }
                                
                    
                                    VStack(alignment: .leading, spacing: 10){
                                        HStack{
                                    
                                            Text(book.title).fontWeight(.bold).lineLimit(3).multilineTextAlignment(.leading).foregroundColor(.primary)
                                            
                                            Spacer()
                                            
                                        Image(systemName: "star.fill").foregroundColor(.yellow).font(Font.title3)
                                            
                                        }
                                        
                                        Text(book.authors).foregroundColor(.primary)
                                        
                                        Text(book.desc).font(.caption).lineLimit(4).multilineTextAlignment(.leading).foregroundColor(.primary)
                                        
                                    }
                                        
                                    }
                            
                        }
                        }
                        }.onDelete(perform: removeItems)
                            .onMove(perform: Move)
                    }
                        
                  
                    
                }
            }.navigationViewStyle(StackNavigationViewStyle())
            }
        else if showMyBookView{
            MyBookView(book: bookie)
        }
        else{
            AddScreen()
        }
    }
    
    init(){
        bookList.getData()
    }
    
    func Move(at IndexSet: IndexSet, newOffset: Int) {
        
        IndexSet.forEach { index in
            
            if newOffset > index{
                let book1 = self.bookList.books[(newOffset - 1)]
                let book2 = self.bookList.books[index]
                bookList.moveData(obook: book1, nspot: book2)
            }
            
            else if newOffset == index{
                let book1 = self.bookList.books[newOffset]
                let book2 = self.bookList.books[index]
                bookList.moveData(obook: book1, nspot: book2)
            }
            else if newOffset == bookList.books.count{
                let book1 = self.bookList.books[(newOffset + 1)]
                let book2 = self.bookList.books[index]
                bookList.moveData(obook: book1, nspot: book2)
            }
            
            else {
                let book1 = self.bookList.books[newOffset]
                let book2 = self.bookList.books[index]
                bookList.moveData(obook: book1, nspot: book2)
            }
        }
   
        
        
    }
    
    func removeItems(at IndexSet: IndexSet) {
        
        IndexSet.forEach { index in
            
            let bookToDelete = self.bookList.books[index]
            
            bookList.deleteData(bookToDelete: bookToDelete)
        }

    }
}


struct MyBookView: View {
    
    var book: Book
    @State var showMyBookView = true
    @EnvironmentObject var bookList: BookList
    let userIDD = Auth.auth().currentUser?.uid

    
    var body: some View{
        
        if self.showMyBookView
        {
            NavigationView{
                 
                ScrollView{
        
        VStack(spacing: 10){
            
            if book.imurl != ""
            {
                
                WebImage(url: URL(string: book.imurl)!).resizable().frame(width: 210, height: 297.5).cornerRadius(12)
            }
            
                else{
                    
                    Image("books").resizable().frame(width: 210, height: 297.5).cornerRadius(12)
                    
                }
            VStack{
        Text(book.title).font(.title).fontWeight(.semibold).lineLimit(3).multilineTextAlignment(.center).padding(.horizontal)
        
                HStack{
                    if book.authors == ""
                    {
                        Text(book.pdate).font(.subheadline).foregroundColor(.secondary)
                    }
                    else
                    {
                    Text(book.authors + "  -").font(.subheadline)
                        Text(book.pdate).font(.subheadline)
                    }
                }
                
        Button(action: {
            var isfavourite = book.favourite
            isfavourite.toggle()
            
            bookList.changeFav(obook: book, changeTo: isfavourite)
            self.showMyBookView.toggle()
            
        })
        {
            if book.favourite{
                Text("Remove from Favourites").bold().font(.title2).frame(width: 280, height: 50).background(Color("Color")).foregroundColor(.white).cornerRadius(15).padding(10)
            }
            else {
                Text("Add to Favourites").bold().font(.title2).frame(width: 280, height: 50).background(Color("Color")).foregroundColor(.white).cornerRadius(15).padding(10)
            }
        }
            }
            
            Text(book.desc).font(.body).padding().lineLimit(nil)
        }
            
        }.toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading){
            Button(action: {
                
                self.showMyBookView.toggle()
            })
            {
                Image(systemName: "chevron.left").foregroundColor(Color("Color")).font(Font.title)
            }
        }
        }
        }.navigationViewStyle(StackNavigationViewStyle())
        }
        else{
            Homescreen()
        }
    }
}


struct AddScreen : View {
    
    @State var showAddScreen = true
    @State var color = Color.black.opacity(0.7)
    @State var search = ""
    @State private var url = ""
    @State var showSearchView = false
        
    var body: some View{
        
        if self.showAddScreen
        
        {

        NavigationView{
             VStack
            {
                Text("Search For A Book").fontWeight(.bold).font(.title)
                Text("If a crash occurs, please try another query.").fontWeight(.light).font(.caption)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading ){
                    Button(action: {
                        
                        self.showAddScreen.toggle()
                    })
                    {
                        Image(systemName: "chevron.left").foregroundColor(Color("Color")).font(Font.title)
                    }
                }
                    
                }
                
                
                TextField("Search", text: self.$search).autocapitalization(.none)
                    .padding().background(RoundedRectangle(cornerRadius: 4).stroke(self.search != "" ? Color("Color") : self.color,lineWidth:2)).padding(.top, 25)
                    
                    Button (action: {
                        if search == "" || search == " "
                              {
                            self.showSearchView.toggle()
                              }
                        else{
                        fetchBooks(query: search)
                        }
                        func fetchBooks(query: String){
                            
                            self.url = "https://www.googleapis.com/books/v1/volumes?q=\(query)"
                            self.url = url.replacingOccurrences(of: " ", with: "+")
                        }
                        self.showSearchView.toggle()
                        self.showAddScreen.toggle()
                    }){
                        Text("Search").fontWeight(.bold).foregroundColor(Color ("Color")).padding(.vertical).frame(width: UIScreen.main.bounds.width - 50)
                    
                }
                Spacer()
            }
            
        }.padding().navigationViewStyle(StackNavigationViewStyle())
        }
        else if showSearchView{
            SearchView(url: $url, Books: getData(url: url))
        }
        
        else {
            Homescreen()
        }
        
    }
}

struct SearchView : View {
    
    @State var showSearchView = true
    @State var color = Color.black.opacity(0.7)
    @Binding var url: String
    @StateObject var Books: getData
    @State var showBookDetailView = false
    let userIDD = Auth.auth().currentUser?.uid
    @State var i = (Book (id: "", title: "", authors: "", desc: "", imurl: "", url: "", pdate: "", favourite: false, userID: ""))

    
    var body: some View{
        

        if self.showSearchView
        {
            NavigationView{
        
                List(Books.data) {i in
                    
                    Button(action: {
                        self.i = (Book (id: i.id, title: i.title, authors: i.authors, desc: i.desc, imurl: i.imurl, url: i.url, pdate: i.pdate, favourite: i.favourite, userID: i.userID))
                        self.showBookDetailView.toggle()
                        self.showSearchView.toggle()
                        
                    })
                    {
                        HStack
                        {
                        if i.imurl != ""
                        {
                            WebImage(url: URL(string: i.imurl)!).resizable().frame(width: 120, height: 170).cornerRadius(10)
                        }
                        
                            else{
                            
                                Image("books").resizable().frame(width: 120, height: 170).cornerRadius(10)
                                
                            }
                            VStack(alignment: .leading, spacing: 10){
                                
                                Text(i.title).fontWeight(.bold).lineLimit(3).multilineTextAlignment(.leading).foregroundColor(.primary)
                                
                                Text(i.authors).foregroundColor(.primary)
                                
                                Text(i.desc).font(.caption).lineLimit(4).multilineTextAlignment(.leading).foregroundColor(.primary)
 
                            }
                            }
                    }
                    
                    
                    }
.toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading){
                    Button(action: {
                        
                        self.showSearchView.toggle()
                    })
                    {
                        Image(systemName: "chevron.left").foregroundColor(Color("Color")).font(Font.title)
                    }
                }
                }.navigationTitle("Book Search Results")
                
            }.navigationViewStyle(StackNavigationViewStyle())
        }
        else if showBookDetailView{
            BookDetailView(book: i)
        }
        else{
            AddScreen()
        }
    }
}


struct BookDetailView: View {
    
    var book: Book
    @State var showBookDetailView = true
    @ObservedObject var bookList = BookList()
    let userIDD = Auth.auth().currentUser?.uid
    
    var body: some View{
        
        if self.showBookDetailView
        {
            
            NavigationView{
                 
                ScrollView{
        
        VStack(spacing: 10){
            
            if book.imurl != ""
            {
                WebImage(url: URL(string: book.imurl)!).resizable().frame(width: 210, height: 297.5).cornerRadius(12)
            }
            
                else{
                
                    Image("books").resizable().frame(width: 210, height: 297.5).cornerRadius(12)
                    
                }
            VStack{
        Text(book.title).font(.title).fontWeight(.semibold).lineLimit(3).multilineTextAlignment(.center).padding(.horizontal)
        
                HStack{
                    if book.authors == ""
                    {
                        Text(book.pdate).font(.subheadline).foregroundColor(.secondary)
                    }
                    else
                    {
                    Text(book.authors + "  -").font(.subheadline)
                        Text(book.pdate).font(.subheadline)
                    }
                }
                
        Button(action: {
            bookList.addData(title: book.title, authors: book.authors, desc: book.desc, imurl: book.imurl, url: book.url, pdate: book.pdate, favourite: false, userID: book.userID)
            self.showBookDetailView.toggle()
            
        })
        {
            Text("Add to Book List").bold().font(.title2).frame(width: 280, height: 50).background(Color("Color")).foregroundColor(.white).cornerRadius(15).padding(10)
        }
            }
            
            Text(book.desc).font(.body).padding().lineLimit(nil)
        }
            
        }.toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading){
            Button(action: {
                
                self.showBookDetailView.toggle()
            })
            {
                Image(systemName: "chevron.left").foregroundColor(Color("Color")).font(Font.title)
            }
        }
        }
        }.navigationViewStyle(StackNavigationViewStyle())
        }
        else{
            Homescreen()
        }
    }
}



class getData : ObservableObject{
    
    @Published var data = [Book]()
    let url: String
    
    init(url: String) {
        self.url = url
        
        let session = URLSession(configuration: .default)
    
        session.dataTask(with: URL(string: url)!) {(data, _, err)
            in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }

            let json = try! JSON(data: data!)
            let userIDD = Auth.auth().currentUser?.uid
            let items = json["items"].array!
            
            for i in items{
                
                let title = i["volumeInfo"]["title"].stringValue
                let authors = i["volumeInfo"]["authors"].array
                let description = i["volumeInfo"]["description"].stringValue
                let imurl = i["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                let urll = i["volumeInfo"]["previewLink"].stringValue
                let date = i["volumeInfo"]["publishedDate"].stringValue
                
                let author = authors?[0].stringValue
            
                DispatchQueue.main.async { [self] in
                    
                    self.data.append(Book (id: UUID().uuidString, title: title, authors: author ?? "", desc: description, imurl: imurl, url: urll, pdate: date, favourite: false, userID: userIDD ?? ""))
                }
                
            }
        }.resume()
    }
}
 


struct Login : View  {
    
    @State var color = Color.black.opacity(0.7)
    @State var  email = ""
    @State var pass = ""
    @State var visible = false
    @Binding var show: Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View{
        
        ZStack{
            ZStack(alignment: .topTrailing){
                GeometryReader{_ in
                    
                    VStack{
                        Image("logoapp").resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(18.0).padding(.top, 40)
                            
                               
                        Text("Log in to Quillow").font(.title).fontWeight(.bold).padding(.top, 35)
                        
                        TextField("Email", text: self.$email).autocapitalization(.none)
                            .padding().background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color,lineWidth:2)).padding(.top, 25)
                        
                        HStack(spacing: 15){
                            VStack
                            {
                            if self.visible{
                                TextField("Password", text: self.$pass).autocapitalization(.none)
                            }
                            else{
                                SecureField("Password", text: self.$pass).autocapitalization(.none)
                            }
                            }
                            Button(action: {
                                
                                
                                self.visible.toggle()
                            }) {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill").foregroundColor(self.color)
                            }
                            }.padding().background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Color") : self.color,lineWidth:2)).padding(.top, 25)
                        HStack{
                            Spacer()
                            
                            Button (action: {
                                self.reset()
                            }){
                                Text("Forget Password").fontWeight(.bold)
                                    .foregroundColor(Color("Color"))
                            }
                        }
                        .padding(.top, 20)
                        
                        Button(action: {
                            
                            self.verify()
                        })
                        {
                            Text("Log in").fontWeight(.bold).foregroundColor(.white).padding(.vertical).frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Color")).cornerRadius(10).padding(.top, 25)
                        
                    }
                    .padding(.horizontal, 25)
                }
                
                Button(action: {
                    self.show.toggle()})
                {
                    
                    Text("Register").fontWeight(.bold).foregroundColor(Color("Color")).padding(.horizontal, 30)
                }
                
            }
            
            if self.alert{
                
                ErrorView(alert: self.$alert, error: self.$error)
                
            }
        }
    }
    func verify(){
        if self.email != "" && self.pass != ""{
            
            Auth.auth().signIn(withEmail: self.email, password: self.pass) { (res, err) in
                
                if err != nil {
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
            
    }
        else{
            self.error = "Please fill all the contents correctly"
            self.alert.toggle()
        }
    }
    func reset(){
        
        if self.email != "" {
            
            Auth.auth().sendPasswordReset(withEmail: self.email)  { (err) in
                
                if err != nil{
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                self.error = "RESET"
                self.alert.toggle()
            }
        }
        else{
            self.error = "Email ID is empty"
            self.alert.toggle()
        }
}
}

struct SignUp : View  {
    
    @State var color = Color.black.opacity(0.7)
    @State var  email = ""
    @State  var repass = ""
    @State var pass = ""
    @State var visible = false
    @State var revisible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View{
        
        ZStack{
            ZStack(alignment: .topLeading){
                GeometryReader{_ in
                    
                    VStack{
                        Image("logoapp").resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(18.0).padding(.top, 40)
                            
                            
                            
                        
                        Text("Register to Quillow").font(.title).fontWeight(.bold).padding(.top, 35)
                        
                        TextField("Email", text: self.$email).autocapitalization(.none)
                            .padding().background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color,lineWidth:2)).padding(.top, 25)
                        
                        HStack(spacing: 15){
                            VStack
                            {
                            if self.visible{
                                TextField("Password", text: self.$pass).autocapitalization(.none)
                            }
                            else{
                                SecureField("Password", text: self.$pass).autocapitalization(.none)
                            }
                            }
                            Button(action: {
                                
                                
                                self.visible.toggle()
                            }) {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill").foregroundColor(self.color)
                            }
                            }.padding().background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("Color") : self.color,lineWidth:2)).padding(.top, 25)
                        
                        HStack(spacing: 15){
                            VStack
                            {
                            if self.revisible{
                                TextField("Re-enter", text: self.$repass).autocapitalization(.none)
                            }
                            else{
                                SecureField("Re-enter Password", text: self.$repass).autocapitalization(.none)
                            }
                            }
                            Button(action: {
                                
                                
                                self.revisible.toggle()
                            }) {
                                Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill").foregroundColor(self.color)
                            }
                            }.padding().background(RoundedRectangle(cornerRadius: 4).stroke(self.repass != "" ? Color("Color") : self.color,lineWidth:2)).padding(.top, 25)

                        
                        Button(action: {
                            
                            self.register()
                        })
                        {
                            Text("Register").fontWeight(.bold).foregroundColor(.white).padding(.vertical).frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Color")).cornerRadius(10).padding(.top, 25)
                        
                    }
                    .padding(.horizontal, 25)
                }
                
                
                
                Button(action: {
                    self.show.toggle()})
                {
                    
                    Image(systemName: "chevron.left").font(.title).foregroundColor(Color("Color")).padding(.horizontal, 30)
                }
                
            }
            if self.alert{
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
            .navigationBarHidden(true).navigationBarBackButtonHidden(true)
    }
    
    func register(){
        
        if self.email != ""{
            
            if self.pass == self.repass{
                
                Auth.auth().createUser(withEmail: self.email, password: self.pass) {(res, err) in
                    
                    if err != nil{
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    print("Success")
                    
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name:NSNotification.Name("status"), object: nil)
                }
                
            }
            else{
                
                self.error = "Passwords do not match"
                self.alert.toggle()
            }
        }
        else{
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
    
}

struct ErrorView : View {
    
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert : Bool
    @Binding var error: String
    
    var body: some View{
        
        GeometryReader{_ in
            
            VStack{
                
                HStack{
                    
                    Text(self.error == "RESET" ? "Message" : "Error").font(.title).fontWeight(.bold).foregroundColor(self.color)
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
                
                Text(self.error == "RESET" ? "Password reset link has been sent" : self.error)
                    .foregroundColor(self.color).padding(.top).padding(.horizontal, 25)
                
                Button(action: {
                    
                    self.alert.toggle()
                    
                })
                
                {
                    Text(self.error == "RESET" ? "Ok" :"Cancel").foregroundColor(.white).padding(.vertical).frame(width: UIScreen.main.bounds.width - 120)
                }
                
                .background(Color("Color")).cornerRadius(10).padding(.top, 15)
            }.padding(.vertical, 25)
                .frame(width: UIScreen.main.bounds.width - 70, alignment: .center)
                .background(Color.white).cornerRadius(15).position(x: 195, y: 360)
        }
        
        .background(Color.black.opacity (0.35).edgesIgnoringSafeArea(.all))
    }
}

