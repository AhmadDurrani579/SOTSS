//
//  SEFaqVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 08/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SEFaqVC: UIViewController , NVActivityIndicatorViewable {
    var index: Int?
    @IBOutlet weak var lblTitleOfProgram: UILabel!
    var eventObj : EventObject?
    var programObject : ProgramsObject?
    @IBOutlet var tblView: UITableView!
    
    let size = CGSize(width: 60, height: 60)
    var responseObj: UserResponse?
    
    var isEventOrProgram : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitleOfProgram.text = eventObj?.event_title
   
        tblView.tableFooterView = UIView()
        tblView.rowHeight = UITableViewAutomaticDimension
        tblView.estimatedRowHeight = UITableViewAutomaticDimension
        getTheFaqOfTheEvent()

        // Do any additional setup after loading the view.
    }
    
    func getTheFaqOfTheEvent() {
        let eventID = eventObj?.event_id
        let loginParam =  [ "event_id"         : "\(eventID!)"
            
            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: EVENTFAQ, isLoaderShow: false, serviceType: "FAQ", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            self.responseObj = response as? UserResponse
            
            if self.responseObj?.success == 1 {
                self.tblView.delegate = self
                self.tblView.dataSource = self
                self.tblView.reloadDataWithAutoSizingCellWorkAround()
                
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension SEFaqVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if  self.responseObj?.result?.faqEvent?.isEmpty == false {
            numOfSections = 1
            tblView.backgroundView = nil
        }
        else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "No FQA found."
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
        return (self.responseObj?.result?.faqEvent?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FaqEventCell", for: indexPath) as? FaqEventCell
        
        cell?.lblQuestionTitle.text = self.responseObj?.result?.faqEvent![indexPath.row].question_title
        cell?.lblQuestionDetail.text = self.responseObj?.result?.faqEvent![indexPath.row].question_detail
        
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
    }
    
}


