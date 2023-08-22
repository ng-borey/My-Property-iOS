//
//  PropertyListingViewController.swift
//  My-Property-iOS
//
//  Created by Ngoun Lyborey on 5/6/23.
//

import UIKit

class PropertyListingVC: UIViewController {
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var createBtn: UIView!
    
    let sv = PropertyListingServices()
    
    var listing: ListingModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        createBtn.isUserInteractionEnabled = true
        createBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushCreateProperty)))
        table.register(PropertyListTableViewCell.nib, forCellReuseIdentifier: PropertyListTableViewCell.id)
        self.table.isHidden = true
        self.loading.isHidden = false
        sv.fetchPropertyListing { result in
            switch result {
            case .success(let model):
                
                self.listing = model
                self.table.reloadData()
                self.table.isHidden = false
                self.loading.isHidden = true
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    @objc private func pushCreateProperty() {
//        let nav = UINavigationController(rootViewController: SBManager.getPropertyTypeVC())
        navigationController?.pushViewController(SBManager.getCreatePropertyVC(), animated: true)
    }
    
    @objc private func showMoreBtn() {
        let vc = SBManager.getPropertyListingVC()
        if let sheet = vc.presentationController as? UISheetPresentationController {
            sheet.detents = [.custom(resolver: { context in
                140
            })]
        }
        present(vc, animated: true)
    }
    
}

extension PropertyListingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listing == nil ? 0 : listing.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: PropertyListTableViewCell.id, for: indexPath) as! PropertyListTableViewCell
        cell.setup(model: listing.data[indexPath.row])
        let tap = UITapGestureRecognizer(target: self, action: #selector(showMoreBtn))
        cell.moreBtn.addGestureRecognizer(tap)
        return cell
    }
    
}
