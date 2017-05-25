//
//  TriviaRepositoryService.swift
//  TrivialAsia
//
//  Created by Anastasia Stepanova-Kolupakhina on 25.05.17.
//  Copyright © 2017 Anastasia Kolupakhina. All rights reserved.
//

import Foundation
import RealmSwift

class TriviaRepositoryService {
    
    func getTriviaToken() -> TriviaToken? {
        let realm = try! Realm()
        return realm.objects(TriviaToken.self).first
    }
    
    func setTriviaToken(_ token: TriviaToken) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(token, update: true)
        }
    }
    
    func getAnsweredTrivia() -> [Trivia] {
        let realm = try! Realm()
        let trivia = realm.objects(Trivia.self).filter { $0.isAnswered }
        return Array(trivia)
    }
    
//    func getTrivia() -> [Trivia] {
//        let realm = try! Realm()
//        let trivia = realm.objects(Trivia.self)
//        return Array(trivia)
//    }
//    
//    func getSortedTrivia() -> [Trivia] {
//        var trivia = getTrivia()
//        trivia.sort(by: { $0.uploadDate < $1.uploadDate })
//        return trivia
//    }
    
//    func setUniqueTrivia(_ list: [Trivia]) -> [Trivia] {
//        let storedTrivia = getTrivia()
//        var uniqueTrivia = [Trivia]()
//        
//        for trivia in list {
//            if !storedTrivia.contains(where: { $0.id == trivia.id }) {
//                uniqueTrivia.append(trivia)
//            }
//        }
//        
//        guard uniqueTrivia.count > 0 else {
//            return []
//        }
//        
//        let realm = try! Realm()
//        try! realm.write {
//            for trivia in uniqueTrivia {
//                realm.add(trivia, update: true)
//            }
//        }
//        return uniqueTrivia
//    }
    
}
