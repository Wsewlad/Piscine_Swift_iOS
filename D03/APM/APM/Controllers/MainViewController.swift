//
//  ViewController.swift
//  APM
//
//  Created by Vladyslav FIL on 7/6/19.
//  Copyright © 2019 Vladyslav FIL. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    //Initiate variables
    let reuseCellIdentifier: String = "ImageCollectionViewCell"
    let showImageSegueIdentifier: String =  "ShowImageSegue"
    
    private var imagesUrl: [String] = ["https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/pia23239.jpg","https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/pia23178.jpg", "https://www.youtube.com/watch?v=Q4R2hGU9gVo", "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/pia23077-16.jpg", "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/pia23047_0.jpg", "https://images.unsplash.com/photo-1465188466731-618dfc07a57d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2250&q=80", "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/46856594435_206c773b5a_o.jpg", "https://images.unsplash.com/photo-1469212044023-0e55b4b9745a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2255&q=80", "https://images.unsplash.com/photo-1472405044831-bb7c502fd2d7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3267&q=80", "https://images.unsplash.com/photo-1516913508865-558a64071d82?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2250&q=80", "https://images.unsplash.com/photo-1516912481808-3406841bd33c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1283&q=80"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Set number of sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Set number of items
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesUrl.count
    }
    
    //Create cells using reuseCellIdentifier
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseCellIdentifier, for: indexPath) as! ImageCollectionViewCell
        let url: URL = URL(string: imagesUrl[indexPath.row])!
        
        //Asynchronous load image using URL and set it to Cell, if loading failed show Alert message
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.activityIndicator.hidesWhenStopped = true
                        cell.activityIndicator.stopAnimating()
                        cell.imageView.image = image
                    }
                } else {
                    let alert = UIAlertController(title: "Error", message: "Cannot acces to \(url)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                    DispatchQueue.main.async {
                        cell.activityIndicator.hidesWhenStopped = true
                        cell.activityIndicator.stopAnimating()
                        cell.imageView.image = UIImage(named: "placeholder")
                    }
                }
            }
        }
        return cell
    }
    
    //Get Cell and transfer its Image using Segue to DisplayImageViewController
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        performSegue(withIdentifier: showImageSegueIdentifier, sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showImageSegueIdentifier {
            if let vc = segue.destination as? DisplayImageViewController {
                if let cell = sender as? ImageCollectionViewCell {
                    vc.image = cell.imageView.image
                }
            }
        }
    }
}

