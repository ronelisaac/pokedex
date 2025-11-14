//
//  SpriteCarouselView.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import Foundation
import SwiftUI

struct SpriteCarousel: View {
    let detail: PokemonDetail
     
     private var sprites: [String] {
         [
             detail.sprites.front_default,
             detail.sprites.back_default,
             detail.sprites.front_shiny,
             detail.sprites.back_shiny
         ].compactMap { $0 }
     }
     
     @State private var index = 0
     @State private var autoPlayActive = true
     
     var body: some View {
         TabView(selection: $index) {
             ForEach(Array(sprites.enumerated()), id: \.offset) { i, url in
                 GeometryReader { geo in
                     let mid = geo.frame(in: .global).midX
                     let screenCenter = geo.size.width / 2
                     let distance = abs(mid - screenCenter)
                     
                     // Todo en CGFloat para evitar ambigüedad
                     let rawScale: CGFloat = 1.0 - distance / 400.0
                     let clampedScale: CGFloat = max(0.85, rawScale)
                     
                     AsyncImage(url: URL(string: url)) { phase in
                         switch phase {
                         case .empty:
                             ProgressView()
                                 .frame(maxWidth: .infinity, maxHeight: .infinity)
                             
                         case .success(let img):
                             img.resizable()
                                 .scaledToFit()
                                 .padding(20)
                                 .frame(maxWidth: .infinity, maxHeight: .infinity)
                                 .background(.ultraThinMaterial)
                                 .clipShape(RoundedRectangle(cornerRadius: 24))
                                 .shadow(color: .black.opacity(0.15), radius: 20, y: 10)
                                 .scaleEffect(clampedScale)
                                 .rotation3DEffect(
                                     .degrees(Double((1.0 - clampedScale) * 10.0)),
                                     axis: (x: 0.0, y: 1.0, z: 0.0)
                                 )
                             
                         case .failure:
                             Image(systemName: "photo")
                                 .frame(maxWidth: .infinity, maxHeight: .infinity)
                         @unknown default:
                             EmptyView()
                         }
                     }
                 }
                 .padding(.vertical, 20)
                 .tag(i)
             }
         }
         .frame(height: 260)
         .tabViewStyle(.page(indexDisplayMode: .automatic))
         .animation(.easeInOut, value: index)
         .onAppear { startAutoPlay() }
         .onDisappear { autoPlayActive = false }
     }
     
     // MARK: - AUTO PLAY
     private func startAutoPlay() {
         autoPlayActive = true
         
         Task {
             while autoPlayActive {
                 try? await Task.sleep(nanoseconds: 3_500_000_000) // 3.5s
                 
                 await MainActor.run {
                     withAnimation(.easeInOut(duration: 0.6)) {
                         if index < sprites.count - 1 {
                             index += 1
                         } else {
                             index = 0
                         }
                     }
                 }
             }
         }
     }
}
