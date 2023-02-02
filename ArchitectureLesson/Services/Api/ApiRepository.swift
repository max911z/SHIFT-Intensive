//
//  ApiService.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import Foundation
import Alamofire

protocol IApiRepository {
	func loadAnimeTopList(query: PopularAnimeQuery?, completion: @escaping (Result<[PopularAnimeElementDTO], Error>) -> Void)
	func loadAnimeDetails(with animeId: String, completion: @escaping (Result<AnimeDetailsDTO, Error>) -> Void)
}

extension IApiRepository {
	func loadAnimeTopList(query: PopularAnimeQuery? = nil, completion: @escaping (Result<[PopularAnimeElementDTO], Error>) -> Void) {
		self.loadAnimeTopList(query: query, completion: completion)
	}
}

final class ApiRepository {
	private let baseUrl: String = "https://gogoanime.consumet.stream/"

	private let session: Alamofire.Session

	init() {
		self.session = .default
	}
}

extension ApiRepository: IApiRepository {
	func loadAnimeTopList(query: PopularAnimeQuery? = nil, completion: @escaping (Result<[PopularAnimeElementDTO], Error>) -> Void) {
		self.session.request(self.baseUrl + "popular",
							 method: .get,
							 parameters: query)
		.responseDecodable(of: [PopularAnimeElementDTO].self) { response in
			if let error = response.error?.underlyingError {
				completion(.failure(error))
				return
			}

			guard let popularAnime = response.value else {
				completion(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
				return
			}

			completion(.success(popularAnime))
		}
	}

	func loadAnimeDetails(with animeId: String, completion: @escaping (Result<AnimeDetailsDTO, Error>) -> Void) {
		self.session.request(self.baseUrl + "anime-details/" + animeId,
							 method: .get)
		.responseDecodable(of: AnimeDetailsDTO.self) { response in
			if let error = response.error?.underlyingError {
				completion(.failure(error))
				return
			}

			guard let animeDetails = response.value else {
				completion(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
				return
			}

			completion(.success(animeDetails))
		}
	}
}
