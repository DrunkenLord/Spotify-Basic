//
//  AudioVC.swift
//  Spotify-Basic
//
//  Created by Mehul  Singhal  on 07/07/17.
//  Copyright © 2017 Mehul  Singhal . All rights reserved.
//

import Foundation
import UIKit
class AudioVC : UIViewController {
    
    var image = UIImage()
    var mainSongTitle = String()
    
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var songTitle: UILabel!
    
    override func viewDidLoad() {
        
        
        songTitle.text = mainSongTitle
        background.image = image
        mainImageView.image = image
        
    }
    
    
}
