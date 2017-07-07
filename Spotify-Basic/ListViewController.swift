//
//  ListViewController.swift
//  Spotify-Basic
//
//  Created by Mehul  Singhal  on 07/07/17.
//  Copyright © 2017 Mehul  Singhal . All rights reserved.
//

import UIKit
import Alamofire

struct post {
    let image : UIImage!
    let name : String!
}

var albumArt : UIImage!

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
        let headers = ["Accept":"application/json", "Authorization":"Bearer BQA-I5IDq7_i50Jpz5qp8eMXqBoUKBFgNPI_B0Xr_F25TpHRlfn0c65IL_G63tNnfZIMELvdyzRv1SYuX9PasJRkJFqeTOZPfl923NCm1SuFrPB_xbk1UnT32YVc4M8_3Ud-4YKmWPBtVZMHpFVPA5l35cKhvgX9D1X7iXW15W0-Zokmvgqu5dXvDkRLPYtNAEXuH1UFwSo7YeFrGI8k4BbK5mnzwB_s-Q6fw72w8anFxFceoyWOMoO49BWo7NyRm6rdZaWSm3oPmqatn1TIw0P1rhQ1HKYzDyyOK5sEJUxFGoabQIRA4wCrbCbpB_kfp1o" ]
        Alamofire.request(url, method: .get, parameters: parameters, headers: headers).response(completionHandler:{
            
            response in
            
            self.parseData(JSONdata: response.data!)
            
        })
    }
    
    
    func parseData (JSONdata: Data)
    {
        
        do{
            var readAbleJSON = try JSONSerialization.jsonObject(with: JSONdata, options: .mutableContainers) as! JSONstandards
            
            if let tracks =  readAbleJSON["tracks"] as? JSONstandards{
                if let items = tracks["items"] as? [JSONstandards]{
                    for i in 0..<items.count{
                        let item = items[i]
                        let name = item["name"] as! String
                        if let album = item["album"] as? JSONstandards{
                            
                            if let images = album["images"] as? [JSONstandards]{
                                let myImage = images[0]
                                let myImageURL = URL(string: myImage["url"] as! String)
                                
                                let myImageData = NSData(contentsOf: myImageURL!)
                                
                                let mainImage = UIImage(data: myImageData as! Data)
                                
                                albumArt = mainImage
                            }
                        }
                        posts.append(post.init(image: albumArt, name: name))
                        
                        print(posts[0])
                        self.tableView.reloadData()
                    }
                    
                }
            }
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
        print(posts.count)
        return posts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let mainImageView = cell?.viewWithTag(2) as! UIImageView
        mainImageView.image = posts[indexPath.row].image
        //print(posts[indexPath.row].image)
        let mainLabel = cell?.viewWithTag(1) as! UILabel
        mainLabel.text = posts[indexPath.row].name
        //print(posts[indexPath.row].name)
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        
        let vc = segue.destination as! AudioVC
        
        vc.image = posts[indexPath!].image
        vc.mainSongTitle = posts[indexPath!].name
    }
    
    override var prefersStatusBarHidden: Bool
        {
        
        return true
    }
    
}
    

    

   


