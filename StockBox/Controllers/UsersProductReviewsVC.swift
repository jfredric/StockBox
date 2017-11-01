//
//  UsersProductReviewsVC.swift
//  StockBox
//
//  Created by Jared Sobol on 10/31/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit

class UsersProductReviewsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "ReviewTVCell", bundle: nil), forCellReuseIdentifier: "ReviewTVCell-ID")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTVCell-ID") as? ReviewTVCell else {
            fatalError("The World Is Ending")
        }
        cell.customerNameLbl.text = "Kelly"
        cell.reviewDescriptionLbl.text = "This product Rocks!!!!"
        return cell
    }
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
