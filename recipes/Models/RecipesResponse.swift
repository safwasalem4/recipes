//
//  RecipesResponse.swift
//  recipes
//
//  Created by safwa salem on 2/5/22.
//

import Foundation

class RecipesResponse: NSObject, Codable {

    enum CodingKeys: String, CodingKey {
            case q
            case from
            case to
            case more
            case count
            case hits
    }

    // MARK: - Properties

        var q: String?
        var from: Int?
        var to: Int?
        var more: Bool?
        var count: Int?
        var hits: [RecipeDataSource]?

    // MARK: - Initializers

    init(
        q: String?,
        from: Int?,
        to: Int?,
        more: Bool?,
        count: Int?,
        hits: [RecipeDataSource]?
    ) {
        self.q = q
        self.from = from
        self.to = to
        self.more = more
        self.count = count
        self.hits = hits
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        q = try container.decode(String.self, forKey: .q)
        from = try container.decode(Int.self, forKey: .from)
        to = try container.decode(Int.self, forKey: .to)
        more = try container.decode(Bool.self, forKey: .more)
        count = try container.decode(Int.self, forKey: .count)
        hits = try container.decode([RecipeDataSource].self, forKey: .hits)
    }

    // MARK: - Encoding

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(q, forKey: .q)
        try container.encode(from, forKey: .from)
        try container.encode(to, forKey: .to)
        try container.encode(more, forKey: .more)
        try container.encode(count, forKey: .count)
        try container.encode(hits, forKey: .hits)
    }

}
