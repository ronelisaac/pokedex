//
//  FloatingButtonsBar.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

struct FloatingButtonsBar: View {
    @Binding var isFavorite: Bool
    let shareURL: URL
    let onToggleFavorite: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            
            // FAVORITE BUTTON
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    onToggleFavorite()  
                }
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .font(.title3.weight(.bold))
                    .foregroundColor(isFavorite ? .red :.white)
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.15), radius: 4, y: 2)
            }
            
            // SHARE BUTTON
            ShareLink(item: shareURL) {
                Image(systemName: "square.and.arrow.up")
                    .font(.title3.weight(.bold))
                    .foregroundColor(.white)
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.15), radius: 4, y: 2)
            }
        }
    }
}
