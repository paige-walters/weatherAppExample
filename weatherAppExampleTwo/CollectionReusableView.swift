//
//  CollectionReusableView.swift
//  weatherAppExampleTwo
//
//  Created by Paige Walters on 2/12/16.
//  Copyright © 2016 Paige Walters. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var headerLabel: UILabel!
    
    class var reuseIdentifier: String {
        return "header"
    }
}
