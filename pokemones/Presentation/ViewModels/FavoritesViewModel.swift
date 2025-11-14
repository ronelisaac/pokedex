//
//  FavoritesViewModel.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import Foundation
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published private(set) var favorites: [FavoritePokemon] = []
    
    private let repo: FavoritesRepositoryType
    
    init(repo: FavoritesRepositoryType = FavoritesRepositoryCoreData()) {
        self.repo = repo
        reload()
    }
    
    func reload() {
        favorites = repo.getAll()
    }
    
    func isFavorite(_ name: String) -> Bool {
        repo.isFavorite(name)
    }
    
    func toggleFavorite(name: String, imageURL: String) {
        repo.toggle(name: name, imageURL: imageURL)
        reload()
    }
}
