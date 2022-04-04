//
//  mainViewModel.swift
//  QuestInterface
//
//  Created by Kiyoshi Takeuchi on 2021/11/20.
//

import Foundation
import CoreData
import SwiftUI

class mainViewModel: ObservableObject {
    @Published var quests: [QuestViewModel] = []
    @Published var bunches: [BunchViewModel] = []
    @Published var details: [DetailViewModel] = []
    @Published var activeBunch: [BunchViewModel] = []
    
    func addTask(interval: String, questTitle: String, bunch: Bunch) {
        let quest = Quest(context: CoreDataStack.viewContext)
        quest.title = questTitle
        quest.completed = false
        quest.bunch = bunch
        CoreDataStack.save()
    }
    
    
    func dateFormater(date: Date, type: String) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        var date2: Date = Date()
        if type == "Daily Tasks" {
            date2 = Date() - (24 * 60) * 60
        }
        else if type == "Weekly Tasks" {
            date2 = Date() - (7 * 24 * 60) * 60
        }
        else if type == "Monthly Tasks" {
            date2 = Date() - (30 * 24 * 60) * 60
        }
        else if type == "Yearly Tasks" {
            date2 = Date() - (365 * 24 * 60) * 60
        }
        return formatter.localizedString(for: date, relativeTo: date2)
    }
    
    func getBunchTypeFromQuest(quest: QuestViewModel) -> String {
        return CoreDataStack.getQuestById(id: quest.id)!.bunch!.type!
    }
    
    func colorChooser(type: String) -> Color {
        if type == "Daily Tasks" {
            return .green
        }
        else if type == "Weekly Tasks" {
            return .blue
        }
        else if type == "Monthly Tasks" {
            return .purple
        }
        else {
            return .orange
        }
    }
    
    func experienceChooser(type: String) -> Int {
        if type == "Daily Tasks" {
            return 5
        }
        else if type == "Weekly Tasks" {
            return 10
        }
        else if type == "Monthly Tasks" {
            return 20
        }
        else {
            return 50
        }
    }
    
    func getTotalExp() -> Int {
        var n: Int = 0
        if quests != [] {
            for quest in quests {
                if quest.completed {
                    n = n + experienceChooser(type: getBunchTypeFromQuest(quest: quest))
                }
            }
        }
        return n
    }
    
    func getRank() -> String {
        let totalExp = getTotalExp()
        
        if totalExp > 50000 {
            return "Champion"
        }
        else if totalExp > 20000 {
            return "Legend"
        }
        else if totalExp > 10000 {
            return "Mythic"
        }
        else if totalExp > 5000 {
            return "Commander"
        }
        else if totalExp > 3000 {
            return "Master"
        }
        else if totalExp > 2000 {
            return "Superior"
        }
        else if totalExp > 1000 {
            return "Experienced"
        }
        else {
            return "Novice"
        }
        
    }
    
    func getRankColor() -> Color {
        let totalExp = getTotalExp()
        
        if totalExp > 50000 {
            return .yellow
        }
        else if totalExp > 20000 {
            return .orange
        }
        else if totalExp > 10000 {
            return .purple
        }
        else if totalExp > 5000 {
            return .blue
        }
        else if totalExp > 3000 {
            return .green
        }
        else if totalExp > 2000 {
            return .black
        }
        else if totalExp > 1000 {
            return .black
        }
        else {
            return .black
        }
        
    }
     
    
    
    func getQuestsFromBunch(type: String) {
        if CoreDataStack.getAllBunches(type: type) != [] {
        quests = CoreDataStack.getQuestsFromBunch(bunchOrigin:  CoreDataStack.getAllBunches(type: type)[0]).map(QuestViewModel.init)
        }
    }
    
    func getDetailsFromQuest(objectId: NSManagedObjectID) {
        details = CoreDataStack.getDetailsFromQuest(detailOrigin: CoreDataStack.getQuestById(id: objectId)!).map(DetailViewModel.init)
        
    }
    
    
    func getDetails() {
        details = CoreDataStack.getAllDetails().map(DetailViewModel.init)
    }
    
    func getAbsoluteAllBunches() {
        bunches = CoreDataStack.getAbsoluteAllBunches().map(BunchViewModel.init)
    }
    
    func getAbsoluteAllQuests() {
        quests = CoreDataStack.getAbsoluteAllQuests().map(QuestViewModel.init)
    }
    
    func pushNotificationSet(futureTime: Int, title: String, subtitle: String) -> () {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(futureTime), repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    
    func addBunch(type: String) {
        if CoreDataStack.getAllBunches(type: type) == [] {
            if type == "Daily Tasks" {
                let bunch = Bunch(context: CoreDataStack.viewContext)
                bunch.date = Date()
                bunch.type = type
                CoreDataStack.save()
                
                
                // for alert
                pushNotificationSet(futureTime: 23 * 60 * 60, title: "Daily Tasks Expiring", subtitle: "Daily tasks will expire in one hour")
            }
            else if type == "Weekly Tasks" {
                let bunch = Bunch(context: CoreDataStack.viewContext)
                bunch.date = Date() 
                bunch.type = type
                CoreDataStack.save()
                
                
                // for alert
                pushNotificationSet(futureTime: 6 * 24 * 60 * 60, title: "Weekly Tasks Expiring", subtitle: "Weekly tasks will expire in one day")
                
            }
            else if type == "Monthly Tasks" {
                let bunch = Bunch(context: CoreDataStack.viewContext)
                bunch.date = Date()
                bunch.type = type
                CoreDataStack.save()
                
                
                // for alert
                pushNotificationSet(futureTime: 29 * 24 * 60 * 60, title: "Monthly Tasks Expiring", subtitle: "Monthly tasks will expire in one day")
            }
            else if type == "Yearly Tasks" {
                let bunch = Bunch(context: CoreDataStack.viewContext)
                bunch.date = Date()
                bunch.type = type
                CoreDataStack.save()
                
                
                // for alert
                pushNotificationSet(futureTime: 358 * 24 * 60 * 60, title: "Yearly Tasks Expiring", subtitle: "Yearly tasks will expire in one week")
                pushNotificationSet(futureTime: 364 * 24 * 60 * 60, title: "Yearly Tasks Expiring", subtitle: "Yearly tasks will expire in one day")
                
            }
        }
        activeBunch = CoreDataStack.getAllBunches(type: type).map(BunchViewModel.init)
    }
    
    
    
    func deleteAllQuests() {
        let arrayofQuests = CoreDataStack.getAbsoluteAllQuests()
        for n in arrayofQuests {
            CoreDataStack.deleteQuest(quest: n)
        }
    }
    
    func deleteAbsoluteAllBunches() {
        let arrayOfBunches = CoreDataStack.getAbsoluteAllBunches()
        for n in arrayOfBunches {
            CoreDataStack.deleteBunch(bunch: n)
        }
    }
    
    /*
    func deleteAllBunches() {
        let arrayofBunches = CoreDataStack.getAllBunches()
        for n in arrayofBunches {
            CoreDataStack.deleteBunch(bunch: n)
        }
    }
    */
    
    
    /*
    func deleteAllDetails() {
        let arrayofDetails = CoreDataStack.getAllDetails()
        for n in arrayofDetails {
            CoreDataStack.deleteDetail(detail: n)
        }
    }
    
    */
    


}


struct BunchViewModel: Equatable, Identifiable {
    let bunch: Bunch
    
    var type: String {
        return bunch.type ?? ""
    }
    
    var date: Date {
        return bunch.date ?? Date()
    }
    
    var id: NSManagedObjectID {
        return bunch.objectID
    }
    
}


struct QuestViewModel: Equatable, Identifiable {
    let quest: Quest
    
    var name: String {
        return quest.title ?? ""
    }
    
    var completed: Bool {
        return quest.completed
    }
    
    var id: NSManagedObjectID {
        return quest.objectID
    }
    
}

struct DetailViewModel: Equatable, Identifiable {
    let detail: Detail
    
    var name: String {
        return detail.title ?? ""
    }
    
    var completed: Bool {
        return detail.completed
    }
    
    var id: NSManagedObjectID {
        return detail.objectID
    }
    
}


