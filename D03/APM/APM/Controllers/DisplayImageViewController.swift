//
//  DisplayImageViewController.swift
//  APM
//
//  Created by  Vladyslav Fil on 7/7/19.
//  Copyright © 2019 Vladyslav FIL. All rights reserved.
//

import Foundation
import UIKit

class DisplayImageViewController: UIViewController, UIScrollViewDelegate {
    
    var image: UIImage?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        if let img = image {
            imageView.image = img
            scrollView.contentSize = (imageView?.frame.size)!
            scrollView.minimumZoomScale = 0.3
            scrollView.maximumZoomScale = 100
        }
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
