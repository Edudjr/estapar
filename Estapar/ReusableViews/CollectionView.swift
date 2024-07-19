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
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // The first section is used for padding
        2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return collection.count
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // The first section is only added for some Padding
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: headerTopPadding)
        }

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

        // The first section is only added for some Padding
        if indexPath.section == 0 {
            cell.inject(UIView())
            return cell
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

    func collectionView(_ collectionView: UICollectionView, 
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView
                .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                  withReuseIdentifier: ReusableCollectionViewCell.reuseIdentifier, for: indexPath) as! ReusableCollectionViewCell

            if let headerView = headerBuilder?() {
                header.inject(headerView)
            }

            return header
            
        default:  
            fatalError("Unexpected element kind")
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.zero
        }

        if headerBuilder != nil  {
            // Get the view for the first header
            let indexPath = IndexPath(row: 0, section: section)
            let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)

            // Use this view to calculate the optimal size based on the collection view's width
            return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
                                                      withHorizontalFittingPriority: .required, // Width is fixed
                                                      verticalFittingPriority: .fittingSizeLevel) // Height can be as large as needed
        } else {
            return CGSize.zero
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
