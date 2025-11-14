//
//  FetchPokemonsUseCase.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import Foundation

protocol FetchPokemonsUseCaseType {
    func execute(limit: Int, offset: Int, search: String?) async throws -> [PokemonListItem]
}

final class FetchPokemonsUseCase: FetchPokemonsUseCaseType {
    private let repository: PokemonRepositoryType
    
    init(repository: PokemonRepositoryType) {
        self.repository = repository
    }
    
    func execute(limit: Int, offset: Int, search: String?) async throws -> [PokemonListItem] {
        try await repository.fetchPokemons(limit: limit, offset: offset, search: search)
    }
}
