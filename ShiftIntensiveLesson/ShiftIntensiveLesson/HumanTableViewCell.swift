//
//  HumanTableViewCell.swift
//  ShiftIntensiveLesson
//
//  Created by Abrosimov Ilya on 30.01.2023.
//

import UIKit

class HumanTableViewCell: UITableViewCell {

	@IBOutlet weak var weightLabel: UILabel!
	@IBOutlet weak var heightLabel: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var avatarImageView: UIImageView!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func configure(with model: Human) {
		nameLabel.text = model.name
		heightLabel.text = "Рост: \(model.height) см"
		weightLabel.text = "Вес: \(model.weight) кг"
		let image = UIImage(named: model.name)
		avatarImageView.image = image
		avatarImageView.layer.cornerRadius = 16
	}
    
}
