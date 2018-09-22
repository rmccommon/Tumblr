//
//  DetailsViewController.swift
//  Tumblr
//
//  Created by Sierra Klix on 9/19/18.
//  Copyright © 2018 Ryan McCommon. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var photoFromCell: UIImageView!
    var photoString : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: photoString!)
        photoFromCell.af_setImage(withURL: url!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
