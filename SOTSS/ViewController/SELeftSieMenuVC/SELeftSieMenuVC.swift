//
//  SELeftSieMenuVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 06/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SELeftSieMenuVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    let accountInfoArray   = ["MY ACCOUNT", "MY NETWORK", "QR CODE" , "TBT" , "ABOUT" , "TERMS AND CONDITIONS" , "SETTINGS" , "LOGOUT"]
    
    let items = ["PROGRAMME" , "SPEAKERS" , "MY SESSIONS" , "HAPPENINGS" ,"INFORMATION DESK" , "FULL STEAM", "EVALUATION" , "SOT TEAM"]
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tblView.register(UINib(nibName: "UserInfoCell", bundle: nil), forCellReuseIdentifier: "UserInfoCell")
        tblView.register(UINib(nibName: "EventMenuCell", bundle: nil), forCellReuseIdentifier: "EventMenuCell")
        tblView.register(UINib(nibName: "EventMenuHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "EventMenuHeaderCell")
        
        tblView.register(UINib(nibName: "AccountInfo", bundle: nil), forCellReuseIdentifier: "AccountInfo")
        tblView.register(UINib(nibName: "EventAppVersionCell", bundle: nil), forCellReuseIdentifier: "EventAppVersionCell")
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tblView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
extension SELeftSieMenuVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1{
            let title =  UserDefaults.standard.object(forKey: "event_title") as! String
            if title == "" {
                return 0.0
            }
            else{
                return 48.0
            }
        }
        if section == 2{
            return 48.0
        }else {
            return 0.0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      

        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "EventMenuHeaderCell") as! EventMenuHeaderCell
        if section == 1{
            headerView.lblNAme.text = UserDefaults.standard.object(forKey: "event_title") as? String
        }
        else if section == 2{
            headerView.lblNAme.text = "Account"
        }
        return headerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return 1
        } else if section == 1 {
            let title =  UserDefaults.standard.object(forKey: "event_title") as! String
            if title == "" {
                return 0
            }
            else{
            return items.count
            }
        } else if section == 2{
            return accountInfoArray.count
        }
        else{
            return 1
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath) as? UserInfoCell
            let fistName = UserDefaults.standard.string(forKey: "first_name" )
            let lastName = UserDefaults.standard.string(forKey: "last_name")
            
            cell?.lblNAme.text = "\(fistName!) \(lastName!)"
            return cell!
            
        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventMenuCell", for: indexPath) as? EventMenuCell
            cell?.lblNAme.text = self.items[indexPath.row]
            return cell!
        }
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventMenuCell", for: indexPath) as? EventMenuCell
            let accountTitle = self.accountInfoArray[indexPath.row]
            cell?.lblNAme.text = accountTitle
            
            return cell!
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventAppVersionCell", for: indexPath) as? EventAppVersionCell
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            WAShareHelper.goToHomeController(vcIdentifier: "SEEventListVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "SELeftSieMenuVC")
            
        }
        else if indexPath.section == 1{
            if indexPath.row == 0{
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gotoProgram"), object: nil, userInfo: ["isFromMenu" : true])
                WAShareHelper.goToHomeController(vcIdentifier: "SEEventListVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "SELeftSieMenuVC")
            }
        }
        else if indexPath.section == 2 {
            if indexPath.row == 0 {
                WAShareHelper.goToHomeController(vcIdentifier: "SEAccountInfoVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "SELeftSieMenuVC")
                
            } else if indexPath.row == 4 {
                WAShareHelper.goToHomeController(vcIdentifier: "SEAboutVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "SELeftSieMenuVC")
            } else if indexPath.row == 2 {
                appDelegate.isSideMenu = true
                WAShareHelper.goToHomeController(vcIdentifier: "SEQRCodeVC", storyboardName: "Home", navController: nil, leftMenuIdentifier: "SELeftSieMenuVC")
                
                
            } else if indexPath.row == 7 {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                UserDefaults.standard.set(nil  , forKey : "id")
                UserDefaults.standard.set(nil  , forKey : "email")
                UserDefaults.standard.set(nil  , forKey : "password")
                localUserData = nil
                UIApplication.shared.keyWindow?.rootViewController = vc
                
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return  130.0
        }else if indexPath.section == 1{
            return 47.0
        }
        else if indexPath.section == 2 {
            return  50.0
            
        } else {
            return  89.0
        }
        
    }
    
}
