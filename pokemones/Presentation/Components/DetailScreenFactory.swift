//
//  DetailScreenFactory.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

enum DetailScreenFactory {
    static func detailScreen(for name: String) -> some View {
        let repo = PokemonRepository()
        let fetchDetail = FetchPokemonDetailUseCase(repository: repo)
        let fetchSpecies = FetchSpeciesUseCase(repository: repo)
        let vm = PokemonDetailViewModel(
            fetchDetailUseCase: fetchDetail,
            fetchSpeciesUseCase: fetchSpecies
        )

        return PokemonDetailScreen(viewModel: vm, name: name)
    }
}
