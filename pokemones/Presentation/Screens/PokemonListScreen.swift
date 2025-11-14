//
//  PokemonListScreen.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//

import SwiftUI
import SwiftUI

struct PokemonListScreen: View {

    @StateObject var viewModel: PokemonListViewModel

    var body: some View {
        ZStack(alignment: .top) {

            // 📌 Toda la app va dentro del NavigationStack
            NavigationStack {
                content
                    .navigationTitle("Pokédex")
            }

            // 📌 Banner flotante arriba de todo (por encima del NavigationBar)
            if let error = viewModel.errorMessage {
                BannerView(text: error)
                    .padding(.top, 50)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(999)
            }
        }
        .ignoresSafeArea(.container, edges: .top) // Permite al banner pegarse a la barra superior
        .animation(.spring(response: 0.4, dampingFraction: 0.85), value: viewModel.errorMessage)
    }

    // ----------------------------------------------------------
    // MARK: - CONTENT
    // ----------------------------------------------------------
    @ViewBuilder
    var content: some View {
        VStack(spacing: 0) {
            
            SearchBar(
                text: $viewModel.query,
                isLoading: viewModel.isLoading,
                onSubmit: { Task { await viewModel.search(reset: true) } },
                placeholder: "Buscar Pokémon..."
            )
            .padding(.top, DSSpacing.lg)
            
            if viewModel.query.isEmpty && !viewModel.recentSearches.isEmpty {
                RecentSearchesView(
                    items: viewModel.recentSearches,
                    onSelect: { selected in
                        viewModel.query = selected
                        Task { await viewModel.search(reset: true) }
                    },
                    onDelete: { item in
                        viewModel.deleteRecent(item)
                    }
                )
            }

            ScrollView {
                VStack(spacing: DSSpacing.md) {
                    if !viewModel.isLoading &&
                        viewModel.isSearching &&
                        viewModel.pokemons.isEmpty {

                        VStack(spacing: DSSpacing.sm) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 40))
                                .foregroundColor(DSColor.textSecondary)

                            DSTextLabel(
                                text: "No se encontraron Pokémon",
                                style: .body,
                                color: DSColor.textSecondary
                            )
                        }
                        .padding(.top, DSSpacing.xl)
                    }

                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 150), spacing: DSSpacing.md)],
                        spacing: DSSpacing.md
                    ) {
                        ForEach(Array(viewModel.pokemons.enumerated()), id: \.1.name) { index, pokemon in
                            NavigationLink(value: pokemon.name) {
                                PokemonCardGridItem(pokemon: pokemon)
                                    .task {
                                        await viewModel.loadMoreIfNeeded(currentIndex: index)
                                    }
                            }
                        }
                    }
                    .padding(.horizontal, DSSpacing.md)
                    .padding(.top, DSSpacing.md)

                    // espacio para que el loader no tape el grid
                    Color.clear.frame(height: 80)
                }
                .padding(.bottom, DSSpacing.xl)
            }
        }
        .navigationDestination(for: String.self) { name in
            DetailScreenFactory.detailScreen(for: name)
        }
        .overlay(alignment: .bottom) {
            if viewModel.isLoading {
                DSLoader()
                    .padding(.bottom, DSSpacing.md)
                    .transition(.opacity)
            }
        }.onAppear {
            viewModel.loadRecent()
        }
    }
}
