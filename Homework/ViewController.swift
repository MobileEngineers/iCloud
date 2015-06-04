//
//  ViewController.swift
//  Homework
//
//  Created by Isaías Lima on 02/06/15.
//  Copyright (c) 2015 Mobile Engineers. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, CloudKitHelperDelegate {

    let model = CloudKitHelper.sharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {        super.didReceiveMemoryWarning()        }
    
    func modelUpdated()
    {
        refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    func errorUpdating(error: NSError)
    {
        let message = error.localizedDescription
        let alert = UIAlertView(title: "Error Loading Establishments",
            message: message, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }


}

