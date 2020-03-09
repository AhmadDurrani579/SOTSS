//
//  SEHappeningVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 21/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SEHappeningVC: UIViewController  , NVActivityIndicatorViewable {
 
    @IBOutlet var tblView: UITableView!
    var eventObj : EventObject?
    let size = CGSize(width: 60, height: 60)
    var responseObj: UserResponse?
    @IBOutlet weak var lblDate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblDate.text = eventObj?.event_title

        getHappeningList()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getHappeningList(){
        
        let eventId = eventObj?.event_id
        let loginParam =  [ "event_id"        :  eventId!
            
            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: HAPPENINGAPI, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            self.responseObj = response as? UserResponse
            
            if self.responseObj?.success == 1 {
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadData()
                
            }
            else
            {
                self.showAlert(title: "SOT Event", message: (self.responseObj?.message!)!, controller: self)
                
            }
            
            
        }, fail: { (error) in
            self.showAlert(title: "SOT Events", message:error.description  , controller: self)
            self.stopAnimating()
            
        }, showHUD: true)
        
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
        
    }
//    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
//        self.revealController.show(self.revealController.leftViewController)
//
//    }

}

extension SEHappeningVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if  self.responseObj?.result?.happeningList?.isEmpty == false {
            numOfSections = 1
            tblView.backgroundView = nil
        }
        else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no data."
            noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
            noDataLabel.textAlignment = .center
            tblView.backgroundView = noDataLabel
            tblView.separatorStyle = .none
        }
        return numOfSections
        //            return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.responseObj?.result?.happeningList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HappeningCell", for: indexPath) as? HappeningCell
        let index = indexPath.row + 1
        cell?.lblTitleOfHappening.text = "Happening\(index)"
        cell?.lblDate.text = self.responseObj?.result?.happeningList![indexPath.row].date_filter
        cell?.lblLink.text = self.responseObj?.result?.happeningList![indexPath.row].url
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  85.0
    }
    
}

