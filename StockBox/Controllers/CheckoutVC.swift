//
//  CheckoutVC.swift
//  StockBox
//
//  Created by Jared Sobol on 11/2/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit

class CheckoutVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shippingAddressTextField: UITextField!
    @IBOutlet weak var billingAddressTextField: UITextField!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    var productsToPurchase = [Product]()
    var productCountArray = [Int]()
    let productCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "CheckOutTableViewCell", bundle: nil), forCellReuseIdentifier: "checkOutCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var currentSubtotal = 0.0
        var currentTax = 0.0
        var currentTotal = 0.0
        for Product in productsToPurchase {
           currentSubtotal += Double(Product.price)
        }
       
        subTitleLbl.text = "$\(currentSubtotal)"
        currentTax = currentSubtotal * 0.9
        taxLbl.text = "$\(currentTax)"
        currentTotal = currentTax + currentSubtotal
        totalLbl.text = "$ \(currentTotal)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "checkOutCell") as? CheckOutTableViewCell else {
            fatalError("The World Is Ending")
        }
        cell.productPrice.text = "10.89"
        cell.productTitle.text = "Tumeric"
        cell.totalLBl.text = "1"
        return cell
    }
    
    @IBAction func checkOutBtnPressed(_ sender: Any) {
        AppUser.sharedInstance.balance -= Double(totalLbl.text!)!
    }
    
    
}
