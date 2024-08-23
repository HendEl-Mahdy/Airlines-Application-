//
//  DetailsViewController.swift
//  AirlinesApplication
//
//  Created by HendEl-Mahdy on 20/07/2024.
//

import UIKit
import WebKit
import RxSwift

class DetailsViewController: UIViewController {
    
    private var viewModel: DetailsProtocol
    private let disposeBag = DisposeBag()
    
    @IBOutlet private(set) weak var navigationView: UIView!
    @IBOutlet private(set) weak var navigationLabel: UILabel!
    @IBOutlet private(set) weak var detailedView: UIView!
    @IBOutlet private(set) weak var nameLabel: UILabel!
    @IBOutlet private(set) weak var countryLabel: UILabel!
    @IBOutlet private(set) weak var sloganLabel: UILabel!
    @IBOutlet private(set) weak var headquatersLabel: UILabel!
    @IBOutlet private(set) weak var titleHeadquaters: UILabel!
    @IBOutlet private(set) weak var visitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        bindObservables()
        showData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    init(viewModel: DetailsProtocol) {
        self.viewModel = viewModel
        super.init(nibName: Constants.detailsVC, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindObservables(){
        viewModel
            .websiteURLSubject?
            .subscribe(onNext: { [weak self] url in
                guard let self = self else { return }
                self.openWebView(urlRequest: url)
            }).disposed(by: disposeBag)
        
        viewModel
            .emptyURLSubject?
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.showToastAlert(controller: self, message: Constants.websitErrorMessage, Seconds: 0.6)
            }).disposed(by: disposeBag)
    }
    
    private func openWebView(urlRequest: URLRequest){
        let webView = WKWebView(frame: self.view.frame)
        webView.load(urlRequest)
        let webViewController = UIViewController()
        webViewController.view = webView
        self.present(webViewController, animated: true, completion: nil)
    }
    
    private func showData(){
        nameLabel.text = viewModel.name
        countryLabel.text = viewModel.country
        sloganLabel.text = viewModel.slogan
        titleHeadquaters.text = viewModel.headquaters
        headquatersLabel.isHidden = viewModel.validateText()
    }
    
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func visitButtonPressed(_ sender: UIButton) {
        viewModel.handleUrl()
    }
    
    private func updateUI(){
        navigationLabel.text = Constants.detailsTitle
        navigationView.navigationShadow(opacity: 0.2)
        detailedView.addCornerRadius(cornerRadius: 0.02)
        visitButton.addCornerRadius(cornerRadius: 0.02)
        detailedView.detailedShadow(opacity: 0.3)
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
}
