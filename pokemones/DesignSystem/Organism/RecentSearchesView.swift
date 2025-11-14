//
//  RecentSearchesView.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

struct RecentSearchesView: View {
    
    let items: [String]
    let onSelect: (String) -> Void
    let onDelete: (String) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(items, id: \.self) { item in
                    HStack(spacing: 6) {
                        Button {
                            onSelect(item)
                        } label: {
                            Text(item)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }

                        Button {
                            withAnimation {
                                onDelete(item)
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                        }
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(14)
                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 1, y: 1)
                }
            }
            .padding(.horizontal)
        }
    }
}
