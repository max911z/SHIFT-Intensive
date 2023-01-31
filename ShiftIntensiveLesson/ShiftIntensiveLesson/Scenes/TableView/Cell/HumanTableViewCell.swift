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
		selectionStyle = .none
    }

//	func configure(with model: Human) {
//		nameLabel.text = model.name
//		heightLabel.text = "Рост: \(model.height) см"
//		weightLabel.text = "Вес: \(model.weight) кг"
//		let image = UIImage(named: model.name)
//		avatarImageView.image = image
//		avatarImageView.layer.cornerRadius = 16
//	}

	func configure(with model: Article) {
		nameLabel.text = model.title
		heightLabel.text = model.body
//		weightLabel.text = "Вес: \(model.weight) кг"
//		let image = UIImage(named: model.name)
//		avatarImageView.image = image
//		avatarImageView.layer.cornerRadius = 16
	}
}
