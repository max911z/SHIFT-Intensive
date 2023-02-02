//
//  ImageDownloadService.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import Foundation
import UIKit
import Alamofire

protocol IImageDownloadService {
	func loadImage(urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}

final class ImageDownloadService: NSObject {
	private let session: Alamofire.Session

	override init() {
		self.session = .default
	}
}

extension ImageDownloadService: IImageDownloadService {
	func loadImage(urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
		print(urlString)
		self.session.download(urlString, method: .get).responseData { response in
			if let error = response.error?.underlyingError {
				completion(.failure(error))
				return
			}

			guard let data = response.value,
				  let image = UIImage(data: data)
			else {
				completion(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
				return
			}

			completion(.success(image))
		}
	}
}
