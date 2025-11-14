//
//  FetchPokemonDetailUseCase.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import Foundation

protocol FetchPokemonDetailUseCaseType {
    func execute(name: String) async throws -> PokemonDetail
}

final class FetchPokemonDetailUseCase: FetchPokemonDetailUseCaseType {
    private let repository: PokemonRepositoryType
    
    init(repository: PokemonRepositoryType) {
        self.repository = repository
    }
    
    func execute(name: String) async throws -> PokemonDetail {
        try await repository.fetchDetail(name: name)
    }
}
