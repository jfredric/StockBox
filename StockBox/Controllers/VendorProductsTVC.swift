//
//  VendorCatalogTVC.swift
//  StockBox
//
//  Created by Joshua Fredrickson on 11/1/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit
import Foundation

class VendorProductsTVC: UITableViewController {
    
    let segueForDetails = "vendorProductDetailsSegue-ID"
    let segueForAdd = "addProductSegue-ID"

    @IBAction func addBarButton(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register table view cell xib
        tableView.register(UINib.init(nibName: ProductTVCell.xibName, bundle: nil), forCellReuseIdentifier: ProductTVCell.reuseIdentifier)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTVCell.reuseIdentifier, for: indexPath) as! ProductTVCell

        // Configure the cell...
        cell.ratingControl.rating = indexPath.row / 5 // to show varying ratting
        cell.productPrice.text = "$" + String(Double(indexPath.row)) //needs text formating
        //cell.productPrice.text = String(format: "$0.00",Double(indexPath.row))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueForDetails, sender: indexPath) // change this to the cell's data object
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // Get the nav controller we are segueing to
        guard let navVC = segue.destination as? UINavigationController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        // Get the final view destination from the nav controller
        guard let productDetailVC = navVC.viewControllers.first as? AddProductImageVC else {
            fatalError("Unexpected view: \(describing: navVC.viewControllers.first) in \(navVC)")
        }
        
        switch segue.identifier! {
        case segueForDetails :
            // set the view elements to be filled with the products data from the modell
            // create/load product model.
            // pass model to detail VC
            //load images here
            print("segueing to product detail view for edit")
        case segueForAdd :
            //add view
            print("segueing to new product detail view")
        default :
            fatalError("Vendor Product View: Did not expect \(segue.identifier ?? "undefined segue")")
        }
    }

}