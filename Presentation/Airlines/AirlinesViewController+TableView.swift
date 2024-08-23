//
//  AirlinesViewController+TableView.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 19/07/2024.
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
        return viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AirlineTableViewCell.identifier, for: indexPath) as? AirlineTableViewCell else{
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
        airlineTableView.register(AirlineTableViewCell.register(), forCellReuseIdentifier: AirlineTableViewCell.identifier)
    }
}
