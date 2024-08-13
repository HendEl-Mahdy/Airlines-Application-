//
//  AirlinesTableViewCell.swift
//  AirlinesApplication
//
//  Created by admin user on 19/07/2024.
//

import UIKit

class AirlineCellViewController: UITableViewCell {
    
    public static var identifier: String{
        get{
            return Constants.cellIdentifier
        }
    }
    
    @IBOutlet private(set) weak var cellView: UIView!
    @IBOutlet private(set) weak var cellArrow: UIImageView!
    @IBOutlet private(set) weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateCellUI()
    }
    
    public static func register() -> UINib {
        UINib(nibName: Constants.cellVC, bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(name: String){
        self.cellLabel.text = name
    }
    
    private func updateCellUI(){
        cellView.addBorder(color: .systemGray5, width: Constants.cellBorderWidth)
        cellView.round(radius: Constants.cellCornerRadius)
    }
    
}
