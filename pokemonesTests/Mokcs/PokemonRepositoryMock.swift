//
//  PokemonRepositoryMock.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 14/11/2025.
//
@testable import pokemones
import Foundation

final class PokemonRepositoryMock: PokemonRepositoryType {

    var mockList: [PokemonListItem] = []
    var shouldFail = false

    func fetchPokemons(limit: Int, offset: Int, search: String?) async throws -> [PokemonListItem] {
        if shouldFail { throw NetworkError.server }
        return mockList
    }

    func fetchDetail(name: String) async throws -> PokemonDetail {
        if shouldFail { throw NetworkError.server }
        return .sample
    }

    func fetchSpecies(name: String) async throws -> PokemonSpecies {
        if shouldFail { throw NetworkError.server }
        return .sample
    }
}
