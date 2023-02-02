//
//  MainRouter.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import UIKit

protocol IMainRouter {
	func start() -> UINavigationController
}

final class MainRouter {
	private let screensFactory: IScreensFactory

	private var navigationController: UINavigationController?

	init(screensFactory: IScreensFactory) {
		self.screensFactory = screensFactory
	}
}

extension MainRouter: IMainRouter {
	func start() -> UINavigationController {
		let completionHandler: (String) -> Void = { [weak self] animeId in
			self?.showAnimeDetails(with: animeId)
		}

		let parameters = PopularAnimeListAssembly.Parameters(completionHandler: completionHandler)
		let startViewController = self.screensFactory.makePopularAnimeList(with: parameters)

		let navigationController = UINavigationController(rootViewController: startViewController)

		self.navigationController = navigationController

		return navigationController
	}
}

private extension MainRouter {
	func showAnimeDetails(with animeId: String) {
		let parameters = AnimeDetailsAssembly.Parameters(animeId: animeId)
		let viewController = self.screensFactory.makeAnimeDetails(with: parameters)

		self.navigationController?.pushViewController(viewController, animated: true)
	}
}
