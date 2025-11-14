//
//  FavoritesRepositoryCoreData.swift
//  pokemones
//
//  Created by Ronel Isaac Lezama Salazar on 13/11/2025.
//
import CoreData

final class FavoritesRepositoryCoreData: FavoritesRepositoryType {

    private let context = CoreDataStack.shared.context
       
       func isFavorite(_ name: String) -> Bool {
           let req: NSFetchRequest<FavoritePokemon> = FavoritePokemon.fetchRequest()
           req.predicate = NSPredicate(format: "name == %@", name)
           
           return (try? context.count(for: req)) ?? 0 > 0
       }
       
       func toggle(name: String, imageURL: String) {
           if isFavorite(name) {
               removeFavorite(name)
           } else {
               addFavorite(name, imageURL: imageURL)
           }
       }

       func getAll() -> [FavoritePokemon] {
           let req: NSFetchRequest<FavoritePokemon> = FavoritePokemon.fetchRequest()
           req.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: false)]
           return (try? context.fetch(req)) ?? []
       }
       
       // MARK: - Private ops

       private func addFavorite(_ name: String, imageURL: String) {
           let fav = FavoritePokemon(context: context)
           fav.name = name
           fav.imageURL = imageURL
           fav.dateAdded = Date()
           CoreDataStack.shared.save()
       }
       
       private func removeFavorite(_ name: String) {
           let req: NSFetchRequest<FavoritePokemon> = FavoritePokemon.fetchRequest()
           req.predicate = NSPredicate(format: "name == %@", name)
           
           if let obj = try? context.fetch(req).first {
               context.delete(obj)
               CoreDataStack.shared.save()
           }
       }
}
