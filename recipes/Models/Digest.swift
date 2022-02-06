//
//  Digest.swift
//  recipes
//
//  Created by safwa salem on 2/4/22.
//

import Foundation

class Digest: NSObject, Codable {

    enum CodingKeys: String, CodingKey {
            case label
            case tag
            case schemaOrgTag
            case total
            case hasRDI
            case daily
            case unit
    }

    // MARK: - Properties

        var label: String
        var tag: String
        var schemaOrgTag: String
        var total: Double
        var hasRDI: Bool
        var daily: Double
        var unit: String

    // MARK: - Initializers

    init(
        label: String,
        tag: String,
        schemaOrgTag: String,
        total: Double,
        hasRDI: Bool ,
        daily: Double,
        unit: String
    ) {
        self.label = label
        self.tag = tag
        self.schemaOrgTag = schemaOrgTag
        self.total = total
        self.hasRDI = hasRDI
        self.daily = daily
        self.unit = unit
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        label = try container.decode(String.self, forKey: .label)
        tag = try container.decode(String.self, forKey: .tag)
        schemaOrgTag = try container.decode(String.self, forKey: .schemaOrgTag)
        total = try container.decode(Double.self, forKey: .total)
        hasRDI = try container.decode(Bool.self, forKey: .hasRDI)
        daily = try container.decode(Double.self, forKey: .daily)
        unit = try container.decode(String.self, forKey: .unit)
    }

    // MARK: - Encoding

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(label, forKey: .label)
        try container.encode(tag, forKey: .tag)
        try container.encode(schemaOrgTag, forKey: .schemaOrgTag)
        try container.encode(total, forKey: .total)
        try container.encode(hasRDI, forKey: .hasRDI)
        try container.encode(daily, forKey: .daily)
        try container.encode(unit, forKey: .unit)

    }

}
