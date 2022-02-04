//
//  Ingredient.swift
//  recipes
//
//  Created by safwa salem on 2/4/22.
//

import Foundation

class Ingredient: NSObject, Codable {

    enum CodingKeys: String, CodingKey {
            case text
            case quantity
            case measure
            case food
            case weight
            case foodCategory
            case image
    }

    // MARK: - Properties

        var text: String
        var quantity: Double
        var measure: String
        var food: String
        var weight: Double
        var foodCategory: String
        var image: String

    // MARK: - Initializers

    init(
        text: String,
        quantity: Double,
        measure: String,
        food: String,
        weight: Double,
        foodCategory: String,
        image: String
    ) {
        self.text = text
        self.quantity = quantity
        self.measure = measure
        self.food = food
        self.weight = weight
        self.foodCategory = foodCategory
        self.image = image
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)
        quantity = try container.decode(Double.self, forKey: .quantity)
        measure = try container.decode(String.self, forKey: .measure)
        food = try container.decode(String.self, forKey: .food)
        weight = try container.decode(Double.self, forKey: .weight)
        foodCategory = try container.decode(String.self, forKey: .foodCategory)
        image = try container.decode(String.self, forKey: .image)
    }

    // MARK: - Encoding

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(measure, forKey: .measure)
        try container.encode(food, forKey: .food)
        try container.encode(weight, forKey: .weight)
        try container.encode(foodCategory, forKey: .foodCategory)
        try container.encode(image, forKey: .image)

    }

}
