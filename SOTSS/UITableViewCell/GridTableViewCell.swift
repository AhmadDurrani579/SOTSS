//
//  GridTableViewCell.swift
//  SOT Events
//
//  Created by Ahmed Durrani on 16/10/2018.
//  Copyright © 2018 SOT. All rights reserved.
//

import UIKit

class GridTableViewCell: UITableViewCell {
    
    var isHallSelect : [ProgramsObject]?
    @IBOutlet weak var lblActivityHallTitle: UILabel!

    @IBOutlet weak var collectionCell: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension GridTableViewCell : UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return (isHallSelect?.count)!
        }
        
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCollectionCell", for: indexPath) as! GridCollectionCell
        cell.lblActivity_title.text = self.isHallSelect![indexPath.row].activity_title
        cell.lblActivity_desc.text = self.isHallSelect![indexPath.row].activity_desc
        cell.lblDisplay_date.text = self.isHallSelect![indexPath.row].display_date
        cell.lblVenue_title.text = self.isHallSelect![indexPath.row].venue_title
        cell.participation = self.isHallSelect![indexPath.row].participant
        cell.collectionViewCell.reloadData()

        

        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if Connectivity.isConnectedToInternet() {
//            let obj = self.participation![indexPath.row]
//            self.delegate?.selectSpeaker(cell: self, indexCheck: indexPath , participant: obj)
//
//        }
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeOfCell = collectionCell.frame.size.width + 20
        //        let heightOfCell = self.collectionViewCell.frame.size.height/6
        
        return CGSize(width: sizeOfCell, height: 181.0)
    }
    
    
}

