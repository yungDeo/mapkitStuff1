//
//  DetailController.swift
//  mapkitStuff
//
//  Created by MCS Devices on 1/5/18.
//  Copyright © 2018 MCS Devices. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var vincinity: UILabel!
    @IBOutlet weak var openNow: UILabel!
    
    
    var detail:Details?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = detail?.name
        vincinity.text = detail?.vincinity
        if detail?.opennow ?? false   {
            openNow.text = "open"
        }
        else {
            openNow.text = "closed"
        }
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
