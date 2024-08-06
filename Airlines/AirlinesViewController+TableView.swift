//
//  AirlinesViewController+TableView.swift
//  AirlinesApplication
//
//  Created by admin user on 19/07/2024.
//

import Foundation
import UIKit

extension AirlinesViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func setupTableView(){
        self.airlineTableView.delegate = self
        self.airlineTableView.dataSource = self
        self.airlineTableView.backgroundColor = .systemGray6
        registerCells()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AirlineCellViewController.identifier, for: indexPath) as? AirlineCellViewController else{
            return UITableViewCell()
        }
        
        let cellViewModel = viewModel.getAirlineData(index: indexPath.row).name
        cell.setupCell(name: cellViewModel!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  airline = viewModel.getAirlineData(index: indexPath.row)
        self.openDetailsAirline(airline: airline)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func registerCells(){
        airlineTableView.register(AirlineCellViewController.register(), forCellReuseIdentifier: AirlineCellViewController.identifier)
    }
    
    func reloadTableView(){
        airlineTableView.reloadData()
    }
}
