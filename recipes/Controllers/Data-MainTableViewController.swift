//
//  Data-MainTableViewController.swift
//  recipes
//
//  Created by safwa salem on 2/4/22.
//

import UIKit
import Alamofire

extension MainTableViewController {
    func quantity(forType: Recipe.RecipeType) -> Int {
        var quantity = 0
        for recipe in recipes{
            for healthLabel in recipe.healthLabels! {
                if healthLabel == Recipe.recipeTypeName(forType: forType) {
                    quantity += 1
                }
            }
        }

        return quantity
    }
    
    func recipe(forIndexPath: IndexPath) -> Recipe {
        var recipe: Recipe!                    
        let quantityForLowSugar = quantity(forType: Recipe.RecipeType.lowSugar)

            switch forIndexPath.section {
            case Recipe.RecipeType.lowSugar.rawValue - 1:
                recipe = recipes[forIndexPath.row]
            case Recipe.RecipeType.vegan.rawValue - 1:
                recipe = recipes[forIndexPath.row + quantityForLowSugar]
            case Recipe.RecipeType.keto.rawValue - 1:
                let quantityForVegan = quantity(forType: Recipe.RecipeType.vegan)
                recipe = recipes[forIndexPath.row + quantityForLowSugar + quantityForVegan]
            default: break
            }
            
            return recipe
        }
    

//    func fetchRecipes(searchString: String) {
//      let parameters: [String: String] = ["app_id": "900da95e", "app_key":  "40698503668e0bb3897581f4766d77f9", "q": searchString]
//
//        print("parameters", parameters)
//    AF.request("https://api.edamam.com/search", parameters: parameters).validate().responseDecodable(of: RecipesResponse.self) { (response) in
//      guard let recipesResponse = response.value else { return }
//        print("recipesResponse", recipesResponse)
//        let recipeDataSources: [RecipeDataSource] = recipesResponse.hits ?? [RecipeDataSource]()
//        let recipesList: [Recipe] = recipeDataSources.map { $0.recipe! }
//        self.recipes = recipesList
//        self.tableView.reloadData()
//    }
//  } 
    
    func setupDataSource() {
        recipes = [
            Recipe(
                    uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_b79327d05b8e5b838ad6cfd9576b30b6",
                    label: "Chicken Vesuvio",
                    image: "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg",
                    source: "Serious Eats",
                    url: "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html",
                    shareAs: "http://www.edamam.com/recipe/chicken-vesuvio-b79327d05b8e5b838ad6cfd9576b30b6/chicken",
                    yield: 4.0,
                    dietLabels: [
                        "Low-Carb"
                    ],
                        healthLabels :  [
                        "Dairy-Free",
                        "Gluten-Free",
                        "Wheat-Free",
                        "Egg-Free",
                        "Peanut-Free",
                        "Tree-Nut-Free",
                        "Soy-Free",
                        "keto-friendly",
                        "Shellfish-Free",
                        "Pork-Free",
                        "Red-Meat-Free",
                        "Crustacean-Free",
                        "Celery-Free",
                        "Mustard-Free",
                        "Sesame-Free",
                        "Lupine-Free",
                        "Mollusk-Free",
                        "Kosher"
                    ],
                        cautions : [
                        "Sulfites"
                    ],
                        ingredientLines : [
                        "1/2 cup olive oil",
                        "5 cloves garlic, peeled",
                        "2 large russet potatoes, peeled and cut into chunks",
                        "1 3-4 pound chicken, cut into 8 pieces (or 3 pound chicken legs)",
                        "3/4 cup white wine",
                        "3/4 cup chicken stock",
                        "3 tablespoons chopped parsley",
                        "1 tablespoon dried oregano",
                        "Salt and pepper",
                        "1 cup frozen peas, thawed"
                    ],
                   ingredients: nil,
                        calories : 4228.043058200812,
                        totalWeight : 2976.8664549004047,
                        totalTime : 60.0,
                        cuisineType : [
                        "american"
                    ],
                        mealType :  [
                        "lunch/dinner"
                    ],
                        dishType : [
                        "main course"
                        ],
                   digest: nil
                ),
            Recipe(
                    uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_b79327d05b8e5b838ad6cfd9576b30b6",
                    label: "Chicken Vesuvio",
                    image: "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg",
                    source: "Serious Eats",
                    url: "http://www.seriouseats.com/recipes/2011/12/chicken-vesuvio-recipe.html",
                    shareAs: "http://www.edamam.com/recipe/chicken-vesuvio-b79327d05b8e5b838ad6cfd9576b30b6/chicken",
                    yield: 4.0,
                    dietLabels: [
                        "Low-Carb"
                    ],
                        healthLabels :  [
                        "vegan",
                        "Gluten-Free",
                        "Wheat-Free",
                        "Egg-Free",
                        "Peanut-Free",
                        "Tree-Nut-Free",
                        "Soy-Free",
                        "Fish-Free",
                        "Shellfish-Free",
                        "Pork-Free",
                        "Red-Meat-Free",
                        "Crustacean-Free",
                        "Celery-Free",
                        "Mustard-Free",
                        "Sesame-Free",
                        "Lupine-Free",
                        "Mollusk-Free",
                        "Kosher"
                    ],
                        cautions : [
                        "Sulfites"
                    ],
                        ingredientLines : [
                        "1/2 cup olive oil",
                        "5 cloves garlic, peeled",
                        "2 large russet potatoes, peeled and cut into chunks",
                        "1 3-4 pound chicken, cut into 8 pieces (or 3 pound chicken legs)",
                        "3/4 cup white wine",
                        "3/4 cup chicken stock",
                        "3 tablespoons chopped parsley",
                        "1 tablespoon dried oregano",
                        "Salt and pepper",
                        "1 cup frozen peas, thawed"
                    ],
                   ingredients: nil,
                        calories : 4228.043058200812,
                        totalWeight : 2976.8664549004047,
                        totalTime : 60.0,
                        cuisineType : [
                        "american"
                    ],
                        mealType :  [
                        "lunch/dinner"
                    ],
                        dishType : [
                        "main course"
                        ],
                   digest: nil
                ),
        ]
    }
    
}
