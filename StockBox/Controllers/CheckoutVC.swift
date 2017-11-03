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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "CheckOutTableViewCell", bundle: nil), forCellReuseIdentifier: "checkOutCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "checkOutCell") as? CheckOutTableViewCell else {
            fatalError("The World Is Ending")
        }
        cell.productPrice.text = "10.89"
        cell.productTitle.text = "Tumeric"
        cell.quantityNum.text = "1"
        cell.totalLBl.text = "10.89"
        return cell
    }

    @IBAction func checkOutBtnPressed(_ sender: Any) {
        
    }
    
}
