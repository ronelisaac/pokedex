//
//  PokemonDetailViewModel.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import Foundation
import SwiftUI
import Combine

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    @Published var detail: PokemonDetail?
    @Published var species: PokemonSpecies?
    @Published var descriptionText = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let fetchDetailUseCase: FetchPokemonDetailUseCaseType
    private let fetchSpeciesUseCase: FetchSpeciesUseCaseType
    
    
    init(
        fetchDetailUseCase: FetchPokemonDetailUseCaseType,
        fetchSpeciesUseCase: FetchSpeciesUseCaseType
    ) {
        self.fetchDetailUseCase = fetchDetailUseCase
        self.fetchSpeciesUseCase = fetchSpeciesUseCase
    }
    
    func load(name: String) async {
        isLoading = true
        do {
            async let detailTask = fetchDetailUseCase.execute(name: name)
            async let speciesTask = fetchSpeciesUseCase.execute(name: name)
            
            let (detail, species) = try await (detailTask, speciesTask)
            self.detail = detail
            self.species = species
            self.descriptionText = species.flavor_text_entries
                .first(where: { $0.language.name == "en" })?
                .flavor_text
                .replacingOccurrences(of: "\n", with: " ") ?? ""
        } catch {
            self.errorMessage = (error as? NetworkError)?.localizedDescription ?? "Error cargando detalle"
        }
        isLoading = false
    }
}
