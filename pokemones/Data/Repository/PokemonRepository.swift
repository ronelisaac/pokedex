//
//  PokemonRepository.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import Foundation

protocol PokemonRepositoryType {
    func fetchPokemons(limit: Int, offset: Int, search: String?) async throws -> [PokemonListItem]
    func fetchDetail(name: String) async throws -> PokemonDetail
    func fetchSpecies(name: String) async throws -> PokemonSpecies
}

final class PokemonRepository: PokemonRepositoryType {
    private let api: PokeAPIClientType
    
    // Cache en memoria para búsqueda parcial
    private var allPokemons: [PokemonListItem] = []
    private var allLoaded = false

    init(api: PokeAPIClientType = PokeAPIClient()) {
        self.api = api
    }

    func fetchPokemons(limit: Int, offset: Int, search: String?) async throws -> [PokemonListItem] {

        // Normalizamos el texto
        let trimmed = search?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""

        // -----------------------------------------
        // MODO BÚSQUEDA PARCIAL (solo si hay texto)
        // -----------------------------------------
        if !trimmed.isEmpty {
            
            // 1. Cargar TODOS los Pokémon una sola vez
            if !allLoaded {
                let full = try await api.getPokemonList(limit: 2000, offset: 0)
                allPokemons = full.results
                allLoaded = true
            }
            
            // 2. Filtrar búsqueda parcial
            return allPokemons.filter {
                $0.name.localizedCaseInsensitiveContains(trimmed)
            }
        }

        // -----------------------------------------
        // MODO LISTA PAGINADA NORMAL
        // -----------------------------------------
        let response = try await api.getPokemonList(limit: limit, offset: offset)
        return response.results
    }

    func fetchDetail(name: String) async throws -> PokemonDetail {
        try await api.getPokemonDetail(name: name)
    }

    func fetchSpecies(name: String) async throws -> PokemonSpecies {
        try await api.getPokemonSpecies(name: name)
    }
}
