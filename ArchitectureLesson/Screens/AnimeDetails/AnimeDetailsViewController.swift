//
//  AnimeDetailsViewController.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import UIKit

final class AnimeDetailsViewController: UIViewController {
	private var ui: IAnimeDetailsView

	private let animeId: String

	private let viewModel: IAnimeDetailsViewModel

	init(animeId: String,
		 viewModel: IAnimeDetailsViewModel) {
		self.ui = AnimeDetailsView(frame: .zero)

		self.animeId = animeId

		self.viewModel = viewModel

		super.init(nibName: nil, bundle: nil)

		self.setBinds()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		self.view = ui
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.viewModel.loadAnimeDetails(with: self.animeId)
	}
}

private extension AnimeDetailsViewController {
	func setBinds() {
		self.viewModel.animeDetails.subscribe { [weak self] animeDetail in
			self?.ui.set(with: animeDetail)
			self?.loadImage(with: animeDetail.imgString)
		}

		self.viewModel.image.subscribe { [weak self] image in
			self?.ui.set(with: image)
		}

		self.viewModel.errorOnLoading.subscribe { [weak self] error in
			self?.showError(error)
		}
	}

	func showError(_ error: Error) {
		let alert = UIAlertController(title: "Ошибка",
									  message: error.localizedDescription,
									  preferredStyle: .alert)


		alert.addAction(.init(title: "Закрыть", style: .cancel))

		self.navigationController?.pushViewController(alert, animated: true)
	}

	func loadImage(with imgString: String) {
		self.viewModel.loadImage(with: imgString)
	}
}
