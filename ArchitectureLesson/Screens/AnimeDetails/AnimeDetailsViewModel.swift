//
//  AnimeDetailsViewModel.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import UIKit

protocol IAnimeDetailsViewModel {
	var animeDetails: Observable<AnimeDetailsModel> { get }
	var image: Observable<UIImage> { get }
	var errorOnLoading: Observable<Error> { get }

	func loadAnimeDetails(with animeId: String)
	func loadImage(with imgString: String)
}

final class AnimeDetailsViewModel {
	private let apiRepository: IApiRepository
	private let imageDownloadService: IImageDownloadService

	var animeDetails = Observable<AnimeDetailsModel>()
	var image = Observable<UIImage>()
	var errorOnLoading = Observable<Error>()

	init(apiRepository: IApiRepository,
		 imageDownloadService: IImageDownloadService) {
		self.apiRepository = apiRepository
		self.imageDownloadService = imageDownloadService
	}
}

extension AnimeDetailsViewModel: IAnimeDetailsViewModel {
	func loadAnimeDetails(with animeId: String) {
		self.apiRepository.loadAnimeDetails(with: animeId) { result in
			switch result {
			case .success(let animeDetailsDto):
				self.successLoadingHandle(with: animeDetailsDto)
			case .failure(let error):
				self.failureLoadingHandle(with: error)
			}
		}
	}

	func loadImage(with imgString: String) {
		self.imageDownloadService.loadImage(urlString: imgString) { result in
			switch result {
			case .success(let image):
				self.successLoadingHandle(with: image)
			case .failure(let error):
				self.failureLoadingHandle(with: error)
			}
		}
	}
}

private extension AnimeDetailsViewModel {
	func successLoadingHandle(with animeDetailsDto: AnimeDetailsDTO) {
		let animeDetails = AnimeDetailsModel(title: animeDetailsDto.animeTitle,
											 imgString: animeDetailsDto.animeImg)

		self.animeDetails.updateModel(with: animeDetails)
	}

	func successLoadingHandle(with image: UIImage) {
		self.image.updateModel(with: image)
	}

	func failureLoadingHandle(with error: Error) {
		self.errorOnLoading.updateModel(with: error)
	}
}
