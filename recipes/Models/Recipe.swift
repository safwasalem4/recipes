//
//  Recipe.swift
//  recipes
//
//  Created by safwa salem on 2/4/22.
//

import Foundation

class Recipe: NSObject, Codable {

    enum CodingKeys: String, CodingKey {
            case uri
            case label
            case image
            case source
            case url
            case shareAs
            case yield
            case dietLabels
            case healthLabels
            case cautions
            case ingredientLines
            case ingredients
            case calories
            case totalWeight
            case totalTime
            case cuisineType
            case mealType
            case dishType
            case digest
    }

    enum ExpressionKeys: String {
            case uri
            case label
            case image
            case source
            case url
            case shareAs
            case yield
            case dietLabels
            case healthLabels
            case cautions
            case ingredientLines
            case ingredients
            case calories
            case totalWeight
            case totalTime
            case cuisineType
            case mealType
            case dishType
            case digest
    }
    
    enum RecipeType: String {
            case lowSugar = "low-sugar"
            case keto = "keto"
            case vegan = "vegan"
            case all = "all"
        }
    
    
    class func recipeTypeName(forType: RecipeType) -> String {
            switch forType {
            case .lowSugar: return "lowSugar"
            case .keto: return "keto"
            case .vegan: return "vegan"
            case .all: return "All"
            }
        }
    
    // MARK: - Properties

        var uri: String?
        var label: String?
        var image: String?
        var source: String?
        var url: String?
        var shareAs: String?
        var yield : Double?
        var dietLabels : [String]?
        var healthLabels : [String]?
        var cautions : [String]?
        var ingredientLines : [String]?
        var ingredients : [Ingredient]?
        var calories : Double?
        var totalWeight : Double?
        var totalTime : Double?
        var cuisineType : [String]?
        var mealType : [String]?
        var dishType : [String]?
        var digest : [Digest]?


    // MARK: - Initializers

    init(
        uri: String?,
        label: String?,
        image: String?,
        source: String?,
        url: String?,
        shareAs: String?,
        yield : Double?,
        dietLabels : [String]?,
        healthLabels : [String]?,
        cautions : [String]?,
        ingredientLines : [String]?,
        ingredients : [Ingredient]?,
        calories : Double?,
        totalWeight : Double?,
        totalTime : Double?,
        cuisineType : [String]?,
        mealType : [String]?,
        dishType : [String]?,
        digest : [Digest]?
    ) {
        self.uri=uri
        self.label=label
        self.image=image
        self.source=source
        self.url=url
        self.shareAs=shareAs
        self.yield=yield
        self.dietLabels=dietLabels
        self.healthLabels=healthLabels
        self.cautions=cautions
        self.ingredientLines=ingredientLines
        self.ingredients=ingredients
        self.calories=calories
        self.totalWeight=totalWeight
        self.totalTime=totalTime
        self.cuisineType=cuisineType
        self.mealType=mealType
        self.dishType=dishType
        self.digest=digest
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uri = try container.decode(String.self, forKey: .uri)
        label = try container.decode(String.self, forKey: .label)
        image = try container.decode(String.self, forKey: .image)
        source = try container.decode(String.self, forKey: .source)
        url = try container.decode(String.self, forKey: .url)
        shareAs = try container.decode(String.self, forKey: .shareAs)
        yield = try container.decode(Double.self, forKey: .yield)
        dietLabels = try container.decode([String].self, forKey: .dietLabels)
        healthLabels = try container.decode([String].self, forKey: .healthLabels)
        cautions = try container.decode([String].self, forKey: .cautions)
        ingredientLines = try container.decode([String].self, forKey: .ingredientLines)
        ingredients = try container.decode([Ingredient].self, forKey: .ingredients)
        calories = try container.decode(Double.self, forKey: .calories)
        totalWeight = try container.decode(Double.self, forKey: .totalWeight)
        totalTime = try container.decode(Double.self, forKey: .totalTime)
        cuisineType = try container.decode([String].self, forKey: .cuisineType)
        mealType = try container.decode([String].self, forKey: .mealType)
        dishType = try container.decode([String].self, forKey: .dishType)
        digest = try container.decode([Digest].self, forKey: .digest)

    }

    // MARK: - Encoding

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uri, forKey: .uri)
        try container.encode(label, forKey: .label)
        try container.encode(image, forKey: .image)
        try container.encode(source, forKey: .source)
        try container.encode(url, forKey: .url)
        try container.encode(shareAs, forKey: .shareAs)
        try container.encode(yield, forKey: .yield)
        try container.encode(dietLabels, forKey: .dietLabels)
        try container.encode(healthLabels, forKey: .healthLabels)
        try container.encode(cautions, forKey: .cautions)
        try container.encode(ingredientLines, forKey: .ingredientLines)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(calories, forKey: .calories)
        try container.encode(totalWeight, forKey: .totalWeight)
        try container.encode(totalTime, forKey: .totalTime)
        try container.encode(cuisineType, forKey: .cuisineType)
        try container.encode(mealType, forKey: .mealType)
        try container.encode(dishType, forKey: .dishType)
        try container.encode(digest, forKey: .digest)
    }

}
