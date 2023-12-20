//
//  Endpoint.swift
//  LocalBirds
//
//  Created by Rory Allen on 20/12/2023.
//

import Foundation

enum Endpoint {
    case birds
    case detail(birdId: Int)
    case checklists
    case createChecklist(submissionData: Data?)
    case sightings(checklistId: String)
    case createSighting(checklistId: String, birdId: Int, submissionData: Data?)
}


extension Endpoint {
    enum MethodType {
        case GET
        case POST(data: Data?)
    }
}


extension Endpoint {
    
    var host: String { "nuthatch.lastelm.software" }
    
    var path: String {
        switch self {
        case .birds:
            return "/v2/birds"
        case .detail(let id):
            return "/birds/\(id)"
        case .checklists, .createChecklist:
            return "/checklists"
        case .sightings(let id):
            return "/checklists/\(id)/entries"
        case .createSighting(let checklistId, let birdId, _):
            return "/checklists/\(checklistId)/entries/\(birdId)"
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .birds, .detail, .checklists, .sightings:
            return .GET
        case .createChecklist(let data), .createSighting(_, _, let data):
            return .POST(data: data)
        }
    }
}

extension Endpoint {
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        return urlComponents.url
    }
}
