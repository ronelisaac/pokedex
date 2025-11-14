//
//  StatItem.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

struct StatItem: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(DSColor.textPrimary)
            Spacer()
            Text(value)
                .font(.title3.bold())
                .foregroundColor(DSColor.accent)
        }
        .padding()
        .background(DSColor.surface.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
