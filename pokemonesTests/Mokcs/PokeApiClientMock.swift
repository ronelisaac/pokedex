//
//  PokeApiClientMock.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 14/11/2025.
//
import Foundation
@testable import pokemones

final class PokeAPIClientMock: PokeAPIClientType {

    var mockListResponse: PokemonListResponse?
    var mockDetail: PokemonDetail?
    var mockSpecies: PokemonSpecies?
    var shouldFail = false

    func getPokemonList(limit: Int, offset: Int) async throws -> PokemonListResponse {
        if shouldFail { throw NetworkError.server }
        return mockListResponse ?? PokemonListResponse(count: 0, next: nil, results: [])
    }

    func getPokemonDetail(name: String) async throws -> PokemonDetail {
        if shouldFail { throw NetworkError.server }
        return mockDetail ?? .sample
    }

    func getPokemonSpecies(name: String) async throws -> PokemonSpecies {
        if shouldFail { throw NetworkError.server }
        return mockSpecies ?? .sample
    }
}
