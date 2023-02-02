//
//  ScreensFactory.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import UIKit

protocol IScreensFactory {
	func makePopularAnimeList(with parameters: PopularAnimeListAssembly.Parameters) -> UIViewController
	func makeAnimeDetails(with parameters: AnimeDetailsAssembly.Parameters) -> UIViewController
}

final class ScreensFactory {
	private let apiRepository: IApiRepository
	private let imageDownloadService: IImageDownloadService

	init(apiRepository: IApiRepository,
		 imageDownloadService: IImageDownloadService) {
		self.apiRepository = apiRepository
		self.imageDownloadService = imageDownloadService
	}
}

extension ScreensFactory: IScreensFactory {
	func makePopularAnimeList(with parameters: PopularAnimeListAssembly.Parameters) -> UIViewController {
		let dependencies = PopularAnimeListAssembly.Dependencies(apiRepository: self.apiRepository)

		let vc = PopularAnimeListAssembly.build(with: parameters, and: dependencies)

		return vc
	}

	func makeAnimeDetails(with parameters: AnimeDetailsAssembly.Parameters) -> UIViewController {
		let dependencies = AnimeDetailsAssembly.Dependencies(apiRepository: self.apiRepository,
															 imageDownloadService: self.imageDownloadService)

		let vc = AnimeDetailsAssembly.build(with: parameters, and: dependencies)

		return vc
	}
}
