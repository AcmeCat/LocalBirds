//
//  AllChecklistsResponse.swift
//  LocalBirds
//
//  Created by Rory Allen on 17/12/2023.
//

import Foundation

// MARK: - Checklists
struct AllChecklistsResponse: Codable {
    let entities: [Checklist]
    let total, page, pageSize: Int
}

// MARK: - Entity
struct Checklist: Codable {
    let name, id: String
}
