//
//  SEStartVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 20/10/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SEStartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let idOfUser = UserDefaults.standard.integer(forKey: "id")
        //        let idOfUsers = UserDefaults.standard.string(forKey: "id")
        
        if idOfUser == 0  {
            
        } else {
            WAShareHelper.goToHomeController(vcIdentifier: "SEEventListVC", storyboardName: "Home", navController: self.navigationController!, leftMenuIdentifier: "SELeftSieMenuVC")
            
        }

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSign_PRessed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SELoginVC") as? SELoginVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
   
    @IBAction func btnCreateAccount_Pressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEStartViewController") as? SEStartViewController
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    

}
