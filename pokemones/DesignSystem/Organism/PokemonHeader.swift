//
//  pokemonHeader.swift
//  pokemones
// Detail Header
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//

import SwiftUI

struct PokemonHeader: View {
    let name: String
    let spriteURL: String?
    
    var body: some View {
        VStack(spacing: 16) {
            
            if let spriteURL, let url = URL(string: spriteURL) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(height: 240)
                        .shadow(color: .black.opacity(0.25), radius: 40, y: 15)
                } placeholder: {
                    ProgressView()
                }
            }
            
            Text(name)
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(DSColor.textPrimary)
        }
    }
}
