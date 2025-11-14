//
//  PokemonDetail.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import Foundation

struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    let types: [PokemonTypeEntry]

    struct Sprites: Codable {
        let front_default: String?
        let back_default: String?
        let front_shiny: String?
        let back_shiny: String?
    }
    
    struct PokemonTypeEntry: Codable {
        let slot: Int
        let type: PokemonTypeInfo
    }

    struct PokemonTypeInfo: Codable {
        let name: String
        let url: String
    }
}
