//
//  PopularAnimeListTableCell.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import UIKit

final class PopularAnimeListTableCell: UITableViewCell {
	static let reuseIdentifier = "PopularAnimeListTableCell"

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		self.backgroundColor = .systemBackground
		self.accessoryType = .disclosureIndicator
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with model: PopularAnimeListModel) {
		self.textLabel?.text = model.titleName
	}
}
