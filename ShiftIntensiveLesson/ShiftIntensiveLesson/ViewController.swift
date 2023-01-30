//
//  ViewController.swift
//  ShiftIntensiveLesson
//
//  Created by Abrosimov Ilya on 30.01.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var tableView: UITableView!

	let people: [Human] = [
		Human(name: "Ilya", height: 172.0, weight: 85.0),
		Human(name: "Liza", height: 160, weight: 50),
		Human(name: "Anna", height: 123, weight: 25),
		Human(name: "Lena", height: 180, weight: 52),
		Human(name: "Max", height: 178, weight: 73),
	]

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		tableView.register(UINib(nibName: "HumanTableViewCell", bundle: nil), forCellReuseIdentifier: "HumanTableViewCell")
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return people.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		guard let cell = tableView.dequeueReusableCell(withIdentifier: "HumanTableViewCell", for: indexPath) as? HumanTableViewCell else {
			return UITableViewCell()
		}

		cell.configure(with: people[indexPath.row])
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let alert = UIAlertController(title: "Привет!", message: "Меня зовут \(people[indexPath.row].name)!", preferredStyle: .alert)
		let action = UIAlertAction(title: "Закрыть", style: .cancel)
		alert.addAction(action)

		self.present(alert, animated: true)
	}
}

