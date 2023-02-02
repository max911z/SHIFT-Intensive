//
//  PopularAnimeListViewController.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import UIKit

final class PopularAnimeListViewController: UIViewController {
	private var ui: IPopularAnimeListView
	private var presenter: PopularAnimeListPresenter

	private var actualPopularAnimeList = [PopularAnimeListModel]()

	var didSelectAnimeHandler: ((String) -> Void)?

	init(presenter: PopularAnimeListPresenter) {
		self.ui = PopularAnimeListView(frame: .zero)
		self.presenter = presenter

		super.init(nibName: nil, bundle: nil)

		self.ui.setupTableView(delegate: self, dataOutput: self)
		self.setHandlers()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		self.view = ui
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.presenter.loadNextPagePopularAnimeList()
	}

	func addNewPopularAnimes(with models: [PopularAnimeListModel]) {
		self.actualPopularAnimeList.append(contentsOf: models)

		DispatchQueue.main.async { [weak self] in
			self?.ui.reloadTableViewData()
		}
	}

	func showError(_ error: Error) {
		let alert = UIAlertController(title: "Ошибка",
									  message: error.localizedDescription,
									  preferredStyle: .alert)


		alert.addAction(.init(title: "Закрыть", style: .cancel))

		self.navigationController?.pushViewController(alert, animated: true)
	}
}

private extension PopularAnimeListViewController {
	func setHandlers() {
		self.ui.nextPageButtonTapHandler = { [weak self] in
			guard let self = self else { return }

			self.presenter.loadNextPagePopularAnimeList()
		}
	}
}

extension PopularAnimeListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.actualPopularAnimeList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: PopularAnimeListTableCell.reuseIdentifier,
													   for: indexPath) as? PopularAnimeListTableCell
		else {
			return UITableViewCell()
		}

		cell.configure(with: self.actualPopularAnimeList[indexPath.row])

		return cell
	}
}

extension PopularAnimeListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)

		self.didSelectAnimeHandler?(self.actualPopularAnimeList[indexPath.row].animeId)
	}
}
