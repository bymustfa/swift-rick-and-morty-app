//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Mustafa  on 19.07.2022.
//

import SwiftUI


struct CharItemView : View {
    let character: Character
    
    var body: some View {
        
            
            AsyncImage(url: URL(string: character.image)) { image in
              image.resizable()
            } placeholder: {
              Color.black
            }
            .frame(width: 250, height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            
            Text(character.name)
            Text(character.status)
            Text(character.gender)
            Text(character.species)
        
        
        .navigationTitle(character.name)
    }
}



struct ContentView: View {
  @Environment(\.colorScheme) var colorScheme

  @State var characters: [Character] = []
  @State var info = Info(count: 0, pages: 0, next: "", prev: "")

  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
  ]

  var body: some View {
    NavigationView {

      ScrollView {

        LazyVGrid(columns: columns, spacing: 40) {

          ForEach(characters, id: \.id) { character in
              NavigationLink(destination: CharItemView(character:character)) {
                   
                    VStack {

                      AsyncImage(url: URL(string: character.image)) { image in
                        image.resizable()
                      } placeholder: {
                        Color.black
                      }
                      .frame(width: 150, height: 150)
                      .clipShape(RoundedRectangle(cornerRadius: 6))

                      Text(character.name)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                   
              }.contextMenu {
                  Text("Name : \(character.name)")
                  Text("Status : \(character.status)")
                  Text("Gender : \(character.gender)")
                  Text("Species : \(character.species)")
                }
        
          }

        }

      }

      .navigationBarTitle(Text("Rick and Morty"))
    }.onAppear {
      Api().getCharacters() { (characters) in
        self.characters = characters
      }
    }

  }

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
