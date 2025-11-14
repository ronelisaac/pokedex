//
//  PokemonrepositoryTest.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 14/11/2025.
//
import XCTest
@testable import pokemones

@MainActor
final class PokemonRepositoryTests: XCTestCase {

    func test_fetchPokemons_success() async throws {
        // GIVEN
        let api = PokeAPIClientMock()
        api.mockListResponse = PokemonListResponse(
            count: 2,
            next: nil,
            results: [
                PokemonListItem(name: "bulbasaur", url: "url1"),
                PokemonListItem(name: "charmander", url: "url2")
            ]
        )

        let repo = PokemonRepository(api: api)

        // WHEN
        let result = try await repo.fetchPokemons(limit: 20, offset: 0, search: nil)

        // THEN
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "bulbasaur")
    }

    func test_fetchPokemons_failure_returnsError() async {
        // GIVEN
        let api = PokeAPIClientMock()
        api.shouldFail = true

        let repo = PokemonRepository(api: api)

        // WHEN / THEN
        do {
            _ = try await repo.fetchPokemons(limit: 20, offset: 0, search: nil)
            XCTFail("Should have thrown")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
}
