//
//  DSBadge.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

struct TypeBadge: View {
    let text: String

    var body: some View {
        Text(text.capitalized)
            .font(DSTypography.caption.weight(.semibold))
            .padding(.vertical, 4)
            .padding(.horizontal, 10)
            .background(DSColor.pokemonType(text).opacity(0.2))
            .foregroundColor(DSColor.pokemonType(text))
            .clipShape(Capsule())
    }
}
