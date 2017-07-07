//
//  AudioVC.swift
//  Spotify-Basic
//
//  Created by Mehul  Singhal  on 07/07/17.
//  Copyright © 2017 Mehul  Singhal . All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class AudioVC : UIViewController {
    
    var image = UIImage()
    var mainSongTitle = String()
    var mainSongURL = String()
    
    @IBOutlet weak var playpausebtn: UIButton!
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var songTitle: UILabel!
    
    override func viewDidLoad() {
        
        
        songTitle.text = mainSongTitle
        background.image = image
        mainImageView.image = image
        
        if mainSongURL == "sdfjklasdjlf"
        {
            playpausebtn.setTitle("NA", for: .normal)
        }
        else
        {
            
            downloadFileFromURl(url: URL(string: mainSongURL)!)
            
            playpausebtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            playpausebtn.imageView?.clipsToBounds = true
            playpausebtn.imageView?.layer.cornerRadius = 32
        }
    }
        
    
    func downloadFileFromURl(url: URL)
    {
        var downloadTask = URLSessionDownloadTask()
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: {
            
            customURL, response, error in
            
            self.play(url: customURL!)
            
        })
        downloadTask.resume()

    }
    
    
    
    func play(url: URL)
    {
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
        }
        catch{
            print(error)
        }
    
    }
    
    @IBAction func playpausebtnaction(_ sender: Any) {
        
        if player.isPlaying
        {
            player.pause()
            playpausebtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            playpausebtn.imageView?.clipsToBounds = true
            playpausebtn.imageView?.layer.cornerRadius = 32
        }
        else
        {
            player.play()
            playpausebtn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            playpausebtn.imageView?.clipsToBounds = true
            playpausebtn.imageView?.layer.cornerRadius = 32
        }
        
    }
    
    override var prefersStatusBarHidden: Bool
        {
        return true
    }
    
    
}
