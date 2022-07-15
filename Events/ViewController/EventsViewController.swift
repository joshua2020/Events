//
//  EventsViewController.swift
//  Events
//
//  Created by Joshua on 08/07/2022.
//

import UIKit

class EventsViewController: UIViewController {
   private var eventServices = [HomeModel]()
   private let parser = Parser()

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadApiData()
    }

    private func loadApiData() {
        parser.parse(endPoint: .events) {
            data in
            self.eventServices = data
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
        }
    }
}

extension EventsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return eventServices.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return eventServices[section].name
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let serviceType = eventServices[section].serviceTypes else { return 0 }
        return serviceType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        
        guard let eventServiceElement = eventServices[indexPath.section].serviceTypes?[indexPath.row] else { return UITableViewCell() }
        cell.setupCell(eventServiceElement)
       return cell

    }
}



