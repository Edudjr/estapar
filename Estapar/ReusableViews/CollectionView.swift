//
//  CollectionView.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

import UIKit
import DeclarativeUIKit

final class CollectionView<Data>: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
where Data: RandomAccessCollection {

    private let collection: Data
    private let builder: (Data.Element) -> [UIView]
    private let layout: CollectionViewLayout
    private var collectionview: UICollectionView?

    public init(_ collection: Data,
                layout: CollectionViewLayout = CollectionViewLayout(itemsPerRow: 2),
                @DeclarativeViewBuilder builder: @escaping (Data.Element) -> [UIView]) {
        self.collection = collection
        self.builder = builder
        self.layout = layout

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create an instance of UICollectionViewFlowLayout since you cant
        // Initialize UICollectionView without a layout
        let flowLayout = UICollectionViewFlowLayout()
        let padding: CGFloat = 20.0
        let width = view.frame.width / CGFloat(layout.itemsPerRow) - padding
        let height = width * 0.8
        flowLayout.itemSize = CGSize(width: width, height: height)

        self.collectionview = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)

        guard let collectionview else { return }

        collectionview.collectionViewLayout = flowLayout
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(ReusableCollectionViewCell.self,
                                forCellWithReuseIdentifier: ReusableCollectionViewCell.reuseIdentifier)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.white

        view.add(collectionview).backgroundColor(.white)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReusableCollectionViewCell.reuseIdentifier,
                                                          for: indexPath) as? ReusableCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        // 1. Getting the element from the collection
        let itemIndex = collection.index(collection.startIndex, offsetBy: indexPath.row)
        let item = collection[itemIndex]

        // 2. Build the view
        let view = VerticalStack {
            builder(item)
        }

        // 3. Inject it
        cell.inject(view)
        return cell
    }


    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}

final class ReusableCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ReusableCollectionViewCell"

    func inject(_ view: UIView) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.add(view)
        contentView.backgroundColor(.white)
    }
}

struct CollectionViewLayout {
    let itemsPerRow: Int
}
