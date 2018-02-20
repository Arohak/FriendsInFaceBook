//
//  Model.swift
//  FriendsInFaceBook
//
//  Created by Admin on 20.02.2018.
//  Copyright © 2018 Victoria Kravets. All rights reserved.
//

import Foundation
import RealmSwift

public class Model<Storage: RLMModel> {
    
    // MARK: -
    // MARK: Subtypes
    
    public typealias StorageType = Storage
    
    // MARK: -
    // MARK: Static
    
    static func instantiate(_ storage: StorageType) -> Self {
        return self.init(id: storage.id)
    }
    
    // MARK: -
    // MARK: Properties
    
    public var id: String
    public var storage: StorageType {
        let id = self.id
        return Realm.current?.object(ofType: StorageType.self, forPrimaryKey: id)
            ?? modify(StorageType()) { storage in
                storage.id = id
                Realm.write { $0.add(storage, update: true)}
        }
    }
    
    private var lock: NSLocking = NSRecursiveLock()
    
    private var isInReadTransaction = false
    private var isInWriteTransaction = false
    
    // MARK: -
    // MARK: Init and Deinit
    
    public required init(id: String) {
        self.id = id
        
        self.configure()
    }
    
    // MARK: -
    // MARK: Public
    
    public func read() {
        self.configureStorageTransaction(
            exncluding: { isInWriteTransaction },
            condition: { isInReadTransaction = $0 },
            action: {
                self.readStorage(self.storage)
        })
    }
    
    public func write() {
        self.update {
            self.writeStorage(self.storage)
        }
    }
    
    public func update(_ action: () -> ()) {
        self.configureStorageTransaction(
            exncluding: { isInReadTransaction },
            condition: { isInWriteTransaction = $0 },
            action: {
                Realm.write { _ in
                    action()
                }
        })
        
    }
    
    // MARK: -
    // MARK: Open
    
    open func configure() {
        self.read()
    }
    
    open func readStorage(_ storage: StorageType) {
        
    }
    
    open func writeStorage(_ storage: StorageType) {
        
    }
    
    // MARK: -
    // MARK: Private
    
    private func locked(_ action: () ->()) {
        self.lock.do(action: action)
    }
    private func configureStorageTransaction(
        exncluding: () -> (Bool),
        condition: (Bool) -> (),
        action: () -> ()
        ) {
        self.locked {
            if exncluding() {
                return
            }
            condition(true)
            action()
            condition(false)
        }
    }
}
