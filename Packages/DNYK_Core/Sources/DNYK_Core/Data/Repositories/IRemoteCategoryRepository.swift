//
//  RemoteCategoryRepository.swift
//  DNYK-iOS
//
//  Created by John Patrick Teruel on 8/17/23.
//

import Foundation

protocol IRemoteCategoryRepository {
    func getCategories() async throws -> [IRemoteCategory]
    func getCategoryGroups() async throws -> [IRemoteCategoryGroup]
}
