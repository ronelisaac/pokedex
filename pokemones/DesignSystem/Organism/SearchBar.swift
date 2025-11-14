//
//  PokeSearchBar.swift
//  pokemones
//  Search Bar
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var isLoading: Bool
    var onSubmit: () -> Void
    var placeholder: String = "Buscar Pokémon..."

    var body: some View {
        HStack(spacing: DSSpacing.sm) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(DSColor.textMuted)

            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .onSubmit(onSubmit)
                .onChange(of: text) {
                    onSubmit()
                }

            if isLoading {
                DSTextLabel(text: "Cargando…", style: .caption, color: DSColor.textMuted)
                    .transition(.opacity)
            }

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(DSColor.textMuted)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(DSSpacing.sm + 2)
        .background(RoundedRectangle(cornerRadius: DSRadii.md).fill(DSColor.surface))
        .overlay(RoundedRectangle(cornerRadius: DSRadii.md).stroke(DSColor.border, lineWidth: 1))
        .padding(.horizontal, DSSpacing.md)
        .animation(.easeInOut(duration: 0.15), value: isLoading)
    }
}

