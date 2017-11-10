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
    
    var currentSubtotal = 0.0
    var currentTax = 0.0
    var currentTotal = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "CheckOutTableViewCell", bundle: nil), forCellReuseIdentifier: "checkOutCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currentSubtotal = 0.0
        currentTax = 0.0
        currentTotal = 0.0
        for product in ShoppingCart.sharedInstance.shoppingCartArray {
           currentSubtotal += product.0.price * Double(product.1)
        }
       
        subTitleLbl.text = doubleToCurrencyString(value: currentSubtotal)
        currentTax = currentSubtotal * 0.09
        taxLbl.text = doubleToCurrencyString(value: currentTax)
        currentTotal = currentTax + currentSubtotal
        totalLbl.text = doubleToCurrencyString(value: currentTotal)
        
        tableView.reloadData()
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
        
        cell.productPrice.text = doubleToCurrencyString(value: productPrice)
        cell.productTitle.text = ShoppingCart.sharedInstance.shoppingCartArray[indexPath.row].0.name
        cell.quantityNum.text = String(numOfProducts)
        cell.totalLBl.text = doubleToCurrencyString(value: totalPrice)
        return cell
    }

    @IBAction func checkOutBtnPressed(_ sender: Any) {
        if ShoppingCart.sharedInstance.shoppingCartArray.count == 0 {
            messageAlert(title: "Empty Cart", message: "There are no items in your shopping cart. Please add product before checking out.", from: self)
        } else if currentTotal >= AppUser.sharedInstance.balance && AppUser.sharedInstance.balance != 0.0 {
            messageAlert(title: "Order Placed", message: doubleToCurrencyString(value: currentTotal) + " removed from account balance.", from: self)
            AppUser.sharedInstance.balance -= currentTotal
            // TODO: clear cart
        } else {
            messageAlert(title: "Not Enough Funds", message: "You account balance of " + doubleToCurrencyString(value: AppUser.sharedInstance.balance) + " is too low to place order.", from: self)
        }
        
    }
    
    
}
