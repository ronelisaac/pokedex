//
//  FetchSpeciesUseCase.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import Foundation

protocol FetchSpeciesUseCaseType {
    func execute(name: String) async throws -> PokemonSpecies
}

final class FetchSpeciesUseCase: FetchSpeciesUseCaseType {
    private let repository: PokemonRepositoryType
    
    init(repository: PokemonRepositoryType) {
        self.repository = repository
    }
    
    func execute(name: String) async throws -> PokemonSpecies {
        try await repository.fetchSpecies(name: name)
    }
}
