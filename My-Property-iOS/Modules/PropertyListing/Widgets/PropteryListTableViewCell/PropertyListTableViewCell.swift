//
//  PropertyListTableViewCell.swift
//  My-Property-iOS
//
//  Created by Ngoun Lyborey on 5/6/23.
//

import UIKit
import SDWebImage


class PropertyListTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var progress: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var land: UILabel!
    @IBOutlet weak var progressbar: UIProgressView!
    @IBOutlet weak var imag: UIImageView!
    @IBOutlet weak var moreBtn: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(model: Datum){
        imag.sd_setImage(with: URL(string: model.image.original), placeholderImage: UIImage(named: "default"), completed: nil)
        title.text = model.titleAddress
        address.text = model.shortAddress
        progress.text = "\(model.progress) %"
        progressbar.progress = Float(Double(model.progress) / 100)
        land.text =  model.landArea != nil ? "\(model.landArea ?? 0) m²" : "-- m²"
        moreBtn.isUserInteractionEnabled = true
    }
    
   
}
