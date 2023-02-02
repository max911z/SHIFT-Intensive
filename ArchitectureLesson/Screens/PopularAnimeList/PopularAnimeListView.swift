//
//  PopularAnimeListView.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import UIKit
import SnapKit

protocol IPopularAnimeListView: UIView {
	var nextPageButtonTapHandler: (() -> Void)? { get set }

	func reloadTableViewData()
	func setupTableView(delegate: UITableViewDelegate, dataOutput: UITableViewDataSource)
}

final class PopularAnimeListView: UIView {
	private enum Metrics {
		static let tableViewCellHeight: CGFloat = 65

		static let nextButtonCornerRadius: CGFloat = 12
		static let nextButtonHeight: CGFloat = 45
		static let nextButtonWidthMultiplier: CGFloat = 0.95
		static let nextButtonBottomInset: CGFloat = 24
		static let nextButtonEdgeInstets: CGFloat = 5
	}

	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)

		tableView.backgroundColor = .systemBackground
		tableView.isScrollEnabled = true
		tableView.register(PopularAnimeListTableCell.self,
						   forCellReuseIdentifier: PopularAnimeListTableCell.reuseIdentifier)
		tableView.rowHeight = Metrics.tableViewCellHeight

		return tableView
	}()

	private lazy var nextPageButton: UIButton = {
		let button = UIButton(frame: .zero)
		button.setTitle("Загрузить следующую страницу топа", for: .normal)
		button.backgroundColor = .systemBlue
		button.layer.cornerRadius = Metrics.nextButtonCornerRadius
		button.layer.masksToBounds = true
		button.titleEdgeInsets = .init(top: Metrics.nextButtonBottomInset,
									   left: Metrics.nextButtonBottomInset,
									   bottom: Metrics.nextButtonBottomInset,
									   right: Metrics.nextButtonBottomInset)

		return button
	}()

	var nextPageButtonTapHandler: (() -> Void)?

	private var tableViewDataOutput: UITableViewDataSource?
	private var tableViewDelegate: UITableViewDelegate?

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.addSubview(self.tableView)
		self.addSubview(self.nextPageButton)

		self.setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension PopularAnimeListView: IPopularAnimeListView {
	func reloadTableViewData() {
		self.tableView.reloadData()
	}

	func setupTableView(delegate: UITableViewDelegate, dataOutput: UITableViewDataSource) {
		self.tableViewDelegate = delegate
		self.tableViewDataOutput = dataOutput
		self.tableView.delegate = self.tableViewDelegate
		self.tableView.dataSource = self.tableViewDataOutput
	}
}

private extension PopularAnimeListView {
	func setup() {
		self.configureUI()
		self.configureConstraints()
		self.configureActions()
	}

	func configureUI() {
		self.backgroundColor = .systemBackground
	}

	func configureConstraints() {
		self.tableView.snp.makeConstraints { make in
			make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
			make.leading.trailing.equalToSuperview()
			make.bottom.equalToSuperview()
		}

		self.nextPageButton.snp.makeConstraints { make in
			make.width.equalToSuperview().multipliedBy(Metrics.nextButtonWidthMultiplier)
			make.height.equalTo(Metrics.nextButtonHeight)
			make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(Metrics.nextButtonBottomInset)
			make.centerX.equalToSuperview()
		}
	}

	func configureActions() {
		self.nextPageButton.addTarget(self, action: #selector(self.nextPageButtonTapped), for: .touchUpInside)
	}

	@objc
	func nextPageButtonTapped() {
		self.nextPageButtonTapHandler?()
	}
}
