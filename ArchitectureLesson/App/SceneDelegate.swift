//
//  SceneDelegate.swift
//  ArchitectureLesson
//
//  Created by Фомин Александр Андреевич on 02.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	private var mainRouter: IMainRouter?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		let window = UIWindow(windowScene: windowScene)

		let apiRepository = ApiRepository()
		let imageDownloadService = ImageDownloadService()
		let screensFactory = ScreensFactory(apiRepository: apiRepository, imageDownloadService: imageDownloadService)
		self.mainRouter = MainRouter(screensFactory: screensFactory)

		let navigationController = self.mainRouter?.start()

		window.rootViewController = navigationController

		self.window = window
		self.window?.makeKeyAndVisible()
	}
}

