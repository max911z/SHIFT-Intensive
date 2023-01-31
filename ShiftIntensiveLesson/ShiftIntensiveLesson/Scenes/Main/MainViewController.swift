//
//  MainViewController.swift
//  ShiftIntensiveLesson
//
//  Created by Abrosimov Ilya on 31.01.2023.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {

	@IBAction func goToTableView(_ sender: Any) {
		let tableVC = TableViewController(nibName: "TableViewController", bundle: nil)
		navigationController?.pushViewController(tableVC, animated: true)
	}

	@IBAction func goToDownloadImage(_ sender: Any) {
		let imageVC = ImageViewController(nibName: "ImageViewController", bundle: nil)
		navigationController?.pushViewController(imageVC, animated: true)
	}

	@IBAction func goToGetRequest(_ sender: Any) {
//		testGetRequest()
//		testGetRequestWithAlamofire()
	}

	@IBAction func goToPostRequest(_ sender: Any) {
		testPostRequest()
	}

	override func viewDidLoad() {
        super.viewDidLoad()
    }

	func testGetRequest() {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

		let session = URLSession.shared

		let task = session.dataTask(with: url) { data, response, error in
			print(response)
			print(data)

			guard let data = data else { return }

			do {
				let json = try JSONSerialization.jsonObject(with: data)
				print(json)
			} catch {
				print(error)
			}
		}

		task.resume()
	}

//	struct Article: Decodable {
//		let userId: Int
//		let id: Int
//		let title: String
//		let body: String
//	}

//	func testGetRequestWithAlamofire() {
//		guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
//
//		AF.request(url, method: .get)
//			.validate()
//			.responseData { response in
//				switch response.result {
//				case .success(let data):
//					guard let decodedData = try? JSONDecoder().decode([Article].self, from: data) else { return }
//					print(decodedData)
//				case .failure(let error):
//					print(error)
//				}
//			}
//	}

	func testPostRequest() {
		guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

		let dataToPost = ["Organization": "CFT", "Course": "Shift Intensive"]

		var urlRequest = URLRequest(url: url)

		urlRequest.httpMethod = "POST"
		urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

		guard let requestBody = try? JSONSerialization.data(withJSONObject: dataToPost) else { return }

		urlRequest.httpBody = requestBody

		let session = URLSession.shared

		let task = session.dataTask(with: urlRequest) { data, response, error in
			print(response)

			guard let data = data else { return }

			do {
				let json = try JSONSerialization.jsonObject(with: data)
				print(json)
			} catch {
				print(error)
			}
		}
		task.resume()
	}
}
