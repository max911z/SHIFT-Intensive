//
//  PopularAnimeListInteractor.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

protocol IPopularAnimeListInteractor {
	func getPopularAnimeList(completion: @escaping (Result<[PopularAnimeElementDTO], Error>) -> Void)
}

final class PopularAnimeListInteractor {
	private let apiRepository: IApiRepository

	private var page = 1

	init(apiRepository: IApiRepository) {
		self.apiRepository = apiRepository
	}
}

extension PopularAnimeListInteractor: IPopularAnimeListInteractor {
	func getPopularAnimeList(completion: @escaping (Result<[PopularAnimeElementDTO], Error>) -> Void) {
		let query = PopularAnimeQuery(page: self.page)

		self.page += 1

		self.apiRepository.loadAnimeTopList(query: query, completion: completion)
	}
}
