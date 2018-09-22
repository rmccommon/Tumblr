//
//  ViewController.swift
//  Tumblr
//
//  Created by Sierra Klix on 9/12/18.
//  Copyright © 2018 Ryan McCommon. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var photoTableView: UITableView!
    //Backend Var
    var posts: [[String: Any]] = []
    
    func retrieveTumblrAPIData(){
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                
                // TODO: Get the posts and store in posts property
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                self.posts = responseDictionary["posts"] as! [[String:Any]]
                
                
                // TODO: Reload the table view
                self.photoTableView.reloadData()
            }
        }
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoTableView.dataSource = self
        photoTableView.delegate = self
        photoTableView.rowHeight = 225
        
        retrieveTumblrAPIData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.row]
        if let photos = post["photos"] as? [[String: Any]]{
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            
            cell.postImage.af_setImage(withURL: url!)
            
        }
        
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailsViewController
        let cell = sender as! UITableViewCell
        let indexPath = photoTableView.indexPath(for: cell)!
        let post = self.posts[indexPath.row]
        
        if let photos = post["photos"] as? [[String:Any]]{
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String:Any]
            let urlString = originalSize["url"] as! String
            vc.photoString = urlString
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

