//
//  WalkthroughTeamColorController.swift
//  Alpha
//
//  Created by Garrett Head on 9/23/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//
// The WalkthroughTeamColorController provides a selection of colors
// for the user to select which team they want to join.
//
// This controller utilizes an embedded collectionview controller for the colors.
// On selecting a collectionview item, the team color is updated.
//

import UIKit

class WalkthroughTeamColorController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let reuseIdentifier = "Cell"
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
    var delegate : WalkthroughDelegate?
    var teamColorSelected : UIColor?
    private var indexSelected : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.allowsMultipleSelection = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension WalkthroughTeamColorController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.teamColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = teamColors[indexPath.row]
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        cell.contentView.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexSelected = indexPath.row
        let color = teamColors[indexSelected!]
        teamColorSelected = color
        delegate?.setTeamColor(color: color)
        print("set color in walkthrough")
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.backgroundColor = UIColor.systemGray4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.teamColorSelected = nil
        self.indexSelected = nil
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.backgroundColor = teamColors[indexPath.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WalkthroughTeamColorController : UICollectionViewDelegateFlowLayout {
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
