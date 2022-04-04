//
//  coreDataContainer.swift
//  QuestInterface
//
//  Created by Kiyoshi Takeuchi on 2021/11/20.
//


import CoreData
import Foundation


struct CoreDataStack {
    static var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "coreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    // Everything above this is static
    
    static func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    static func getAllQuests(type: String) -> [Quest] {
        let request: NSFetchRequest<Quest> = Quest.fetchRequest()
        do{
            return try viewContext.fetch(request)
        } catch {
            return [] //empty array in case it doesn't find anything
        }
    }
    
    static func getAbsoluteAllQuests() -> [Quest] {
        let request: NSFetchRequest<Quest> = Quest.fetchRequest()
        do{
            return try viewContext.fetch(request)
        } catch {
            return [] //empty array in case it doesn't find anything
        }
    }
    
    static func getAllDetails() -> [Detail] {
        let request: NSFetchRequest<Detail> = Detail.fetchRequest()
        do{
            return try viewContext.fetch(request)
        } catch {
            return [] //empty array in case it doesn't find anything
        }
    }
    
    static func getDetailsFromQuest(detailOrigin: Quest) -> [Detail] {
        let request: NSFetchRequest<Detail> = Detail.fetchRequest()
        request.predicate = NSPredicate(format: "quest == %@", detailOrigin)
        do{
            return try viewContext.fetch(request)
        } catch {
            return [] //empty array in case it doesn't find anything
        }
    }
    
    
    static func getQuestsFromBunch(bunchOrigin: Bunch) -> [Quest] {
        let request: NSFetchRequest<Quest> = Quest.fetchRequest()
        request.predicate = NSPredicate(format: "bunch == %@", bunchOrigin)
        do{
            return try viewContext.fetch(request)
        } catch {
            return [] //empty array in case it doesn't find anything
        }
    }
    
    
    
    static func getAllBunches(type: String) -> [Bunch] {
        let request: NSFetchRequest<Bunch> = Bunch.fetchRequest()
        var date = Date()
        if type == "Daily Tasks" {
            date = Date() - (24 * 60) * 60
        }
        else if type == "Weekly Tasks" {
            date = Date() - (7 * 24 * 60) * 60
        }
        else if type == "Monthly Tasks" {
            date = Date() - (30 * 24 * 60) * 60
        }
        else if type == "Yearly Tasks" {
            date = Date() - (365 * 24 * 60) * 60
        }
        request.predicate = NSPredicate(format: "type == %@ && date > %@", type, date as NSDate)
        do{
            return try viewContext.fetch(request)
        } catch {
            return [] //empty array in case it doesn't find anything
        }
        
    }
    
    static func getAbsoluteAllBunches() -> [Bunch] {
        let request: NSFetchRequest<Bunch> = Bunch.fetchRequest()
        do{
            return try viewContext.fetch(request)
        } catch {
            return [] //empty array in case it doesn't find anything
        }
    }
    
    
    static func deleteQuest(quest: Quest) {
        viewContext.delete(quest)
        
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print("Failed to save")
        }
        
    }
    
    static func deleteBunch(bunch: Bunch) {
        viewContext.delete(bunch)
        
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print("Failed to save")
        }
        
    }
    
    static func deleteDetail(detail: Detail) {
        viewContext.delete(detail)
        
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print("Failed to save")
        }
    }
    
    static func getQuestById(id: NSManagedObjectID) -> Quest? {
        do {
        return try viewContext.existingObject(with: id) as? Quest
        } catch {
            return nil
        }
    }
    
    
    static func getDetailById(id: NSManagedObjectID) -> Detail? {
        do {
        return try viewContext.existingObject(with: id) as? Detail
        } catch {
            return nil
        }
    }
    
    
    
    
    /*
    
    
    
    
    
    
    
    static func getAllFlash(difficulty: Int) -> [Flashcard] {
        let request: NSFetchRequest<Flashcard> = Flashcard.fetchRequest()
        let diff = Int(difficulty)
        request.predicate = NSPredicate(format: "difficulty == %i", diff)
        do{
            return try viewContext.fetch(request)
        } catch {
            return [] //empty array in case it doesn't find anything
        }
    }
    
    static func getAllHidden(difficulty: Int) -> [Flashcard] {
      let request: NSFetchRequest<Flashcard> = Flashcard.fetchRequest()
        let diff = Int(difficulty)
        request.predicate = NSPredicate(format: "difficulty == %i && isHidden == true", diff)
        do{
            return try viewContext.fetch(request)
        } catch {
            return [] //empty array in case it doesn't find anything
        }
    }
    
    
    
    static func getAllRotation(difficulty: Int) -> [Flashcard] {
        let request: NSFetchRequest<Flashcard> = Flashcard.fetchRequest()
        let diff = Int(difficulty)
        let date = Date()
        request.predicate = NSPredicate(format: "difficulty == %i && dueDate < %@ && isHidden == false", diff, date as NSDate)
        do{
            return try viewContext.fetch(request)
        } catch {
            return [] //empty array in case it doesn't find anything
        }
    }
    
    static func getAllNew(difficulty: Int) -> [Flashcard] {
        let request: NSFetchRequest<Flashcard> = Flashcard.fetchRequest()
        let diff = Int(difficulty)
        let date = Date() + (24 * 60) * 60
        let num = 1
        request.predicate = NSPredicate(format: "difficulty == %i && dueDate < %@ && cardNumber == %i && isHidden == false", diff, date as NSDate, num)
        do{
            return try viewContext.fetch(request)
        } catch {
            return [] //empty array in case it doesn't find anything
        }
    }
    
    
    
    
    */
    
    
    
}

