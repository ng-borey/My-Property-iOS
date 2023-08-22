//
//  SelectPhotoCollectionViewCell.swift
//  My-Property-iOS
//
//  Created by Ngoun Lyborey on 10/6/23.
//

import UIKit

class SelectPhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.cornerRadius = 10
    }

}
