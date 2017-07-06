//
//  ListViewController.swift
//  Spotify-Basic
//
//  Created by Mehul  Singhal  on 07/07/17.
//  Copyright © 2017 Mehul  Singhal . All rights reserved.
//

import UIKit
import Alamofire

struct post
{
    let image : UIImage!
    let name: String!
}


class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts = [post]()
    
    typealias JSONstandards = [String: AnyObject]
    
    var searchURL = "https://api.spotify.com/v1/search?"

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        callAlamo(url: searchURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callAlamo(url: String)
    {
        
        let parameters = ["q":"Shawn Mendes","type":"track"]
        let headers = ["Accept":"application/json", "Authorization":"Authorization: Bearer BQCUqf832HFULhwC7Hj3Fo9TxXY36y0il9YFXfdNZMMDwweT2MA4qf_SUDpX9IJqRf4TSnU6UnTK5O4qJBvYXiysO-OBKEcUGGymR8EEp-s6nlxfPYdCZDLVCfql1OV_xbwLO7_Gh_SkQ8gfYsH0AqsFuiDnFQwaSQAjDpivbKmGz6ckFXnBtcH3nBUs0hDGVezlxUjHJqTb9mC0YnHGAgyHvPR2Vrkhg2tB13yTBPN26Hq5Sf2X9ufQka9G9Olp_ONMr46OAEYkeUX39IfDt30Vk2roNeHRl0OJfvD2_ji4KnT-WBZNH1jZiBvmkZLssYg"]
        Alamofire.request(url, method: .get, parameters: parameters, headers: headers).response(completionHandler:{
            
            response in
            
            self.parseData(JSONdata: response.data!)
            
        })
    }
    
    
    func parseData (JSONdata: Data)
    {
        
        do{
            var readAbleJSON = try JSONSerialization.jsonObject(with: JSONdata, options: .mutableContainers) as! JSONstandards
            print(readAbleJSON)
            
            if let tracks =  readAbleJSON["tracks"] as? JSONstandards{
                if let items = tracks["items"] as? [JSONstandards]{
                    for i in 0..<items.count{
                        let item = items[i]
                        let name = item["name"] as! String
                        if let album = item["Album"] as? JSONstandards{
                            
                            if let images = album["images"] as? [JSONstandards]{
                                let myImage = images[0]
                                let myImageURL = URL(string: myImage["url"] as! String)
                                let myImageData = NSData(contentsOf: myImageURL!)
                                
                                let mainImage = UIImage(data: myImageData as! Data)
                                
                                posts.append(post.init(image: mainImage, name: name))
                                self.tableView.reloadData()
                            }
                        }
                    }
                    
                }}
        }
        catch{
            print(error)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let mainImageView = cell.viewWithTag(2) as! UIImageView
        mainImageView.image = posts[indexPath.row].image
        let mainLabel = cell.viewWithTag(1) as! UILabel
        mainLabel.text = posts[indexPath.row].name
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        
        let vc = segue.destination as! AudioVC
        
        vc.image = posts[indexPath!].image
        vc.mainSongTitle = posts[indexPath!].name
    }
    
    
    

    

   

}
