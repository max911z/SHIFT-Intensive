//
//  CustomCollectionViewController.swift
//  CollectionViewAndAnimationsApp
//
//  Created by Zharas Muzarap on 29.01.2023.
//

import UIKit

class CustomCollectionViewController: UICollectionViewController {
	
	private enum Constants {
		static let itemsInRow = 3
		static let itemsCount = 24
		
		static let viewInsets = UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8)
		static let insets = UIEdgeInsets(top: 12, left: 4, bottom: 12, right: 4)
		static let lineSpace: CGFloat = 12
		static let itemSpace: CGFloat = 12
	}

	let colors: [UIColor] = [.systemGreen, .systemBlue, .systemRed, .systemGray]

    override func viewDidLoad() {
        super.viewDidLoad()
		collectionView.contentInset = Constants.viewInsets
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
		return Constants.itemsCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as? ColorCell
		else {
			return UICollectionViewCell()
		}

		cell.backgroundColor = colors[indexPath.row % colors.count]
		cell.layer.borderWidth = 2
		cell.layer.borderColor = UIColor.black.cgColor
		cell.layer.cornerRadius = 16
		
		cell.alpha = 0
		cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        return cell
    }
	
	override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		UIView.animate(withDuration: 0.7,
					   delay: 0.2,
					   usingSpringWithDamping: 0.7,
					   initialSpringVelocity: 10,
					   options: []) {
			cell.alpha = 1
			cell.transform = .identity
		}
	}
	
}

extension CustomCollectionViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let sideInsets = (Constants.insets.left + Constants.viewInsets.left) * 2
		let insetsSum = Constants.itemSpace * (CGFloat(Constants.itemsInRow) - 1) + sideInsets
		let otherSpace = collectionView.frame.width - insetsSum
		let cellWidth = otherSpace / CGFloat(Constants.itemsInRow)
		return CGSize(width: cellWidth, height: cellWidth)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return Constants.insets
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return Constants.lineSpace
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return Constants.itemSpace
	}
}
