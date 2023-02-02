//
//  PopularAnimeListRouter.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//


protocol IPopularAnimeListRouter {
	func goToAnimeDetails(with animeId: String)
}

final class PopularAnimeListRouter {
	private var completionHandler: ((String) -> Void)?

	init(completionHandler: ((String) -> Void)?) {
		self.completionHandler = completionHandler
	}
}

extension PopularAnimeListRouter: IPopularAnimeListRouter {
	func goToAnimeDetails(with animeId: String) {
		self.completionHandler?(animeId)
	}
}
