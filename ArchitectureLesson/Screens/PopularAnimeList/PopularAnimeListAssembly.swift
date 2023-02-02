//
//  PopularAnimeListAssembly.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import UIKit

enum PopularAnimeListAssembly {
	struct Dependencies {
		let apiRepository: IApiRepository
	}

	struct Parameters {
		let completionHandler: ((String) -> Void)
	}

	static func build(with parameters: Parameters, and dependencies: Dependencies) -> UIViewController {
		let router = PopularAnimeListRouter(completionHandler: parameters.completionHandler)
		let interactor = PopularAnimeListInteractor(apiRepository: dependencies.apiRepository)

		let presenter = PopularAnimeListPresenter(interactor: interactor, router: router)
		let viewController = PopularAnimeListViewController(presenter: presenter)
		presenter.setViewController(vc: viewController)

		return viewController
	}
}
