//
//  Model.swift
//  Pokeman
//
//  Created by Houman Irani on 8/6/23.
//

import Foundation


struct PokemonResponse: Decodable, Hashable {

    let results: [PokeDexes]
}

struct PokeDexes: Decodable, Hashable, Identifiable {
    
    let id = UUID()
    let name: String
    let url: String
}

