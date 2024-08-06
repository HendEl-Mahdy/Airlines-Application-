//
//  AirlinesViewController.swift
//  AirlinesApplication
//
//  Created by admin user on 19/07/2024.
//
import UIKit

class AirlinesViewController: UIViewController, AddAirlinesViewDelegate{
    
    var viewModel = AirlinesViewModel()
    var cellDataSource: [AirlineCellViewModel] = []
    
    @IBOutlet weak var viewLabel: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var navigationLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var airlineTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.checkSavingData()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        search()
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let addAirlineVC = AddAirlinesViewController(nibName: Constants.addVC,
                                                     bundle: nil)
        addAirlineVC.viewModel.delegate = self
        addAirlineVC.modalPresentationStyle = .pageSheet
        present(addAirlineVC, animated: true, completion: nil)
        
    }
    
    @objc func search(){
        viewModel.searchForName(for: searchTextField.text!)
        reloadTableView()
    }
    
    func dataReload() {
        viewModel.loadData()
        reloadTableView()
    }
    
    func bindViewModel(){
        viewModel.cellDataSource.bind { [weak self] airlines in
            guard let self = self, let airlines = airlines else{
                return
            }
            self.cellDataSource = airlines
            self.reloadTableView()
        }
    }
    
    func openDetailsAirline(airline:AirlinesEntity){
        let detailsViewModel = DetailsViewModel(airline: airline)
        let detailsController = DetailsViewController(viewModel: detailsViewModel)
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailsController, animated: true)
        }
    }
    
    @objc func dismissKeyboard() {
            view.endEditing(true)
    }
    

    func setup(){
        setupTableView()
        searchTextField.addTarget(self, action: #selector(search), for: .editingChanged)
        
        navigationLabel.text = Constants.airlineTitle
        viewLabel.navigationShadow(opacity: 0.2)
        
        addButton.frame = CGRect(x: 160, y: 100, width: 62, height: 62)
        addButton.redCircleButton(cornerRadius: 0.5, shadowRadius: 5.0, shadowOpacity: 0.2)
        
        searchButton.addCornerRadius(cornerRadius: 0.2)
    }
    
}
