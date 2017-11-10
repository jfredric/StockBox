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
    
    override func viewWillAppear(_ animated: Bool) {
        var currentSubtotal = 0.0
        var currentTax = 0.0
        var currentTotal = 0.0
        for Product in ShoppingCart.sharedInstance.shoppingCartArray {
           currentSubtotal += Double(Product.0.price)
        }
       
        subTitleLbl.text = "$\(currentSubtotal)"
        currentTax = currentSubtotal * 0.09
        taxLbl.text = "$\(currentTax)"
        currentTotal = currentTax + currentSubtotal
        totalLbl.text = "$ \(currentTotal)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingCart.sharedInstance.shoppingCartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "checkOutCell") as? CheckOutTableViewCell else {
            fatalError("The World Is Ending")
        }
        let productPrice = ShoppingCart.sharedInstance.shoppingCartArray[indexPath.row].0.price
        let numOfProducts = ShoppingCart.sharedInstance.shoppingCartArray[indexPath.row].1
        let totalPrice = (productPrice * Double(numOfProducts))
        if ShoppingCart.sharedInstance.shoppingCartArray[indexPath.row].0.imagesURLs.count > 0 {
            let productImageURL = URL(string: ShoppingCart.sharedInstance.shoppingCartArray[indexPath.row].0.imagesURLs[0])
            let data = try? Data(contentsOf: productImageURL!)
            cell.productImage.image = UIImage(data: data!)
        } else{
            cell.productImage.image = #imageLiteral(resourceName: "quickadd")
        }
        //################################
        //################################
        //################################
        //################################
        //################################
        //################################
        // Bug
        // quantity's and totals are wrong in the cells
        cell.productPrice.text = "$\(productPrice)"
        cell.productTitle.text = ShoppingCart.sharedInstance.shoppingCartArray[indexPath.row].0.name
        cell.quantityNum.text = "\(totalPrice)"
        cell.totalLBl.text = "$\(totalPrice)"
        return cell
    }

    @IBAction func checkOutBtnPressed(_ sender: Any) {
        //################################
        //################################
        //################################
        //################################
        //################################
        //################################
        // Crash
        // FINDING NIL AND CRASHING... I think it is because it is failing to convert the totalLbl to a double. It seems like the string has a $ at the front. I don't know how it is getting in there.
        print(AppUser.sharedInstance.balance)
        print(Double(totalLbl.text!)!)
        AppUser.sharedInstance.balance -= Double(totalLbl.text!)!
    }
    
    
}
