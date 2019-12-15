//
//  KaptenDetailViewController.swift
//  kaptenWars
//
//  Created by daniel velasco on 14/12/2019.
//  Copyright © 2019 daniel velasco. All rights reserved.
//

import UIKit

class KaptenDetailViewController: UIViewController {
    fileprivate struct Constants {
        static let nibName = "KaptenInformationDetailView"
        static let backImageName = "back"
    }
    var viewModel: TripViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetail()
        configureBackItem()
    }
    
    fileprivate func configureDetail() {
        let nib = UINib(nibName: Constants.nibName, bundle: nil)
        guard let model = viewModel, let viewDetail = nib.instantiate(withOwner: self, options: nil)[0] as? KaptenInformationDetailView else {
            return
        }
        viewDetail.translatesAutoresizingMaskIntoConstraints = false
        view.kapten_addFullSizeSubview(viewDetail)
        viewDetail.configure(with: model)
    }
    
    fileprivate func configureBackItem() {
        let backImage = UIImage(named: Constants.backImageName)
        let backItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(back))
        backItem.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = backItem
    }
}

extension KaptenDetailViewController {
    @objc func back() {
           navigationController?.popViewController(animated: true)
    }
}
