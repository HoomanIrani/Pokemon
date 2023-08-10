//
//  ContentView.swift
//  Pokeman
//
//  Created by Houman Irani on 8/6/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = PokemonViewModel()
    var imageURL = "https://img.pokemondb.net/artwork/large/"
    
    var body: some View {
        NavigationView {
            VStack{
                List(viewModel.myPokemon) { pokemon in
                    HStack {
                        AsyncImage(url: URL(string: imageURL.appending(pokemon.name))) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .cornerRadius(10)
                        } placeholder: {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .cornerRadius(10)
                        }
                        
                        Text(pokemon.name)
                            .font(.system(size: 20))
                            .bold()
                            .foregroundColor(.black)
                            .padding()
                    }
                    .padding(25)
                }
            }
                .navigationTitle("PokeDex")
                .onAppear {
                    viewModel.getPokemon()
            }
        }
     }
 }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
