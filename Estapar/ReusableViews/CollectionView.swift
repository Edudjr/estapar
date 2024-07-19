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
    private var headerBuilder: (() -> UIView)?
    private let builder: (Data.Element) -> [UIView]
    private let layout: CollectionViewLayout
    private var collectionview: UICollectionView?
    private var headerTopPadding: CGFloat = 40

    private var headerView: UIView?

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
        self.collectionview = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)

        guard let collectionview else { return }

        flowLayout.sectionHeadersPinToVisibleBounds = true

        collectionview.collectionViewLayout = flowLayout
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(ReusableCollectionViewCell.self,
                                forCellWithReuseIdentifier: ReusableCollectionViewCell.reuseIdentifier)
        collectionview.register(ReusableCollectionViewCell.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ReusableCollectionViewCell.reuseIdentifier)

        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.white

        view.add(collectionview).backgroundColor(.white)

        // Initialize and configure the header view

        guard let header = headerBuilder?() else { return }
        headerView = header

        // Set up initial constraints for the header view
        collectionview
            .addSubview(header)
        
        header
            .connect(\.leadingAnchor, to: collectionview.leadingAnchor)
            .connect(\.trailingAnchor, to: collectionview.trailingAnchor)
            .connect(\.topAnchor, to: collectionview.topAnchor, padding: headerTopPadding)
            .connect(\.widthAnchor, to: collectionview.widthAnchor)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collection.count
    }

    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20.0
        let width = view.frame.width / CGFloat(layout.itemsPerRow) - padding
        let height = width * 0.8
        return CGSize(width: width, height: height)
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
        let totalHeaderHeight = (headerView?.bounds.size.height ?? 0.0) + headerTopPadding
        return UIEdgeInsets(top: totalHeaderHeight, left: 15, bottom: 0, right: 15)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let stickyOffset: CGFloat = headerTopPadding // Adjust this value to your desired sticky point

        let yOffset = scrollView.contentOffset.y + scrollView.contentInset.top

        guard let collectionview else { return }

        // Adjust the top constraint of the header view
        for constraint in collectionview.constraints {
            if constraint.firstItem === headerView && constraint.firstAttribute == .top {
                constraint.constant = max(yOffset, stickyOffset)
            }
        }
    }

    @discardableResult
    func header(topPadding: CGFloat = 40, _ builder: @escaping () -> UIView) -> Self {
        self.headerTopPadding = topPadding
        headerBuilder = builder
        return self
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
