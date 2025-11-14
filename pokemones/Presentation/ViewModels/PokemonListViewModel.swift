//
//  PokemonListViewModel.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [PokemonListItem] = []
    @Published var isLoading = false
    @Published var recentSearches: [String] = []
    @Published var errorMessage: String? {
        didSet {
            if errorMessage != nil {
                Task {
                    try? await Task.sleep(nanoseconds: 3_000_000_000) // 3 segundos
                    await MainActor.run { self.errorMessage = nil }
                }
            }
        }
    }
    
    @Published var query: String = "" {
        didSet { debounceSearch() }
    }
    
    /// true cuando el usuario está escribiendo algo (modo búsqueda parcial)
    var isSearching: Bool {
        !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    private var debounceTask: Task<Void, Never>?
    
    private let fetchUseCase: FetchPokemonsUseCaseType
    private var offset = 0
    private let limit = 20
    private var canLoadMore = true
    
    init(fetchUseCase: FetchPokemonsUseCaseType) {
        self.fetchUseCase = fetchUseCase
        // Primera carga: lista normal paginada
        Task { await search(reset: true, fromInit: true) }
        loadRecent()
    }
    
    // MARK: - Search (with paging + partial search)
    func search(reset: Bool = true, fromInit: Bool = false) async {
        guard !isLoading else { return }
        
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        let searching = !trimmed.isEmpty
        
        if reset {
            offset = 0
            pokemons.removeAll()
            canLoadMore = true
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            
            if searching {
                // En este modo NO paginamos: mostramos todos los matches
                let result = try await fetchUseCase.execute(
                    limit: limit,
                    offset: 0,
                    search: trimmed
                )
                self.pokemons = result
                self.canLoadMore = false   // no hay scroll infinito en búsqueda
                if !query.isEmpty { saveSearchQuery() }
                
            } else {
                guard canLoadMore else {
                    isLoading = false
                    return
                }
                
                let result = try await fetchUseCase.execute(
                    limit: limit,
                    offset: offset,
                    search: nil
                )
                
                self.pokemons.append(contentsOf: result)
                self.offset += limit
                self.canLoadMore = result.count == limit
            }
            
            
        } catch {
            self.errorMessage = (error as? NetworkError)?.localizedDescription ?? "Error cargando pokémon"
        }
        
        isLoading = false
    }
    
    // MARK: - Debounce
    private func debounceSearch() {
        debounceTask?.cancel()
        
        debounceTask = Task { [weak self] in
            guard let self else { return }
            
            try? await Task.sleep(nanoseconds: 300_000_000) // 0.3 s
            
            await self.search(reset: true)
        }
    }
    
    // MARK: - Historial (puede ser NO-OP por ahora)
    func loadRecent() {
        recentSearches = SearchHistoryStore.shared.recent()
    }
    
    func repeatSearch(_ query: String) async {
        self.query = query
        await search(reset: true)
    }
    
    // MARK: - Infinite scroll pagination
    func loadMoreIfNeeded(currentIndex index: Int) async {
        // Solo paginamos cuando NO estamos buscando
        guard !isSearching else { return }
        guard !isLoading else { return }
        guard canLoadMore else { return }
        guard !pokemons.isEmpty else { return }
        
        let threshold = max(pokemons.count - 5, 0)
        
        if index == threshold {
            await search(reset: false)
        }
    }
    
    func saveSearchQuery() {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !q.isEmpty else { return }
        SearchHistoryStore.shared.add(q)
        loadRecent()
    }
    
    func deleteRecent(_ query: String) {
        SearchHistoryStore.shared.remove(query)
        recentSearches = SearchHistoryStore.shared.recent()
    }
}
