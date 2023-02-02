//
//  AnimeDetailsView.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import UIKit
import SnapKit

protocol IAnimeDetailsView: UIView {
	func set(with model: AnimeDetailsModel)
	func set(with image: UIImage)
}

final class AnimeDetailsView: UIView {
	private enum Metrics {
		static let imageHeight: CGFloat = 280
		static let imageWidth: CGFloat = 200
		static let imageViewTopInset: CGFloat = 100
		static let imageViewCornerRadius: CGFloat = 5
		static let imageViewBorderWidth: CGFloat = 0.5

		static let titleTopInset: CGFloat = 30
		static let titleLeadingTrailingInset: CGFloat = 20
	}

	private lazy var imageView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = Metrics.imageViewCornerRadius
		imageView.layer.borderWidth = Metrics.imageViewBorderWidth
		imageView.layer.borderColor = UIColor.black.cgColor
		imageView.backgroundColor = .lightGray

		return imageView
	}()

	private lazy var titleLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.numberOfLines = 5
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 32, weight: .bold)

		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.addSubview(self.imageView)
		self.addSubview(self.titleLabel)

		self.setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension AnimeDetailsView: IAnimeDetailsView {
	func set(with model: AnimeDetailsModel) {
		self.titleLabel.text = model.title
	}

	func set(with image: UIImage) {
		self.imageView.image = image
	}
}

private extension AnimeDetailsView {
	func setup() {
		self.configureUI()
		self.configureConstraints()
	}

	func configureUI() {
		self.backgroundColor = .systemBackground
	}

	func configureConstraints() {
		self.imageView.snp.makeConstraints { make in
			make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(Metrics.imageViewTopInset)
			make.height.equalTo(Metrics.imageHeight)
			make.width.equalTo(Metrics.imageWidth)
			make.centerX.equalToSuperview()
		}

		self.titleLabel.snp.makeConstraints { make in
			make.top.equalTo(self.imageView.snp.bottom).offset(Metrics.titleTopInset)
			make.leading.trailing.equalToSuperview().inset(Metrics.titleLeadingTrailingInset)
			make.centerX.equalToSuperview()
		}
	}
}
