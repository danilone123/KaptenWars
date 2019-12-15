//
//  ViewController.swift
//  kaptenWars
//
//  Created by daniel velasco on 13/12/2019.
//  Copyright © 2019 daniel velasco. All rights reserved.
//

import UIKit

class KaptenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    fileprivate var tripsList: [Trip] = []
    fileprivate var activityIndicator = UIActivityIndicatorView()
    fileprivate let indicatorContainerView = UIView()
    @IBOutlet fileprivate weak var tableView: UITableView!
      
    fileprivate struct Constants {
        static let cellIdentifier = "kaptenCell"
        static let cellNibName = "KaptenInformationCell"
        static let detailIdentifier = "detail"
        static let heightRow: CGFloat = 130.0
        static let alphaColor: CGFloat = 0.2
        static let navigationTitle = "LAST TRIPS"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureIndicatorView()
        configureNavigation()
        startRequest()
    }
    
    fileprivate func configureNavigation() {
        navigationController?.navigationBar.barTintColor = UIColor.black
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        title = Constants.navigationTitle
    }
    
    fileprivate func configureIndicatorView() {
        indicatorContainerView.backgroundColor = UIColor.black.withAlphaComponent(Constants.alphaColor)
        indicatorContainerView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style =
            UIActivityIndicatorView.Style.large
        activityIndicator.center = view.center
        activityIndicator.color = UIColor.gray
        activityIndicator.startAnimating()
        indicatorContainerView.addSubview(activityIndicator)
    }
    
    fileprivate func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 24
        tableView.estimatedRowHeight = Constants.heightRow
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.lightGray
        tableView.allowsSelection = true
        tableView.backgroundColor = UIColor.black
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
    }
}

//Connection
extension KaptenViewController {
    fileprivate func startRequest() {
        view.kapten_addFullSizeSubview(indicatorContainerView)
        
        KaptenConnector.getTrips() { [weak self] (trips) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.loadTable(trips: trips)
        }
    }
    
    fileprivate func loadTable(trips: [Trip]?) {
        guard let tripList = trips else {
            print("trip information is empty")
            DispatchQueue.main.async {
                self.indicatorContainerView.removeFromSuperview()
            }
            return
        }
        
        tripsList = tripList
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.indicatorContainerView.removeFromSuperview()
        }
    }
}

// TableView delegate
extension KaptenViewController {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let kaptenInformationCell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? KaptenInformationCell else {
            let emptyCell = UITableViewCell()
            return emptyCell
        }
        let viewModel = TripViewModel(trip: tripsList[indexPath.row])
        kaptenInformationCell.configureWithTrip(tripVM: viewModel)
        kaptenInformationCell.selectionStyle = .none
        return kaptenInformationCell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: Constants.detailIdentifier) as? KaptenDetailViewController else {
            return
        }
        let viewModel = TripViewModel(trip: tripsList[indexPath.row])
        detailVC.viewModel = viewModel
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
