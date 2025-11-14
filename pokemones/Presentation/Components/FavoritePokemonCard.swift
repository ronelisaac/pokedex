//
//  FavoriteCard.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI
struct FavoritePokemonCard: View {
    let name: String
    let imageURL: String
    var animation: Namespace.ID
    var onUnfavorite: () -> Void

    @State private var appear = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {

            // Card completo
            HStack(spacing: 16) {
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)
                        .frame(width: 70, height: 70)
                        .shadow(color: .black.opacity(0.2), radius: 10, y: 6)
                    
                    AsyncImage(url: URL(string: imageURL)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let img):
                            img.resizable()
                                .scaledToFit()
                                .frame(width: 64, height: 64)
                                .matchedGeometryEffect(id: name, in: animation)
                        default:
                            Image(systemName: "photo")
                        }
                    }
                }
                .scaleEffect(appear ? 1 : 0.6)
                .opacity(appear ? 1 : 0)
                .rotation3DEffect(.degrees(appear ? 0 : -20),
                                  axis: (x: 0, y: 1, z: 0))
                .shadow(color: .black.opacity(0.15), radius: 12, y: 6)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name.capitalized)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(DSColor.textPrimary)
                    
                    Text("Pokémon favorito")
                        .foregroundColor(DSColor.textSecondary)
                        .font(.caption)
                }
                
                Spacer()
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(DSColor.surface.opacity(0.15))
                    .shadow(color: .black.opacity(0.1), radius: 8, y: 4)
            )
            .onAppear {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7).delay(0.05)) {
                    appear = true
                }
            }
            
            Button {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                    onUnfavorite()
                }
            } label: {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 20))
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
            }
            .padding(12)
        }
    }
}
