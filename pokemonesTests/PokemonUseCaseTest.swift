//
//  PokemonUseCaseTest.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 14/11/2025.
//
import XCTest

final class FetchPokemonsUseCaseTests: XCTestCase {

    func test_useCaseReturnsPokemons() async throws {
        // GIVEN
        let repo = PokemonRepositoryMock()
        repo.mockList = [
            PokemonListItem(name: "squirtle", url: "url")
        ]

        let useCase = FetchPokemonsUseCase(repository: repo)

        // WHEN
        let result = try await useCase.execute(limit: 20, offset: 0, search: nil)

        // THEN
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "squirtle")
    }

    func test_useCaseThrowsOnError() async {
        // GIVEN
        let repo = PokemonRepositoryMock()
        repo.shouldFail = true

        let useCase = FetchPokemonsUseCase(repository: repo)

        // WHEN
        do {
            _ = try await useCase.execute(limit: 20, offset: 0, search: nil)
            XCTFail("Expected error")
        } catch {
            // THEN
            XCTAssertTrue(error is NetworkError)
        }
    }
}
