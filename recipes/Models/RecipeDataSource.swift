//
//  RecipeDataSource.swift
//  recipes
//
//  Created by safwa salem on 2/5/22.
//

import Foundation

class RecipeDataSource: NSObject, Codable {

    enum CodingKeys: String, CodingKey {
            case recipe
    }

    // MARK: - Properties

        var recipe: Recipe?

    // MARK: - Initializers

    init(recipe: Recipe?) {
        self.recipe = recipe
    }

    required init(recipe decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        recipe = try container.decode(Recipe.self, forKey: .recipe)
    }

    // MARK: - Encoding

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(recipe, forKey: .recipe)
    }

}
