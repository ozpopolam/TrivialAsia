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
    
}
