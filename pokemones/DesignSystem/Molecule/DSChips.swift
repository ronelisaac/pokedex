//
//  DSChips.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI

struct DSChip: View {
    let text: String
    var leadingIcon: String? = nil
    var trailingIcon: String? = nil
    var onTap: (() -> Void)?

    var body: some View {
        Button {
            onTap?()
        } label: {
            HStack(spacing: DSSpacing.xs) {
                if let leadingIcon {
                    Image(systemName: leadingIcon)
                }
                Text(text)
                if let trailingIcon {
                    Image(systemName: trailingIcon)
                }
            }
            .font(DSTypography.caption)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(DSColor.surfaceAlt)
            .foregroundColor(DSColor.textSecondary)
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
