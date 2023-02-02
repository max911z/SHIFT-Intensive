//
//  Observable.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

final class Observable<T> {
	var data: T?

	private var handle: ((T) -> Void)?

	init() {}

	init(_ data: T) {
		self.data = data
	}

	func updateModel(with data: T) {
		self.data = data
		self.handle?(data)
	}

	func subscribe(with handle: @escaping ((T) -> Void)) {
		self.handle = handle

		guard let data = self.data else { return }
		self.handle?(data)
	}
}
