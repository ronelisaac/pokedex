//
//  FaoriteScreen.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

struct FavoritesScreen: View {
    @StateObject private var viewModel = FavoritesViewModel()
    @Namespace private var animation
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                DSColor.background.ignoresSafeArea()
                
                if viewModel.favorites.isEmpty {
                    emptyState
                        .transition(.scale.combined(with: .opacity))
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(viewModel.favorites, id: \.objectID) { fav  in
                                FavoritePokemonCard(
                                       name: fav.name ?? "",
                                       imageURL: fav.imageURL ?? "",
                                       animation: animation,
                                       onUnfavorite: {
                                           viewModel.toggleFavorite(
                                               name: fav.name ?? "",
                                               imageURL: fav.imageURL ?? ""
                                           )
                                       }
                                   )
                                    .transition(.move(edge: .trailing).combined(with: .opacity))
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                                viewModel.toggleFavorite(name: fav.name ?? "", imageURL: fav.imageURL ?? "")
                                            }
                                        } label: {
                                            Label("Eliminar de favoritos", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                        .padding(.top, 24)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationTitle("Favoritos")
            .onAppear {
                viewModel.reload()
            }
        }
    }
    
    var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart")
                .font(.system(size: 60))
                .foregroundColor(DSColor.textSecondary)
                .shadow(color: .black.opacity(0.1), radius: 12, y: 4)
                .scaleEffect(1.1)
                .animation(
                    .easeInOut(duration: 1.2)
                        .repeatForever(autoreverses: true), value: UUID()
                )
            
            Text("No tienes Pokémon favoritos")
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(DSColor.textPrimary)
            
            Text("Agrega algunos desde la pantalla de detalle")
                .font(.body)
                .foregroundColor(DSColor.textSecondary)
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 32)
    }
}
