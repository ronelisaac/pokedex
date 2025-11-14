//
//  SearchHistoryStore.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import Foundation

final class SearchHistoryStore {

    static let shared = SearchHistoryStore()

    private let key = "recent_searches_key"
    private let limit = 5

    private init() {}

    func add(_ query: String) {
        var items = recent()

        let normalized = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !normalized.isEmpty else { return }

        items.removeAll(where: { $0.lowercased() == normalized.lowercased() })
        items.insert(normalized, at: 0)

        if items.count > limit {
            items = Array(items.prefix(limit))
        }

        UserDefaults.standard.set(items, forKey: key)
    }

    func recent() -> [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }

    func remove(_ query: String) {
        var items = recent()
        items.removeAll(where: { $0.lowercased() == query.lowercased() })
        UserDefaults.standard.set(items, forKey: key)
    }

    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
