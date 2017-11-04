//
//  HomeVC.swift
//  StockBox
//
//  Created by Jared Sobol on 10/25/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
//        self.tabBarController?.tabBar.barTintColor = MAINORANGECOLOR
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.black
//        self.navigationController?.navigationBar.barTintColor = MAINORANGECOLOR

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "ProductTVCell", bundle: nil), forCellReuseIdentifier: "ProductTVCell-ID")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTVCell-ID") as? ProductTVCell else {
            fatalError("The World Is Ending")
        }
        cell.productPrice.text = "$9.85"
        cell.productTitle.text = "Ipad Pro"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "homeToDetailSegue", sender: nil)
    }
    


}
