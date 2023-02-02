//
//  AnimeDetailsAssembly.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import UIKit

enum AnimeDetailsAssembly {
	struct Dependencies {
		let apiRepository: IApiRepository
		let imageDownloadService: IImageDownloadService
	}

	struct Parameters {
		let animeId: String
	}

	static func build(with parameters: Parameters, and dependencies: Dependencies) -> UIViewController {
		let viewModel = AnimeDetailsViewModel(apiRepository: dependencies.apiRepository,
											  imageDownloadService: dependencies.imageDownloadService)
		let viewController = AnimeDetailsViewController(animeId: parameters.animeId,
														viewModel: viewModel)

		return viewController
	}
}
