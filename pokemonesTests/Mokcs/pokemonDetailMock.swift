//
//  pokemonDetailMock.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 14/11/2025.
//
@testable import pokemones

extension PokemonDetail {
    static let sample = PokemonDetail(
        id: 1,
        name: "bulbasaur",
        height: 7,
        weight: 69,
        sprites: Sprites(
            front_default: "https://via.placeholder.com/100",
            back_default: nil,
            front_shiny: nil,
            back_shiny: nil
        ),
        types: []
    )
}

extension PokemonSpecies {
    static let sample = PokemonSpecies(
        flavor_text_entries: [
            FlavorText(
                flavor_text: "Test Pokémon description",
                language: Language(name: "en")
            )
        ]
    )
}
