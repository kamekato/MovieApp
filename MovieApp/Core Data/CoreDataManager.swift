//
//  CoreDataManager.swift
//  MovieApp
//
//  Created by Otebay Akan on 20.05.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LocalDBModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init(){}
    
    func save(){
        let context = persistentContainer.viewContext
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
    func addMovie( movie: MovieEntity.Movie) {
        let context = persistentContainer.viewContext
        context.perform {
            let newMovie = MovieManager(context: context)
            newMovie.id = Int64(movie.id)
            newMovie.title = movie.originalTitle
            
        }
    }
    
    func findMovie(with id: Int) -> MovieManager?{
        let context = persistentContainer.viewContext
        
        let requestResult: NSFetchRequest<MovieManager> = MovieManager.fetchRequest()
        requestResult.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let movies = try context.fetch(requestResult)
            if movies.count > 0{
                assert(movies.count == 1, "It meanns DataBase has duplicates")
                return movies[0]
            }
        } catch {
            print(error)
        }
        
        return nil
        
        
    }
    
    func deleteMovie ( movie: MovieEntity.Movie){
        let context = persistentContainer.viewContext
        do{
            try context.delete(movie)
        }catch{
            print(error)
        }
    }
    
    func allMovies() -> [MovieEntity.Movie]{
        let context = persistentContainer.viewContext
        let requestResult: NSFetchRequest<MovieManager> = MovieManager.fetchRequest()
        
        var movies = try? context.fetch(requestResult)
        
        return movies.map({ })
    }
}
