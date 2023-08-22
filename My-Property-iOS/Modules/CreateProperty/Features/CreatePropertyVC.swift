//
//  CreatePropertyVC.swift
//  My-Property-iOS
//
//  Created by Ngoun Lyborey on 10/6/23.
//

import UIKit

class CreatePropertyVC: BaseVC {
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var photoHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Property"
        
        photoCollection.register(SelectPhotoCollectionViewCell.nib, forCellWithReuseIdentifier: SelectPhotoCollectionViewCell.id)
    }
}


extension CreatePropertyVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: SelectPhotoCollectionViewCell.id, for: indexPath) as! SelectPhotoCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 112, height: collectionView.frame.height)
    }
}
