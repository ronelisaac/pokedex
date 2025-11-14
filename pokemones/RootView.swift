//
//  RootView.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

struct RootView: View {
    private let repository = PokemonRepository()

    var body: some View {
        let fetchList = FetchPokemonsUseCase(repository: repository)
        let listVM = PokemonListViewModel(fetchUseCase: fetchList)

        TabView {
            PokemonListScreen(viewModel: listVM)
                .tabItem {
                    Label("Pokédex", systemImage: "magnifyingglass")
                }

            FavoritesScreen()
                .tabItem {
                    Label("Favoritos", systemImage: "star.fill")
                }
        }
    }
}
