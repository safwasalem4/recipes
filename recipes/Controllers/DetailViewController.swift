//
//  DetailViewController.swift
//  recipes
//
//  Created by safwa salem on 2/4/22.
//

import UIKit
//import SafariServices

class DetailViewController: UIViewController, UIGestureRecognizerDelegate
//                                SFSafariViewControllerDelegate
{
    // Constants for state restoration.
    private static let restoreRecipe = "restoreRecipeKey"
    
    // MARK: - Properties

    var recipe: Recipe!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredients: UILabel!    
    @IBAction func websiteButton(_ sender: Any) {
//        openSafariVC()
        let url = NSURL(string: recipe.url ?? "https://www.softxperteg.com/")
        UIApplication.shared.open(url! as URL)
    }

        override func viewDidLoad() {
            super.viewDidLoad()

            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:.action, target: self, action: #selector(shareTapped))
        }
    
    @objc private func shareTapped() {
        let url = NSURL(string: recipe.url ?? "https://www.softxperteg.com/")
        UIApplication.shared.open(url! as URL)
    }
    // MARK: - Initialization

    
//
//    func openSafariVC() {
//        let url = NSURL(string: recipe.url ?? "https://www.softxperteg.com/")
//        let safariVC = SFSafariViewController(url: url! as URL)
//
//        self.present(safariVC, animated: true, completion: nil)
//
//        safariVC.delegate = self
//    }
//
//       func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
//           controller.dismiss(animated: true, completion: nil)
//       }
    
    
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

