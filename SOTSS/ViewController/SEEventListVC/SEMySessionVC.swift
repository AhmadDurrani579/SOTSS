//
//  SEMySessionVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 22/10/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SEMySessionVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    var eventObj : EventObject?
    var programSelect : [ProgramsObject]?
    
    var registerProgram : [ProgramsObject]?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerProgram = []
        
        for (_ , objOfProgram) in (programSelect?.enumerated())! {
            
            let idOfUser = UserDefaults.standard.string(forKey: "id")
            
            if objOfProgram.user_id == idOfUser {
                registerProgram?.append(objOfProgram)
            }
        }
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()


    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
        
    }
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    

}

extension SEMySessionVC : UITableViewDelegate , UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return registerProgram?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgrammCell", for: indexPath) as? ProgrammCell
        let evaluationActive = registerProgram![indexPath.row].evaluation_active
        let evaluationSubmited = registerProgram![indexPath.row].evaluation_submitted
        
        if evaluationActive == "Y" && evaluationSubmited == "N" {
            cell?.btnEvaluatePending.isHidden = false
        } else {
            cell?.btnEvaluatePending.isHidden = true
        }
        cell?.lblActivity_title.text = registerProgram![indexPath.row].activity_title
        cell?.lblActivity_desc.text = registerProgram![indexPath.row].activity_desc
        cell?.lblDisplay_date.text = registerProgram![indexPath.row].display_date
        cell?.lblVenue_title.text = registerProgram![indexPath.row].venue_title
        cell?.participation = registerProgram![indexPath.row].participant
        cell?.collectionViewCell.reloadData()
        cell?.evaluatePendingDelegate = self
        cell?.index  = indexPath

        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0

    }
}

extension SEMySessionVC  : EvaluatePendingDelegate {
    
    func  evaluatePending(cell : ProgrammCell , indexCheck : IndexPath) {
        
    }

}
