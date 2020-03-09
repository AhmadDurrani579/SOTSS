//
//  SEProgramConcertVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 20/10/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SEProgramConcertVC: UIViewController {
    @IBOutlet weak var lblOfEventName: UILabel!
    @IBOutlet weak var lblTitleOfScreen: UILabel!
    var titleOfEvent : String?
    var titleOfScreen : String?
    var eventObj : EventObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitleOfScreen.text = titleOfEvent
        lblOfEventName.text = eventObj?.event_title

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
        
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    


}
