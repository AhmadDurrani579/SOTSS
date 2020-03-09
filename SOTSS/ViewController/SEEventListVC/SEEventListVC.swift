//
//  SEEventListVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 06/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import ObjectMapper
import NVActivityIndicatorView
import Alamofire

class SEEventListVC: UIViewController , NVActivityIndicatorViewable {
    @IBOutlet var tblView: UITableView!
    let size = CGSize(width: 60, height: 60)
    var responseObj: UserResponse?
    var eventList: [EventObject]?
    var sotEventList: [EventObject]?

    var isActiveEvent = 0
    var  thread : EventModel?
    var arrayOfEvent : NSArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        eventList = []
        sotEventList = []
        if  Connectivity.isConnectedToInternet()  {
            getTheEventOfUser()
        } else {
            arrayOfEvent = EventModel.fetchAll() as NSArray?
            self.tblView.delegate = self
            self.tblView.dataSource = self
            self.tblView.reloadDataWithAutoSizingCellWorkAround()
            

        }
        tblView.tableFooterView = UIView()
        tblView.rowHeight = UITableViewAutomaticDimension
        tblView.estimatedRowHeight = UITableViewAutomaticDimension
    }

    
//
    
    func getTheEventOfUser(){
    
//        let userId = localUserData.user_id
        let idOfUsers = UserDefaults.standard.string(forKey: "id")

        let loginParam =  [ "user_id"         : "\(idOfUsers!)"
            
            ] as [String : Any]
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)
        
        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: EVENTAPI, isLoaderShow: false, serviceType: "Login", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            self.responseObj = response as? UserResponse
            
            if self.responseObj?.success == 1 {
                
                self.storeEventOffline(event: self.responseObj!)
                for (index , eventObj) in (self.responseObj?.result?.event?.enumerated())! {
                    if eventObj.active == "Y" {
                        self.eventList?.insert(eventObj, at: 0)
                    } else {
                        
                        if eventObj.event_category == "SOT" {
                             self.eventList?.append(eventObj)
                        }else {
                             self.sotEventList?.append(eventObj)
                        }
                       
                    }
                    
                }
                
                for (index , eventObjCheck) in ((self.sotEventList?.enumerated())!) {
                    self.eventList?.append(eventObjCheck)
                }
                
                
                
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
    
    func storeEventOffline(event : UserResponse) {
        for (_ , obj) in (event.result?.event?.enumerated())! {
            arrayOfEvent = EventModel.fetchAll() as NSArray?
            let resultPredicate = NSPredicate(format: "event_id == %@", obj.event_id!)
            let arrayOfFilter = arrayOfEvent?.filtered(using: resultPredicate)
            if (arrayOfFilter?.count)! > 0 {
                
            } else {
                thread = EventModel.create() as? EventModel
                thread?.event_id = obj.event_id
                thread?.event_title = obj.event_title
                thread?.event_desc = obj.event_desc
                thread?.event_category = obj.event_category
                thread?.active = obj.active
                thread?.start_date = obj.start_date
                thread?.end_date = obj.end_date
                thread?.display_date = obj.display_date
                thread?.session_tagline = obj.session_tagline
                thread?.speaker_tagline = obj.speaker_tagline
                thread?.fullsteam_desc = obj.fullsteam_desc
                if obj.location?.count != 0 {
                    thread?.location_name = obj.location![0].location_name
                    thread?.location_id = obj.location![0].location_id
                    thread?.city_name = obj.location![0].city_name
                } else {
                    thread?.location_name = " "
                    thread?.location_id = " "
                    thread?.city_name = " "
                }
                
                //            thread?.location_id = obj.location![0].location_id
                //            thread?.city_name = obj.location![0].city_name
                
                EventModel.save()
            }
           


        }


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.set("" , forKey: "event_title")
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)

    }
    

}

extension SEEventListVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if Connectivity.isConnectedToInternet() {
            if  self.eventList?.isEmpty == false {
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
        }
        
        else {
            if  self.arrayOfEvent?.count != 0 {
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
        }
     
//            return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if Connectivity.isConnectedToInternet() {
            return (eventList?.count)!

        } else {
            return (arrayOfEvent?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as? EventCell
        
        if Connectivity.isConnectedToInternet() {
            if indexPath.row == 0 {
                cell?.viewOfBg.backgroundColor = UIColor(red: 244/255.0, green: 146/255.0, blue: 46/255.0, alpha: 1.0)
                
//
                cell?.lblEventName.textColor = UIColor(red: 64/255.0, green: 84/255.0, blue: 178/255.0, alpha: 1.0)
                cell?.lblTitleOfEvent.textColor = UIColor(red: 64/255.0, green: 84/255.0, blue: 178/255.0, alpha: 1.0)
                cell?.lblAddress.textColor = UIColor.white
                cell?.lblEventDate.textColor = UIColor.white
                cell?.imgOfloc.image = UIImage(named: "calen")
                cell?.imgOfCalend.image = UIImage(named: "locat")


            } else {
                cell?.viewOfBg.backgroundColor = UIColor(red: 218/255.0, green: 218/255.0, blue: 218/255.0, alpha: 1.0)
                cell?.lblEventName.textColor = UIColor(red: 244/255.0, green: 146/255.0, blue: 46/255.0, alpha: 1.0)
                cell?.lblTitleOfEvent.textColor = UIColor.black
                cell?.lblAddress.textColor = UIColor(red: 126/255.0, green: 126/255.0, blue: 126/255.0, alpha: 1.0)
                cell?.lblEventDate.textColor = UIColor(red: 126/255.0, green: 126/255.0, blue: 126/255.0, alpha: 1.0)
                cell?.imgOfloc.image = UIImage(named: "calender")
                cell?.imgOfCalend.image = UIImage(named: "venue")


            }
            
            cell?.lblEventName.text = eventList![indexPath.row].event_title
            cell?.lblTitleOfEvent.text = eventList![indexPath.row].event_title
            if eventList![indexPath.row].location?.count == 0 {
                cell?.lblAddress.text = " "
            } else {
                let locationName = eventList![indexPath.row].location![0].location_name
                let cityName = eventList![indexPath.row].location![0].city_name
                cell?.lblAddress.text = "\(locationName!) \(cityName!)"
            }
            cell?.lblEventDate.text = self.responseObj?.result?.event![indexPath.row].display_date

        } else {
            let schoolEvent = self.arrayOfEvent![indexPath.row] as? EventModel
            
            if indexPath.row == 0 {
                cell?.viewOfBg.backgroundColor = UIColor(red: 244/255.0, green: 146/255.0, blue: 46/255.0, alpha: 1.0)
                
                //
                cell?.lblEventName.textColor = UIColor(red: 64/255.0, green: 84/255.0, blue: 178/255.0, alpha: 1.0)
                cell?.lblTitleOfEvent.textColor = UIColor(red: 64/255.0, green: 84/255.0, blue: 178/255.0, alpha: 1.0)
                cell?.lblAddress.textColor = UIColor.white
                cell?.lblEventDate.textColor = UIColor.white
                cell?.imgOfloc.image = UIImage(named: "calen")
                cell?.imgOfCalend.image = UIImage(named: "locat")

                
            } else {
                cell?.viewOfBg.backgroundColor = UIColor.white
                cell?.lblEventName.textColor = UIColor(red: 244/255.0, green: 146/255.0, blue: 46/255.0, alpha: 1.0)
                cell?.lblTitleOfEvent.textColor = UIColor.black
                cell?.lblAddress.textColor = UIColor(red: 126/255.0, green: 126/255.0, blue: 126/255.0, alpha: 1.0)
                cell?.lblEventDate.textColor = UIColor(red: 126/255.0, green: 126/255.0, blue: 126/255.0, alpha: 1.0)
                cell?.imgOfloc.image = UIImage(named: "calender")
                cell?.imgOfCalend.image = UIImage(named: "venue")

                
            }
            cell?.lblEventName.text = schoolEvent?.event_title
            cell?.lblTitleOfEvent.text = schoolEvent?.event_title
            if self.responseObj?.result?.event![indexPath.row].location?.count == 0 {
                cell?.lblAddress.text = " "
            } else {
              
            }
            
            let locationName = schoolEvent?.location_name
            let cityName = schoolEvent?.city_name
            cell?.lblAddress.text = "\(locationName!) \(cityName!)"
            
            cell?.lblEventDate.text = schoolEvent?.display_date
        }

        
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEEventDetailVC") as? SEEventDetailVC
        if Connectivity.isConnectedToInternet() {
            vc?.eventObj = eventList![indexPath.row]

        } else {
            vc?.eventOffline = self.arrayOfEvent![indexPath.row] as? EventModel
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  139
    }

}

extension UITableView {
    func reloadDataWithAutoSizingCellWorkAround() {
        self.reloadData()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.reloadData()
    }
}
