//
//  PokemonCard.swift
//  pokemones
// Card (Grid Item)
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

struct PokemonCard: View {
    let name: String
    let imageURL: String
    let types: [String]

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: DSRadii.lg)
                .fill(DSColor.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: DSRadii.lg)
                        .stroke(DSColor.border, lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.25), radius: 8, y: 6)

            VStack(spacing: DSSpacing.sm) {
                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .tint(.white)
                            .frame(height: 70)
                    case .success(let img):
                        img.resizable()
                            .scaledToFit()
                            .frame(height: 80)
                            .transition(.opacity.combined(with: .scale))
                    case .failure:
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .frame(height: 70)
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding(.top, DSSpacing.md)

                DSTextLabel(text: name.capitalized, style: .subtitle)

                if !types.isEmpty {
                    HStack(spacing: DSSpacing.xs) {
                        ForEach(types, id: \.self) { type in
                            TypeBadge(text: type)
                        }
                    }
                    .padding(.bottom, DSSpacing.md)
                } else {
                    Spacer(minLength: DSSpacing.sm)
                }
            }
            .padding(.horizontal, DSSpacing.sm)
            .padding(.bottom, DSSpacing.sm)
        }
        .frame(height: 160)
    }
}
