//
//  LeftMenuViewController.swift
//  SSASideMenuExample
//
//  Created by Sebastian Andersen on 20/10/14.
//  Copyright (c) 2015 Sebastian Andersen. All rights reserved.
//

import Foundation
import UIKit

class LeftMenuViewController: UIViewController {
    
//    lazy var tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.separatorStyle = .none
//        tableView.frame = CGRect(x: 20, y: (self.view.frame.size.height - 54 * 5) / 2.0, width: self.view.frame.size.width, height: 54 * 5)
//        tableView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth]
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.isOpaque = false
//        tableView.backgroundColor = UIColor.clear
//        tableView.backgroundView = nil
//        tableView.bounces = false
//        return tableView
//    }()

    @IBOutlet var viewOfItem: UIView!
    @IBOutlet var viewOfContent: UIView!
    
    override func loadView() {
        super.loadView()
//        _ = viewOfItem.frame

        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.presentLeftMenuViewController()
//        DispatchQueue.main.async(execute: {
////            self.view.addSubview(self.viewOfItem)
//        })
        

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = UIColor.clear
//        view.addSubview(viewOfItem)
//            viewOfItem.backgroundColor = UIColor.blue
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}


// MARK : TableViewDataSource & Delegate Methods

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
   
        let titles: [String] = ["HOME", "APPOITMENTS", "FAVOURITES", "Settings", "Log Out"]
        
//        let images: [String] = ["IconHome", "IconCalendar", "IconProfile", "IconSettings", "IconEmpty"]
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 21)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text  = titles[indexPath.row]
        cell.selectionStyle = .none
//        cell.imageView?.image = UIImage(named: images[indexPath.row])
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
     
        switch indexPath.row {
        case 0:

            let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "BLMainHomeVC")
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: homeVC)
            sideMenuViewController?.hideMenuViewController()
            break
        case 1:

            let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "BLAppoitmentVC")
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: homeVC)
            sideMenuViewController?.hideMenuViewController()
            break
            
        case 2:
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "BLFavouritesVC")
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: homeVC)
            sideMenuViewController?.hideMenuViewController()
            break
        case 3:
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: Bundle.main)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "BLSettingVC")
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: homeVC)
            sideMenuViewController?.hideMenuViewController()
            break
        case 4:
          
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            

            UserDefaults.standard.set(nil  , forKey : "email")
            UserDefaults.standard.set(nil  , forKey : "id")
            UserDefaults.standard.set(nil  , forKey : "pass")
            UIApplication.shared.keyWindow?.rootViewController = vc
            break
            
          

            
        default:
            break
        }
        
        
    }
    
}
    
