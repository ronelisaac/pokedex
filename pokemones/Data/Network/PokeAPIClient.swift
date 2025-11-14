//
//  PokeAPIClient.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import Alamofire
import Foundation

protocol PokeAPIClientType {
    func getPokemonList(limit: Int, offset: Int) async throws -> PokemonListResponse
    func getPokemonDetail(name: String) async throws -> PokemonDetail
    func getPokemonSpecies(name: String) async throws -> PokemonSpecies
}

final class PokeAPIClient: PokeAPIClientType {
    private let baseURL = "https://pokeapi.co/api/v2"
    private let session: Session

    init(session: Session = .default) {
        self.session = session
    }

    func getPokemonList(limit: Int, offset: Int) async throws -> PokemonListResponse {
        let url = "\(baseURL)/pokemon?limit=\(limit)&offset=\(offset)"
        return try await request(url)
    }

    func getPokemonDetail(name: String) async throws -> PokemonDetail {
        let url = "\(baseURL)/pokemon/\(name)"
        return try await request(url)
    }

    func getPokemonSpecies(name: String) async throws -> PokemonSpecies {
        let url = "\(baseURL)/pokemon-species/\(name)"
        return try await request(url)
    }

    private func request<T: Decodable>(_ url: String) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            session.request(url)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: T.self) { response in
                    debugPrint(response)
                    switch response.result {
                    case .success(let value):
                        continuation.resume(returning: value)
                    case .failure(let error):
                        continuation.resume(throwing: NetworkError.from(error))
                    }
                }
        }
    }
}
