//
//  PokemonSpecies.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import Foundation

struct PokemonSpecies: Codable {
    let flavor_text_entries: [FlavorText]
    struct FlavorText: Codable {
        let flavor_text: String
        let language: Language
       // struct Language: Codable { let name: String }
    }
}

struct Language: Codable {
    let name: String
}
