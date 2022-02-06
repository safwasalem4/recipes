//
//  Updating-MainTableViewController.swift
//  recipes
//
//  Created by safwa salem on 2/4/22.
//

import UIKit

extension MainTableViewController: UISearchResultsUpdating {
    
    private func findMatches(searchString: String) -> NSCompoundPredicate {
        print(";;;;;findMatches;;;;;;;;")
        var searchItemsPredicate = [NSPredicate]()

        let titleExpression = NSExpression(forKeyPath: Recipe.ExpressionKeys.label.rawValue)
        print("titleExpression", titleExpression)
        
        let searchStringExpression = NSExpression(forConstantValue: searchString)
        print("searchStringExpression", searchStringExpression)
        
        let titleSearchComparisonPredicate =
        NSComparisonPredicate(leftExpression: titleExpression,
                              rightExpression: searchStringExpression,
                              modifier: .direct,
                              type: .contains,
                              options: [.caseInsensitive, .diacriticInsensitive])
        print("titleSearchComparisonPredicate", titleSearchComparisonPredicate)
        
        searchItemsPredicate.append(titleSearchComparisonPredicate)
        
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .none
//        numberFormatter.formatterBehavior = .default
//
//        if let targetNumber = numberFormatter.number(from: searchString) {
//            let targetNumberExpression = NSExpression(forConstantValue: targetNumber)
//            let yearIntroducedExpression = NSExpression(forKeyPath: Recipe.ExpressionKeys.yield.rawValue)
//            let yearIntroducedPredicate =
//                NSComparisonPredicate(leftExpression: yearIntroducedExpression,
//                                      rightExpression: targetNumberExpression,
//                                      modifier: .direct,
//                                      type: .equalTo,
//                                      options: [.caseInsensitive, .diacriticInsensitive])
//            searchItemsPredicate.append(yearIntroducedPredicate)
//
//            let lhs = NSExpression(forKeyPath: Recipe.ExpressionKeys.yield.rawValue)
//
//            let finalPredicate =
//                NSComparisonPredicate(leftExpression: lhs,
//                                      rightExpression: targetNumberExpression,
//                                      modifier: .direct,
//                                      type: .equalTo,
//                                      options: [.caseInsensitive, .diacriticInsensitive])
//
//            searchItemsPredicate.append(finalPredicate)
//        }
                
        var finalCompoundPredicate: NSCompoundPredicate!
        print("finalCompoundPredicate", finalCompoundPredicate)
    
        // Handle the scoping.
        let selectedScopeButtonIndex = searchController.searchBar.selectedScopeButtonIndex
        print("selectedScopeButtonIndex", selectedScopeButtonIndex)
        print("-------------==========")
        print("searchItemsPredicate", searchItemsPredicate)
        print("!searchItemsPredicate.isEmpty", !searchItemsPredicate.isEmpty)
        
        if selectedScopeButtonIndex > 0 {
            print("------1-------")

//            if !searchItemsPredicate.isEmpty {
            if  !searchItemsPredicate.isEmpty {
                print("------2-------")
                let compPredicate1 = NSCompoundPredicate(orPredicateWithSubpredicates: searchItemsPredicate)
                print("compPredicate1", compPredicate1)
                
                let compPredicate2 = NSPredicate(format: "(SELF.type == %ld)", selectedScopeButtonIndex)
                print("compPredicate2", compPredicate2)

                finalCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [compPredicate1, compPredicate2])
            } else {
                print("------3-------")
                finalCompoundPredicate = NSCompoundPredicate(format: "(SELF.type == %ld)", selectedScopeButtonIndex)
            }
        } else {
            print("------4-------")
            finalCompoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: searchItemsPredicate)
        }

        print("finalCompoundPredicate", finalCompoundPredicate ?? "")
        return finalCompoundPredicate
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("------updateSearchResults------")
        let searchResults = recipes
        
        let whitespaceCharacterSet = CharacterSet.whitespaces
        print("whitespaceCharacterSet", whitespaceCharacterSet)
        
        let strippedString =
            searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        print("strippedString", strippedString)
        
        let searchItems = strippedString.components(separatedBy: " ") as [String]
        print("searchItems", searchItems)
        
        let andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
            findMatches(searchString: searchString)
        }
        print("andMatchPredicates", andMatchPredicates)
        
        let finalCompoundPredicate =
            NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)
        print("finalCompoundPredicate--------->", finalCompoundPredicate)
//        print("final,,,,,,,--------->", finalCompoundPredicate)
        
        let filteredResults = searchResults.filter { finalCompoundPredicate.evaluate(with: $0) }

        if let resultsController = searchController.searchResultsController as? ResultsTableController {
            resultsController.filteredRecipes = filteredResults
            resultsController.tableView.reloadData() //TODO:

            resultsController.resultsLabel.text = resultsController.filteredRecipes.isEmpty ?
                NSLocalizedString("NoItemsFoundTitle", comment: "") :
                String(format: NSLocalizedString("Items found: %ld", comment: ""),
                       resultsController.filteredRecipes.count)
        }
    }
    
}

