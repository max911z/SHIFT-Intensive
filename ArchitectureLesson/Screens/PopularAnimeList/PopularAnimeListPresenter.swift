//
//  PopularAnimeListPresenter.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

final class PopularAnimeListPresenter {
	private let interactor: IPopularAnimeListInteractor
	private let router: IPopularAnimeListRouter
	private weak var viewController: PopularAnimeListViewController?

	private var isLoading = false

	init(interactor: IPopularAnimeListInteractor,
		 router: IPopularAnimeListRouter) {
		self.interactor = interactor
		self.router = router
	}

	func setViewController(vc: PopularAnimeListViewController) {
		self.viewController = vc

		self.setHandlers()
	}

	func loadNextPagePopularAnimeList() {
		self.isLoading = true

		self.interactor.getPopularAnimeList { result in
			switch result {
			case .success(let popularAnimeListDto):
				self.successLoadingHandle(with: popularAnimeListDto)
			case .failure(let error):
				self.failureLoadingHandle(with: error)
			}
		}
	}
}

private extension PopularAnimeListPresenter {
	func successLoadingHandle(with popularAnimeListDto: [PopularAnimeElementDTO]) {
		let popularAnimeList = popularAnimeListDto.map { PopularAnimeListModel(animeId: $0.animeID, titleName: $0.animeTitle) }
		self.viewController?.addNewPopularAnimes(with: popularAnimeList)
		self.isLoading = false
	}

	func failureLoadingHandle(with error: Error) {
		self.viewController?.showError(error)
		self.isLoading = false
	}

	func setHandlers() {
		self.viewController?.didSelectAnimeHandler = { [weak self] animeId in
			self?.router.goToAnimeDetails(with: animeId)
		}
	}
}
