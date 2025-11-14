//
//  PokemonBanner.swift
//  pokemones
// Banner for errors or alerts
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

struct BannerView: View {
    var text: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.yellow)
                .font(.system(size: 18, weight: .semibold))

            Text(text)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 18)
        .background(.ultraThinMaterial)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(0.05)) 
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 12, y: 6)
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}
