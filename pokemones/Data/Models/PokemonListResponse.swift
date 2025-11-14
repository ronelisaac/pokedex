//
//  PokemonListResponse.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable, Identifiable {
    let name: String
    let url: String
    var id: String { name }
}
