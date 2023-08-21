//
//  File.swift
//  
//
//  Created by John Patrick Teruel on 8/19/23.
//

import Foundation

public class Utils {
    private static var dnykEntityUUID: [DNYKEntity: String] = [:]
    private static var latestDnykEntity: DNYKEntity?
    
    public static func generateUUID(for entity: DNYKEntity) -> String {
        let uuid = UUID().uuidString
        dnykEntityUUID[entity] = uuid
        latestDnykEntity = entity
        return uuid
    }
    
    public static func getLatestUUID(for entity: DNYKEntity) -> String? {
        return dnykEntityUUID[entity]
    }
    
    public static func getLatestUUID() -> String? {
        // sort by date created
        guard let latestEntity = latestDnykEntity else {
            return nil
        }
        return dnykEntityUUID[latestEntity]
    }
}

public enum DNYKEntity: String {
    case category
    case categoryGroup
    case transaction
}

