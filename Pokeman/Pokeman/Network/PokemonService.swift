//
//  PokemonService.swift
//  Pokeman
//
//  Created by Houman Irani on 8/6/23.
//

import Foundation
import Combine


class PokemonService {
    
    var cancellable = Set<AnyCancellable>()
    private let urlString = "https://pokeapi.co/api/v2/pokemon/?limit=100&offset=0"
    
    func fetchPokemon() -> Future<[PokeDexes], Error> {
        
        return Future { [weak self] promise in
            guard let self = self else { return }
            let finalUrl = self.urlString
            guard let url = URL(string: finalUrl) else { return }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: PokemonResponse.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let err):
                        promise(.failure(err))
                    }
                } receiveValue: { response in
                    promise(.success(response.results))
                }
                .store(in: &self.cancellable)
        }
    }
}
