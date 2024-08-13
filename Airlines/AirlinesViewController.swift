//
//  AirlinesViewController.swift
//  AirlinesApplication
//
//  Created by admin user on 19/07/2024.
//
import UIKit
import RxSwift

class AirlinesViewController: UIViewController{
    
    var viewModel : AirlinesProtocol = AirlinesViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet private(set) weak var viewLabel: UIView!
    @IBOutlet private(set) weak var searchView: UIView!
    @IBOutlet private(set) weak var navigationLabel: UILabel!
    @IBOutlet private(set) weak var searchTextField: UITextField!
    @IBOutlet private(set) weak var searchButton: UIButton!
    @IBOutlet private(set) weak var airlineTableView: UITableView!
    @IBOutlet private(set) weak var addButton: UIButton!
    
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
    
    @objc func search(){
        viewModel.searchForName(for: searchTextField.text!)
        reloadTableView()
    }
    
    private func bindViewModel(){
        viewModel.dataSource?
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.reloadTableView()
            }).disposed(by: disposeBag)
    }
    
    func openDetailsAirline(airline: AirlinesEntity){
        let detailsViewModel = DetailsViewModel(airline: airline)
        let detailsController = DetailsViewController(viewModel: detailsViewModel)
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailsController, animated: true)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func reloadTableView(){
        airlineTableView.reloadData()
    }
    
    @IBAction private func searchButtonPressed(_ sender: Any) {
        search()
    }
    
    @IBAction private func addButtonPressed(_ sender: Any) {
        let addAirlineVC = AddAirlinesViewController(nibName: Constants.addVC,
                                                     bundle: nil)
        addAirlineVC.modalPresentationStyle = .pageSheet
        present(addAirlineVC, animated: true, completion: nil)
        
    }
    
    private func setup(){
        setupTableView()
        searchTextField.addTarget(self, action: #selector(search), for: .editingChanged)
        
        navigationLabel.text = Constants.airlineTitle
        viewLabel.navigationShadow(opacity: 0.2)
        
        addButton.frame = CGRect(x: 160, y: 100, width: 62, height: 62)
        addButton.redCircleButton(cornerRadius: 0.5, shadowRadius: 5.0, shadowOpacity: 0.2)
        
        searchButton.addCornerRadius(cornerRadius: 0.2)
    }
    
}
