//
//  Updating-MainTableViewController.swift
//  recipes
//
//  Created by safwa salem on 2/4/22.
//

import UIKit

extension MainTableViewController: UISearchResultsUpdating {
    
    private func findMatches(searchString: String) -> NSCompoundPredicate {
        var searchItemsPredicate = [NSPredicate]()
        
        let titleExpression = NSExpression(forKeyPath: Recipe.ExpressionKeys.label.rawValue)
        let searchStringExpression = NSExpression(forConstantValue: searchString)
        
        let titleSearchComparisonPredicate =
        NSComparisonPredicate(leftExpression: titleExpression,
                              rightExpression: searchStringExpression,
                              modifier: .direct,
                              type: .contains,
                              options: [.caseInsensitive, .diacriticInsensitive])
        
        searchItemsPredicate.append(titleSearchComparisonPredicate)
     
        var finalCompoundPredicate: NSCompoundPredicate!
    
        // Handle the scoping.
        let selectedScopeButtonIndex = searchController.searchBar.selectedScopeButtonIndex

        if selectedScopeButtonIndex > 0 {
            if !searchItemsPredicate.isEmpty {
                let compPredicate1 = NSCompoundPredicate(orPredicateWithSubpredicates: searchItemsPredicate)
                let compPredicate2 = NSPredicate(format: "(SELF.type == %ld)", selectedScopeButtonIndex)

                finalCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [compPredicate1, compPredicate2])
            } else {
                finalCompoundPredicate = NSCompoundPredicate(format: "(SELF.type == %ld)", selectedScopeButtonIndex)
            }
        } else {
            finalCompoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: searchItemsPredicate)
        }

        return finalCompoundPredicate
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchResults = recipes
        
        let whitespaceCharacterSet = CharacterSet.whitespaces
        
        let strippedString =
            searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        
        let searchItems = strippedString.components(separatedBy: " ") as [String]

        //        TODO:  complete Predications
        let andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
            findMatches(searchString: searchString)
        }
        let finalCompoundPredicate =
            NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)
                
        let filteredResults = searchResults.filter { finalCompoundPredicate.evaluate(with: $0) }

        if let resultsController = searchController.searchResultsController as? ResultsTableController {
            resultsController.filteredRecipes = filteredResults
            resultsController.tableView.reloadData()

            resultsController.resultsLabel.text = resultsController.filteredRecipes.isEmpty ?
                NSLocalizedString("NoItemsFoundTitle", comment: "") :
                String(format: NSLocalizedString("Items found: %ld", comment: ""),
                       resultsController.filteredRecipes.count)
        }
    }
    
}

