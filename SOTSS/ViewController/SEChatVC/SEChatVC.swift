//
//  SEChatVC.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 12/09/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import NVActivityIndicatorView


class SEChatVC: JSQMessagesViewController  , NVActivityIndicatorViewable {
  
    let size = CGSize(width: 60, height: 60)
    var responseObj: UserResponse?
    private var messages: [JSQMessage] = []
//    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
//    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let rightArrow : UIView = UIView.init(frame: CGRect (x : 0 , y : 0 , width : 100 , height : 100))
        let leftbtn = UIButton(type: .custom)
        leftbtn.setImage(UIImage(named: "back_icon"), for: .normal)
        leftbtn.imageView?.contentMode = .scaleAspectFit
        leftbtn.inputView?.tintColor = #colorLiteral(red: 0.8249945045, green: 0.001638017246, blue: 0.3011991978, alpha: 1)
        leftbtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftbtn.addTarget(self, action: #selector(SEChatVC.back_Pressed), for: .touchUpInside)
        let leftITem = UIBarButtonItem(customView: leftbtn)
        self.navigationItem.setLeftBarButtonItems([leftITem], animated: true)
        var navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor =  #colorLiteral(red: 0.2509803922, green: 0.3294117647, blue: 0.6980392157, alpha: 1)
        
        let fistName = UserDefaults.standard.string(forKey: "first_name")
        let lastName = UserDefaults.standard.string(forKey: "last_name")
        let email = UserDefaults.standard.string(forKey: "email")
        let phone = UserDefaults.standard.string(forKey: "phone")
        let idOfUsers = UserDefaults.standard.string(forKey: "id")
        let qrCode = UserDefaults.standard.string(forKey: "qrcode")
        let imgOFUser = UserDefaults.standard.string(forKey: "image")
        
        self.senderId = idOfUsers
        self.senderDisplayName = "\(fistName!) \(lastName!)"
//        getMessageList()

        
        // Do any additional setup after loading the view.
    }
    
    func getMessageList() {
        
//        let eventId = eventObj?.event_id
        let loginParam =  [ "from_user_id"         : "500" ,
                            "to_user_id"           : "508"
            
            ] as [String : Any]
        
        startAnimating(size, message: "", messageFont: nil , type: NVActivityIndicatorType(rawValue: 6), color:UIColor.white   , padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil , textColor: UIColor.white)

        
        WebServiceManager.post(params:loginParam as Dictionary<String, AnyObject> , serviceName: USERMESSAGESLIST, isLoaderShow: false, serviceType: "Message", modelType: UserResponse.self, success: { (response) in
            self.stopAnimating()
            
            self.responseObj = response as? UserResponse
            
            
            
            if self.responseObj?.success == 1 {
                
                self.collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
                self.collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero

//                self.messages.append(self.responseObj?.result?.userMessage?.messages as! JSQMessage)
//                collectionView.reloadData()
                self.collectionView.reloadData()

//                self.showAlert(title: "SOT Events", message: (self.responseObj?.message!)!, controller: self)
            }
            else
            {
                self.showAlert(title: "SOT Event", message: (self.responseObj?.message!)!, controller: self)
                
            }
            
            
        }, fail: { (error) in
            self.showAlert(title: "SOT Events", message:error.description  , controller: self)
            self.stopAnimating()

            
        }, showHUD: true)
        
//
    }
    
    @objc func back_Pressed() {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }

    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
    }
    
//    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
//            return self.responseObj?.result?.userMessage?.messages![indexPath.item] as! JSQMessageData
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if self.responseObj?.result?.userMessage?.messages?.count == nil {
//            return 0
//        } else {
//            return (self.responseObj?.result?.userMessage?.messages?.count)!
//
//        }
//    }
//
//    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
//        let message = self.responseObj?.result?.userMessage?.messages![indexPath.item] // 1
//        if message?.from_user_id == "500" { // 2
//            return outgoingBubbleImageView
//        } else { // 3
//            return incomingBubbleImageView
//        }
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
//
//        let message = self.responseObj?.result?.userMessage?.messages![indexPath.item] // 1
//        if message?.from_user_id == "500" { // 2
//            cell.textView?.textColor = UIColor.white // 2
//        } else {
//            cell.textView?.textColor = UIColor.black // 3
//        }
//
//        return cell
//    }
//
//    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
//        return nil
//    }
//
//    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
//        return 15
//    }
//
//    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
//        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
//        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
//    }
//
//    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
//        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
//        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
//    }
//
    
    

    
}
