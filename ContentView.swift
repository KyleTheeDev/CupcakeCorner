//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Kyle Miller on 5/28/21.
//
//

/*
 For a more challenging task, see if you can convert our data model from a class to a struct, then create an ObservableObject class wrapper around it that gets passed around. This will result in your class having one @Published property, which is the data struct inside it, and should make supporting Codable on the struct much easier.
 */



import SwiftUI



struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}















/*
 (How to get mangadex info to app for notifications)
 
 Sending and RECIEVING Codable Data from URLs
 https://www.hackingwithswift.com/books/ios-swiftui/sending-and-receiving-codable-data-with-urlsession-and-swiftui
 
 struct Response: Codable {
     var results: [Result]
 }

 struct Result: Codable {
     var trackId: Int
     var trackName: String
     var collectionName: String
 }

 struct ContentView: View {
     @State var results = [Result]()
     
     var body: some View {
         List(results, id: \.trackId) { item in
             VStack(alignment: .leading) {
                 Text(item.trackName)
                     .font(.headline)
                 
                 Text(item.collectionName)
             }
         }
         .onAppear(perform: loadData)
     }
     
     func loadData() {
         guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
             print("Invalid URL")
             return
         }
         let request = URLRequest(url: url)
         
         URLSession.shared.dataTask(with: request) { data, response, error in
             if let data = data {
                 if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                     DispatchQueue.main.async {
                         self.results = decodedResponse.results
                     }
                     return
                 }
             }
             print("Fetch Failed: \(error?.localizedDescription ?? "Unknown Error")")
         }.resume() // always add .resume()
     }
     
 }
 */




/*
 Validating and disabling forms
 https://www.hackingwithswift.com/books/ios-swiftui/validating-and-disabling-forms
 
 struct ContentView: View {
     @State private var username = ""
     @State private var email = ""
 
 /*
     var disableForm: Bool {
         username.count < 5 || email.count < 5
     }
*/
     var body: some View {
         Form {
             Section {
                 TextField("Username", text: $username)
                 TextField("Email", text: $email)
             }

             Section {
                 Button("Create account") {
                     print("Creating account…")
                 }
             }
             Section {
                 Button("Create account") {
                     print("Creating account…")
                 }
             }
             .disabled(username.isEmpty || email.isEmpty)
             //.disabled(disableForm)



         }
     }
 }
 
 */



/*
 Class conform to Codable
 https://www.hackingwithswift.com/books/ios-swiftui/adding-codable-conformance-for-published-properties
 
 class User: ObservableObject, Codable {
     enum CodingKeys: CodingKey {
         case name
     }
     
     @Published var name = "Kyle Miller"
     
     required init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
         name = try container.decode(String.self, forKey: .name)
     }
     
     func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(name, forKey: .name)
     }
 }

 */
