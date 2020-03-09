//
//  SEAskQuestionMainVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 08/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class SEAskQuestionMainVC: UIViewController {
    @IBOutlet var viewOfTop: UIView!
    @IBOutlet var viewOfBottom: UIView!
    var pageVC: UIPageViewController?
    var eventObj : EventObject?
    var programObject : ProgramsObject?
    
    @IBOutlet weak var titleOfScreen: UILabel!

    var isEventOrProgram : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        setPager()
        self.view.bringSubview(toFront: self.viewOfTop)
        self.view.bringSubview(toFront: self.viewOfBottom)


        // Do any additional setup after loading the view.
    }
    
    func setPager() {
        pageVC = storyboard?.instantiateViewController(withIdentifier: "PageViewControllerMain") as! UIPageViewController?
        //        pageVC?.dataSource = self
        //        pageVC?.delegate = self
        let startVC = viewControllerAtIndex(tempIndex: 0)
        _ = startVC.view
        
        pageVC?.setViewControllers([startVC], direction: .reverse, animated: true, completion: nil)
        pageVC?.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEGHT)
        self.addChildViewController(pageVC!)
        self.view.addSubview((pageVC?.view)!)
        self.pageVC?.didMove(toParentViewController: self)
        
    }
    
    func viewControllerAtIndex(tempIndex: Int) -> UIViewController {
        
        if tempIndex == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEInformationDeskVC") as? SEInformationDeskVC
            //            vc.shirtCollection =  self.ap.shirtCollectionOfNewTab
            vc?.index = 0
            vc?.eventObj = eventObj
            vc?.programObject = programObject
            vc?.isEventOrProgram = isEventOrProgram

            return vc!
        }
        else if tempIndex == 1  {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEVenuVC") as? SEVenuVC
            vc?.index = 1
            vc?.eventObj = eventObj
            vc?.programObject = programObject
            vc?.isEventOrProgram = isEventOrProgram

            return vc!
            
        } else if tempIndex == 2  {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEFaqVC") as? SEFaqVC
            vc?.index = 2
            vc?.eventObj = eventObj
            vc?.programObject = programObject
            vc?.isEventOrProgram = isEventOrProgram


            return vc!
            
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SEAskQuestionVC") as? SEAskQuestionVC
            vc?.index = 3
            vc?.eventObj = eventObj
            vc?.programObject = programObject
            vc?.isEventOrProgram = isEventOrProgram

            return vc!

        }
        
        
    }
    
    @IBAction func btnSideMenu_Pressed(_ sender: UIButton) {
        self.revealController.show(self.revealController.leftViewController)
        
    }
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bottomBarPressed(_ sender: UIButton) {
        if sender.tag == 0 {
            let startVC = viewControllerAtIndex(tempIndex: 0)
            _ = startVC.view
//
            titleOfScreen.text = "Infomation Desk"
            pageVC?.setViewControllers([startVC], direction: .forward , animated: true, completion: nil)
            
        } else if sender.tag == 1 {
            
            let startVC = viewControllerAtIndex(tempIndex: 1)
            _ = startVC.view
            titleOfScreen.text = "Venue"

            pageVC?.setViewControllers([startVC], direction: .forward , animated: true, completion: nil)
        } else if sender.tag == 2 {
            let startVC = viewControllerAtIndex(tempIndex: 2)
            _ = startVC.view
            titleOfScreen.text = "FAQ"

            pageVC?.setViewControllers([startVC], direction: .forward , animated: true, completion: nil)
        } else  {
            let startVC = viewControllerAtIndex(tempIndex: 3)
            _ = startVC.view
            titleOfScreen.text = "Ask a Question"

            pageVC?.setViewControllers([startVC], direction: .forward , animated: true, completion: nil)
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

}
