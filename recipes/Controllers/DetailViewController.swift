//
//  DetailViewController.swift
//  recipes
//
//  Created by safwa salem on 2/4/22.
//

import UIKit

class DetailViewController: UIViewController, UIGestureRecognizerDelegate {
   
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            image: UIImage(named: "back"),
//            style: .plain,
//            target: self,
//            action: #selector(popToPrevious)
//        )
//       
//        }

    // @objc private func popToPrevious() {
    //     // our custom stuff
    //     navigationController?.popViewController(animated: true)
    // }
    
    // Constants for state restoration.
    private static let restoreRecipe = "restoreRecipeKey"
    
    // MARK: - Properties

    var recipe: Recipe!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredients: UILabel!    
    @IBAction func websiteButton(_ sender: Any) {
    }
    
    // MARK: - Initialization

    class func detailViewControllerForProduct(_ recipe: Recipe) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController =
            storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        
        if let detailViewController = viewController as? DetailViewController {
            detailViewController.recipe = recipe
        }
        
        return viewController
    }
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let url = URL (string: recipe.image!)
        recipeImage.layer.cornerRadius = 16
        recipeImage.loadUrl(url: url!)
        
        titleLabel.text = recipe.label
        ingredients.text = recipe.ingredientLines?.joined(separator: "\n")
    }

}

// MARK: - load image from url in UIImageView

extension UIImageView {
    func loadUrl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

// MARK: - UIStateRestoration

extension DetailViewController {
	
	override func encodeRestorableState(with coder: NSCoder) {
		super.encodeRestorableState(with: coder)
		
		// Encode the recipe.
		coder.encode(recipe, forKey: DetailViewController.restoreRecipe)
	}
	
	override func decodeRestorableState(with coder: NSCoder) {
		super.decodeRestorableState(with: coder)
		
		// Restore the recipe.
		if let decodedRecipe = coder.decodeObject(forKey: DetailViewController.restoreRecipe) as? Recipe {
			recipe = decodedRecipe
		} else {
			fatalError("A recipe did not exist. In your app, handle this gracefully.")
		}
	}
	
}
