//
//  DSButton.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import SwiftUI
enum DSButtonKind {
    case primary
    case secondary
    case ghost
    case destructive
}

struct DSButton: View {
    let title: String
    var systemImage: String? = nil
    let kind: DSButtonKind
    let action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: DSSpacing.sm) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
                    .font(DSTypography.body.weight(.semibold))
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: DSRadii.md)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .clipShape(RoundedRectangle(cornerRadius: DSRadii.md))
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .opacity(isPressed ? 0.85 : 1.0)
        }
        .buttonStyle(.plain) // evitamos estilos por defecto
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(.spring(response: 0.15, dampingFraction: 0.7)) {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.7)) {
                        isPressed = false
                    }
                }
        )
    }

    // MARK: - Style helpers

    private var backgroundColor: Color {
        switch kind {
        case .primary:
            return DSColor.accent
        case .secondary:
            return DSColor.surfaceAlt
        case .ghost:
            return Color.clear
        case .destructive:
            return DSColor.error
        }
    }

    private var foregroundColor: Color {
        switch kind {
        case .primary, .destructive:
            return .white
        case .secondary:
            return DSColor.textPrimary
        case .ghost:
            return DSColor.accent
        }
    }

    private var borderColor: Color {
        switch kind {
        case .secondary:
            return DSColor.border
        case .ghost:
            return DSColor.accent.opacity(0.4)
        default:
            return .clear
        }
    }

    private var borderWidth: CGFloat {
        switch kind {
        case .secondary, .ghost:
            return 1
        default:
            return 0
        }
    }
}
