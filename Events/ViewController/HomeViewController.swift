//
//  ViewController.swift
//  Events
//
//  Created by Joshua on 08/07/2022.
//

import UIKit

class HomeViewController: UIViewController {
    private var homeServices = [HomeModel]()
    private let parser = Parser()

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        loadApiData()
    }

    private func loadApiData() {
        parser.parse(endPoint: .home) {
            data in
            self.homeServices = data
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeServices.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return homeServices[section].name
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let serviceType = homeServices[section].serviceTypes else { return 0 }
        return serviceType.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell

        guard let homeServiceElement = homeServices[indexPath.section].serviceTypes?[indexPath.row] else { return UITableViewCell() }
        cell.setupCell(homeServiceElement)
       return cell
    }
}




