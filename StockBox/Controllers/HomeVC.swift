//
//  HomeVC.swift
//  StockBox
//
//  Created by Jared Sobol on 10/25/17.
//  Copyright © 2017 Appmaker. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.unselectedItemTintColor = UNSELECTEDTABITEMSCOLOR
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "ProductTVCell", bundle: nil), forCellReuseIdentifier: "ProductTVCell-ID")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                //AppUser does not load user quick enough, so lets do this...
                let userInfoRef = AppDatabase.userInfoRootRef.child((user?.uid)!)
                userInfoRef.child("account").observeSingleEvent(of: .value, with: { (snapshot) in
                    let account = snapshot.value as! String
                    if account == AppUser.AccountType.vendor.rawValue {
                        // current user is vendor, segue to vendor view
                        // userToVendorSegue
                        self.performSegue(withIdentifier: "userToVendorSegue", sender: self)
                    }
                })
            }
            // gets the root profile view controller from the tab bar controller
            if let profileVC = self.tabBarController?.viewControllers![2] {
                // set the profilevc tab bar item based on login status
                if user != nil {
                    // user is logged in
                    // set the tab bar icon
                    let profileTabBarItem: UITabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile-tab"), selectedImage: UIImage(named: "profile-tab"))
                    profileVC.tabBarItem = profileTabBarItem
                } else {
                    // user is not logged in
                    // set the tab bar icon
                    let loginTabBarItem: UITabBarItem = UITabBarItem(title: "Login", image: UIImage(named: "login-tab"), selectedImage: UIImage(named: "login-tab"))
                    profileVC.tabBarItem = loginTabBarItem
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
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
