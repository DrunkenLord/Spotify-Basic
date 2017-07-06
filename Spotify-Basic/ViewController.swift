//
//  ViewController.swift
//  Spotify-Basic
//
//  Created by Mehul  Singhal  on 06/07/17.
//  Copyright © 2017 Mehul  Singhal . All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {
    
    typealias JSONstandards = [String: AnyObject]
    
    var searchURL = "https://api.spotify.com/v1/search?q=Shawn+Mendes&type=track"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        callAlamo(url: searchURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func callAlamo(url: String)
    {
        Alamofire.request(url).response(completionHandler:{
            
            response in
            
            self.parseData(JSONdata: response.data!)
        
        })
    }
    
    
    func parseData (JSONdata: Data)
    {
    
        do{
            var readAbleJSON = try JSONSerialization.jsonObject(with: JSONdata, options: .mutableContainers) as? JSONstandards
            print(readAbleJSON)
        }
        catch{
            print(error)
        }
    }


}

