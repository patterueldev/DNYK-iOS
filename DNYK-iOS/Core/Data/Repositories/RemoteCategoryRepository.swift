//
//  RemoteCategoryRepository.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import Foundation

protocol RemoteCategoryRepository {
    func getCategories() async throws -> [IRemoteCategory]
    func getCategoryGroups() async throws -> [IRemoteCategoryGroup]
}
