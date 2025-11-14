//
//  PokemonCardGridItemView.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

struct PokemonCardGridItem: View {
    let pokemon: PokemonListItem
    
    
    var body: some View {
        let id = extractID(from: pokemon.url)
        let imageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        
        
        PokemonCard(name: pokemon.name, imageURL: imageURL, types: [])
            .overlay(
                Text("#\(id)")
                    .font(DSTypography.caption)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, DSSpacing.sm)
                    .padding(.leading, DSSpacing.sm),
                alignment: .topLeading
            )
    }
    
    
    private func extractID(from url: String) -> String {
        url.split(separator: "/").last.map(String.init) ?? "1"
    }
}
