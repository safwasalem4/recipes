//
//  MainTableViewController.swift
//  recipes
//
//  Created by safwa salem on 2/4/22.
//

import UIKit
import Alamofire

class MainTableViewController: UITableViewController {

    let tableViewCellIdentifier = "cellID"
    
    // MARK: - Properties
    
    var recipes = [Recipe]()
    var searchController: UISearchController!    
    private var resultsTableController: ResultsTableController!
    var restoredState = SearchControllerRestorableState()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: tableViewCellIdentifier)
        
        resultsTableController =
            self.storyboard?.instantiateViewController(withIdentifier: "ResultsTableController") as? ResultsTableController
        resultsTableController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self        
        searchController.searchBar.scopeButtonTitles = [Recipe.recipeTypeName(forType: .all),Recipe.recipeTypeName(forType: .lowSugar), Recipe.recipeTypeName(forType: .keto), Recipe.recipeTypeName(forType: .vegan)]

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
        
        setupDataSource()
//        fetchRecipes(searchString: "vegan")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if restoredState.wasActive {
            searchController.isActive = restoredState.wasActive
            restoredState.wasActive = false
            
            if restoredState.wasFirstResponder {
                searchController.searchBar.becomeFirstResponder()
                restoredState.wasFirstResponder = false
            }
        }
    }

}

// MARK: - UITableViewDelegate

extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe: Recipe!
        
        if tableView === self.tableView {
            selectedRecipe = recipe(forIndexPath: indexPath)
        } else {
            selectedRecipe = resultsTableController.filteredRecipes[indexPath.row]
        }
        
        let detailViewController = DetailViewController.detailViewControllerForProduct(selectedRecipe)
        navigationController?.pushViewController(detailViewController, animated: true)

        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

// MARK: - UITableViewDataSource

extension MainTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchController.searchBar.scopeButtonTitles!.count - 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        return ""
    }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       var numInSection = 0

       switch section {
       case 0:
           numInSection = quantity(forType: Recipe.RecipeType.lowSugar)
       case 1:
           numInSection = quantity(forType: Recipe.RecipeType.keto )
       case 2:
           numInSection = quantity(forType: Recipe.RecipeType.vegan)
       default: break
       }

       return numInSection
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableCell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as! TableCell
        let cellRecipe = recipe(forIndexPath: indexPath)
        
        cell.recipeTitle?.text = cellRecipe.label
        cell.recipeSource?.text = cellRecipe.source
        cell.healthLabel?.text =  cellRecipe.healthLabels!.joined(separator: ", ")

        let url = URL(string: cellRecipe.image ?? "")!
        if let data = try? Data(contentsOf: url) {
            cell.imageView?.image = UIImage(data: data)
            cell.imageView!.layer.cornerRadius = 20
            cell.imageView!.clipsToBounds = true
            let image = UIImage(data: data)
            cell.imageView?.image = image
        }

		return cell
	}
}

// MARK: - UISearchBarDelegate

extension MainTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        updateSearchResults(for: searchController)
    }
    
}
