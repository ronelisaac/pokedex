//
//  FavoriteRepositoryType.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 14/11/2025.
//
protocol FavoritesRepositoryType {
    func isFavorite(_ name: String) -> Bool
    func toggle(name: String, imageURL: String)
    func getAll() -> [FavoritePokemon]
}
