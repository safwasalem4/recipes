//
//  ResultsTableController.swift
//  recipes
//
//  Created by safwa salem on 2/4/22.
//

import UIKit

class ResultsTableController: UITableViewController {
    
    let tableViewCellIdentifier = "cellID"
    
    var filteredRecipes = [Recipe]()
    
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "TableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: tableViewCellIdentifier)
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRecipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        let recipe = filteredRecipes[indexPath.row]

        cell.textLabel?.text = recipe.label
        cell.textLabel?.text = recipe.source
        cell.textLabel?.text = recipe.healthLabels!.joined(separator: ", ")

        return cell
    }
}
