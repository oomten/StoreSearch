//
//  DetailViewController.swift
//  StoreSearch
//
//  Created by Denis Nurislamov on 29.11.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Constants and Variables
    var searchResult: SearchResult!
    var downloadTask: URLSessionDownloadTask?
    
    
    //MARK: - Outlets
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var artWorkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!

    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        popupView.layer.cornerRadius = 10
        
        let gestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(close))
        gestureRecognizer.cancelsTouchesInView = false
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
        
        if searchResult != nil {
            updateUI()
        }
        
        // Gradient background view
        view.backgroundColor = UIColor.clear
        let dimmingView = GradientView(frame: CGRect.zero)
        dimmingView.frame = view.bounds
        view.insertSubview(dimmingView, at: 0)
        
        
    }
    
    //MARK: - Actions
    @IBAction func close() {
        dismiss(animated: true)
    }
    
    @IBAction func openInStore() {
        if let url = URL(string: searchResult.storeURL) {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - Helper Methods
    func updateUI() {
        nameLabel.text = searchResult.name
        
        if searchResult.artist.isEmpty {
            artistNameLabel.text = "Unknown"
        } else {
            artistNameLabel.text = searchResult.artist
        }
        
        kindLabel.text = searchResult.type
        genreLabel.text = searchResult.genre
        
        // Show price
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = searchResult.currency
        
        let priceText: String
        if searchResult.price == 0 {
            priceText = "Free"
        } else if let text = formatter.string(from: searchResult.price as NSNumber) {
            priceText = text
        } else {
            priceText = ""
        }
        
        priceButton.setTitle(priceText, for: .normal)
        
        // Get image
        if let LargeURL = URL(string: searchResult.imageLarge) {
            downloadTask = artWorkImageView.loadImage(url: LargeURL)
        }
    }
    
    // Cancel the image download if the user closes the pop-up before the image has been downloaded completely:
    deinit {
        print("deinit \(self)")
        downloadTask?.cancel()
    }
    
    // init for animation
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        transitioningDelegate = self
    }

}

//MARK: - Extensions

extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
}

// Animation
extension DetailViewController: UIViewControllerTransitioningDelegate {
    // Open
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BounceAnimationController()
    }
    // Close
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideOutAnimationController()
    }
}
