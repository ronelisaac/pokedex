//
//  NetworkError.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import Foundation
import Alamofire

enum NetworkError: LocalizedError {
    case badRequest
    case notFound
    case server
    case decoding
    case offline
    case unknown

    static func from(_ afError: AFError) -> NetworkError {
        if let code = afError.responseCode {
            switch code {
            case 400: return .badRequest
            case 404: return .notFound
            case 500...599: return .server
            default: return .unknown
            }
        }
        if (afError.underlyingError as? URLError)?.code == .notConnectedToInternet {
            return .offline
        }
        return .unknown
    }

    var errorDescription: String? {
        switch self {
        case .badRequest: return "Solicitud inválida (400)"
        case .notFound: return "Recurso no encontrado (404)"
        case .server: return "Error del servidor (5xx)"
        case .offline: return "Sin conexión a internet"
        case .decoding: return "Error al decodificar los datos"
        case .unknown: return "Error desconocido"
        }
    }
}
