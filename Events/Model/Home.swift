//
//  Home.swift
//  Events
//
//  Created by Joshua on 10/07/2022.
//

import Foundation

// MARK: - WelcomeElement
struct HomeModel: Codable {
    let id: ID?
    let name, slug: String?
    let homeImageURL: String?
    let imageThumbURL, iconThumbURL: ThumbURL?
    let isLastNode: Bool?
    let serviceTypes: [ServiceType]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name, slug
        case homeImageURL = "home_image_url"
        case imageThumbURL = "image_thumb_url"
        case iconThumbURL = "icon_thumb_url"
        case isLastNode = "is_last_node"
        case serviceTypes = "service_types"
    }
}

// MARK: - ThumbURL
struct ThumbURL: Codable {
    let lg, md, sm: String?
}

// MARK: - ServiceType
struct ServiceType: Codable {
    let id: Int?
    let name, slug: String?
    let imageThumbURL: ThumbURL?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case imageThumbURL = "image_thumb_url"
    }
}

enum ID: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ID"))
    }
}

typealias Home = [HomeModel]
