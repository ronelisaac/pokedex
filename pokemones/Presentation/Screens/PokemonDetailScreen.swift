//
//  PokemonDetailScreen.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

struct PokemonDetailScreen: View {
    @StateObject var viewModel: PokemonDetailViewModel
    @State private var isFavorite = false
    @StateObject private var favoritesVM = FavoritesViewModel()
    let name: String
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            // Fondo fijo !!
            DSColor.background
                .ignoresSafeArea()
            if viewModel.isLoading {
                ZStack {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 120, height: 120)
                        .shadow(color: .black.opacity(0.2), radius: 20, y: 10)
                    
                    ProgressView()
                        .scaleEffect(2)
                }
                .transition(.scale.combined(with: .opacity))
                .zIndex(10)
            }
            
            ScrollView {
                VStack(spacing: 32) {
                    
                    // HEADER
                    PokemonHeader(
                        name: viewModel.detail?.name.capitalized ?? "",
                        spriteURL: viewModel.detail?.sprites.front_default
                    )
                    .padding(.top, 80)
                    
                    // CARRUSEL PREMIUM
                    if let detail = viewModel.detail {
                        SpriteCarousel(detail: detail)
                            .padding(.horizontal, 20)
                    }
                    
                    // INFO + STATS
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text("Descripción")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(DSColor.textPrimary)
                        
                        Text(viewModel.descriptionText)
                            .font(.body)
                            .foregroundColor(DSColor.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Divider().padding(.vertical, 8)
                        
                        Text("Información")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(DSColor.textPrimary)
                        
                        VStack(spacing: 12) {
                            StatItem(title: "Altura", value: "\(viewModel.detail?.height ?? 0)")
                            StatItem(title: "Peso", value: "\(viewModel.detail?.weight ?? 0)")
                        }
                        
                    }
                    .padding(24)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(color: .black.opacity(0.1), radius: 20, y: 10)
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 50)
            }
            
            // BOTONES FLOTANTES — TOP RIGHT
            FloatingButtonsBar(
                isFavorite: $isFavorite,
                shareURL: URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)")!,
                onToggleFavorite: {
                    favoritesVM.toggleFavorite(
                        name: viewModel.detail?.name ?? "Sin nombre",
                        imageURL: viewModel.detail?.sprites.front_default ?? ""
                    )
                    isFavorite = favoritesVM.isFavorite(name)
                }
            )
            .padding(.trailing, 24)
            .padding(.top, 24)
        }
        .onAppear {
            Task { await viewModel.load(name: name) }
            isFavorite = favoritesVM.isFavorite(name)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(name.capitalized)
                    .font(.headline)
            }
        }
    }
}
