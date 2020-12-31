//
//  TeamColorController.swift
//  Alpha
//
//  Created by Garrett Head on 9/18/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import UIKit

protocol TeamColorDelegate {
    func setTeamColor(color : UIColor)
}

private let reuseIdentifier = "Cell"

class TeamColorController: UICollectionViewController {
    
    let teamColors : [UIColor] = [UIColor.systemRed,
                                  UIColor.systemPink,
                                  UIColor.systemOrange,
                                  UIColor.systemYellow,
                                  UIColor.systemBlue,
                                  UIColor.systemTeal,
                                  UIColor.systemIndigo,
                                  UIColor.systemPurple,
                                  UIColor.systemGreen,
                                  UIColor.systemGray,
                                  UIColor.white,
                                  UIColor.black
                                  
    ]
    
    var delegate : TeamColorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamColors.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = teamColors[indexPath.row]
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        cell.contentView.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.setTeamColor(color: teamColors[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }

}

extension TeamColorController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 3

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
}
