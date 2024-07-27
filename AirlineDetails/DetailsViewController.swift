//
//  DetailsViewController.swift
//  AirlinesApplication
//
//  Created by admin user on 20/07/2024.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController {
    
    var viewModel: DetailsViewModel
    var websiteURL: String
    
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var detailedView: UIView!
    
    @IBOutlet weak var navigationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var headquatersLabel: UILabel!
    
    @IBOutlet weak var titleHeadquaters: UILabel!
    
    @IBOutlet weak var visitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        showData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        self.websiteURL = viewModel.website!
        super.init(nibName: Constants.detailsVC, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func visitButtonPressed(_ sender: UIButton) {
        if websiteURL != Constants.emptyString{
            let webView = WKWebView(frame: self.view.frame)
            let url = URL(string: websiteURL)!
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
            
            let webViewController = UIViewController()
            webViewController.view = webView
            self.present(webViewController, animated: true, completion: nil)
        }else{
            showToastAlert(controller: self, message: Constants.websitErrorMessage, Seconds: 0.6)
        }
        
    }
    
    func showData(){
        nameLabel.text = viewModel.name
        countryLabel.text = viewModel.country
        sloganLabel.text = viewModel.slogan
        titleHeadquaters.text = viewModel.headquaters
        if(titleHeadquaters.text == nil || titleHeadquaters.text == Constants.emptyString){
            headquatersLabel.isHidden = true
        }
        websiteURL = viewModel.website!
        
    }
    
    func updateUI(){
        navigationLabel.text = Constants.detailsTitle
        navigationView.navigationShadow(opacity: 0.2)
        detailedView.addCornerRadius(cornerRadius: 0.02)
        visitButton.addCornerRadius(cornerRadius: 0.02)
        detailedView.detailedShadow(opacity: 0.3)
    }
    
    func showToastAlert(controller: UIViewController, message: String, Seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.clear
        alert.view.layer.cornerRadius = 15
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Seconds){
            alert.dismiss(animated: true)
        }
        
    }
}
