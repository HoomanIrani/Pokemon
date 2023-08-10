//
//  PokemonViewModel.swift
//  Pokeman
//
//  Created by Houman Irani on 8/6/23.
//

import Foundation
import Combine

class PokemonViewModel: ObservableObject {
    
    var cancellable = Set<AnyCancellable>()
    let service = PokemonService()
    
    @Published var myPokemon = [PokeDexes]()
    
    func getPokemon() {
        
        service.fetchPokemon()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                }
            } receiveValue: { [weak self] myPokemon in
                self?.myPokemon = myPokemon
            }
            .store(in: &cancellable)
    }
}
