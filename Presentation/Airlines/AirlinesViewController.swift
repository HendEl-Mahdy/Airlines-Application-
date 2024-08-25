//
//  AirlinesViewController.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 19/07/2024.
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
        viewModel.getAirlines()
        bindViewModel()
        setupDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc private func search(){
        if let searchText = searchTextField.text {
            viewModel.searchForName(for: searchText)
        }
    }
    
    private func bindViewModel(){
        viewModel.airlinesArraySubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(_):
                    self.reloadTableView()
                case .failure(let error):
                    self.showToastAlert(controller: self, message: "\(error.networkError)", Seconds: 1)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func openDetailsAirline(airline: DataModel){
        let detailsViewModel = DetailsViewModel(airline: airline)
        let detailsController = DetailsViewController(viewModel: detailsViewModel)
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailsController, animated: true)
        }
    }
    
    private func reloadTableView(){
        airlineTableView.reloadData()
    }
    
    @IBAction private func searchButtonPressed(_ sender: Any) {
        search()
        dismissKeyboard()
    }
    
    @IBAction private func addButtonPressed(_ sender: Any) {
        let addAirlineVC = AddAirlinesViewController(nibName: Constants.addVC,
                                                     bundle: nil)
        addAirlineVC.modalPresentationStyle = .pageSheet
        present(addAirlineVC, animated: true, completion: nil)
        
    }
    
    private func showToastAlert(controller: UIViewController, message: String, Seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.clear
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Seconds){
            alert.dismiss(animated: true)
        }
        
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

extension AirlinesViewController: UITextFieldDelegate{
    private func setupDelegate(){
        searchTextField.delegate = self
        searchTextField.returnKeyType = .go
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
