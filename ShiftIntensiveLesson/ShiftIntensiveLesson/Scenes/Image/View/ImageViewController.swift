//
//  ImageViewController.swift
//  ShiftIntensiveLesson
//
//  Created by Abrosimov Ilya on 31.01.2023.
//

import UIKit

class ImageViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var button: UIButton!

	private let activityIndicator = UIActivityIndicatorView()

	@IBAction func loadImage(_ sender: Any) {
		guard let url = URL(string: "https://www.pcclean.io/wp-content/uploads/2020/4/buIRry.jpg") else { return }


		activityIndicator.startAnimating()
		activityIndicator.isHidden = false
		button.isHidden = true

		let session = URLSession.shared
		let task = session.dataTask(with: url) { data, response, error in
			if let data = data, let image = UIImage(data: data) {
				DispatchQueue.main.async {
					self.activityIndicator.stopAnimating()
					self.imageView.image = image
				}
			}
		}

		task.resume()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addSubview(activityIndicator)
		activityIndicator.isHidden = true
		activityIndicator.hidesWhenStopped = true
	}
}
