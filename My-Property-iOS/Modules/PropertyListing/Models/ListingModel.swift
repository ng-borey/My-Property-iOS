//
//  ListingModel.swift
//  My-Property-iOS
//
//  Created by Ngoun Lyborey on 5/6/23.
//

import Foundation

struct ListingModel: Codable {
    let data: [Datum]
    let links: Links
    let meta: Meta
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let recordType, propertyType: String
    let currentUse: JSONNull?
    let landArea: Int?
    let progress: Int
    let titleAddress, shortAddress, addressCode, latitude: String
    let longitude: String
    let grossFloorArea: JSONNull?
    let image: Image
    let gallery: [Image]

    enum CodingKeys: String, CodingKey {
        case id
        case recordType = "record_type"
        case propertyType = "property_type"
        case currentUse = "current_use"
        case landArea = "land_area"
        case progress
        case titleAddress = "title_address"
        case shortAddress = "short_address"
        case addressCode = "address_code"
        case latitude, longitude
        case grossFloorArea = "gross_floor_area"
        case image, gallery
    }
}

// MARK: - Image
struct Image: Codable {
    let small, medium, large: String
    let original: String
}

// MARK: - Links
struct Links: Codable {
    let first, last: String
    let prev, next: JSONNull?
}

// MARK: - Meta
struct Meta: Codable {
    let currentPage, from, lastPage: Int
    let links: [Link]
    let path: String
    let perPage, to, total: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case links, path
        case perPage = "per_page"
        case to, total
    }
}

// MARK: - Link
struct Link: Codable {
    let url: String?
    let label: String
    let active: Bool
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public func hash(into hasher: inout Hasher) {
            hasher.combine(0)
        }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
