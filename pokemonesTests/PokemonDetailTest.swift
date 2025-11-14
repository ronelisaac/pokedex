//
//  PokemonDetailTest.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 14/11/2025.
//
import Foundation
import XCTest
@testable import pokemones

final class PokemonDetailTests: XCTestCase {

    func test_sampleDetail_hasCorrectData() {
        let detail = PokemonDetail.sample
        XCTAssertEqual(detail.id, 1)
        XCTAssertEqual(detail.name, "bulbasaur")
        XCTAssertEqual(detail.height, 7)
    }

    func test_sampleSpecies_hasFlavorText() {
        let species = PokemonSpecies.sample
        XCTAssertEqual(species.flavor_text_entries.first?.flavor_text, "Test Pokémon description")
    }
}
