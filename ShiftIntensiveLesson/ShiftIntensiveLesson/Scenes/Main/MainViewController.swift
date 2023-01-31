//
//  MainViewController.swift
//  ShiftIntensiveLesson
//
//  Created by Abrosimov Ilya on 31.01.2023.
//

import UIKit

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
		testGetRequest()
	}

	@IBAction func goToPostRequest(_ sender: Any) {
		testPostRequest()
	}

	override func viewDidLoad() {
        super.viewDidLoad()
    }

	func testGetRequest() {
		
	}

	func testPostRequest() {

	}
}
