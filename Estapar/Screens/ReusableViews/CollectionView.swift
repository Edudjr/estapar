//
//  CollectionView.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 19/07/24.
//

import UIKit
import DeclarativeUIKit
import Kingfisher

final class CollectionView<Data>: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
where Data: RandomAccessCollection {

    private let collection: Data
   
    private let builder: (Data.Element) -> [UIView]
    private let layout: CollectionViewLayout
    private var collectionview: UICollectionView?

    private var headerView: UIView?
    private var headerBuilder: (() -> UIView)?
    private var headerBackgroundView: UIView?
    private var headerBackgroundViewOverlay = UIView()

    private var headerTopPadding: CGFloat = 0
    private var totalHeaderHeight: CGFloat {
        (headerView?.bounds.size.height ?? 0.0) + headerTopPadding
    }

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

        setupCollectionView()
        let topNotch = setupTopNotch()
        let header = setupHeader(topNotch: topNotch)
        setupHeaderBackgroundImage(header: header)
    }

    @discardableResult
    func header(backgroundImageURL: String? = nil, topPadding: CGFloat = 120, _ builder: @escaping () -> UIView) -> Self {
        self.headerTopPadding = topPadding
        headerBuilder = builder
        setHeaderBackgroundImage(url: backgroundImageURL ?? "")
        return self
    }

    private func setupCollectionView() {
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
        collectionview.backgroundColor = UIColor.clear

        view.add(collectionview).backgroundColor(.primaryWhite)
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
        let extraPadding = 20.0
        let totalPadding = totalHeaderHeight + extraPadding
        return UIEdgeInsets(top: totalPadding, left: 15, bottom: 0, right: 15)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let stickyOffset: CGFloat = headerTopPadding

        let yOffset = scrollView.contentOffset.y + scrollView.contentInset.top

        guard let collectionview else { return }

        // Adjust the top constraint of the header view
        for constraint in collectionview.constraints {
            if constraint.firstItem === headerView && constraint.firstAttribute == .top {
                constraint.constant = max(yOffset, stickyOffset)
            }
        }
        
        updateHeaderBackgroundColor(forYOffset: yOffset)
    }

    private func updateHeaderBackgroundColor(forYOffset offset: CGFloat) {
        let percentage = calculateCollapsedPercentage(forYOffset: offset)
        setHeaderBackgroundColor(forCollapsedPercantage: percentage)
    }

    private func setHeaderBackgroundColor(forCollapsedPercantage percentage: CGFloat) {
        headerBackgroundViewOverlay.backgroundColor(ColorScheme.zulPrimary700.uiColor.withAlphaComponent(percentage/100.0))
    }

    private func calculateCollapsedPercentage(forYOffset offset: CGFloat) -> CGFloat {
        guard offset >= 0 else {
            return 0
        }
        guard offset <= headerTopPadding else {
            return 100
        }
        return (offset / headerTopPadding) * 100.0
    }
}

// MARK: Header Setup

extension CollectionView {
    private func setupTopNotch() -> UIView {
        // MARK: Rounded Notch
        let notch = TopNotch()
        view.addSubview(notch)

        notch
            .connect(\.leadingAnchor, to: view.leadingAnchor)
            .connect(\.trailingAnchor, to: view.trailingAnchor)

        view.sendSubviewToBack(notch)
        return notch
    }

    private func setupHeader(topNotch: UIView) -> UIView {
        guard
            let collectionview,
            let header = headerBuilder?()
        else {
            return UIView()
        }

        collectionview
            .addSubview(header)

        header
            .connect(\.leadingAnchor, to: collectionview.leadingAnchor)
            .connect(\.trailingAnchor, to: collectionview.trailingAnchor)
            .connect(\.topAnchor, to: collectionview.topAnchor, padding: headerTopPadding)
            .connect(\.widthAnchor, to: collectionview.widthAnchor)
            .connect(\.bottomAnchor, to: topNotch.topAnchor)

        self.headerView = header
        return header
    }

    private func setupHeaderBackgroundImage(header: UIView) {
        guard
            let collectionview
        else {
            return
        }

        guard let headerBackgroundView else { return }

        headerBackgroundView.add(headerBackgroundViewOverlay)

        headerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        collectionview.addSubview(headerBackgroundView)
        headerBackgroundView
            .connect(\.topAnchor, to: view.topAnchor)
            .connect(\.leadingAnchor, to: header.leadingAnchor)
            .connect(\.trailingAnchor, to: header.trailingAnchor)
            .connect(\.bottomAnchor, to: header.bottomAnchor)

        collectionview.bringSubviewToFront(header)
    }

    private func setHeaderBackgroundImage(url: String) {
        if let image = URL(string: url) {
            let imageView = UIImageView()
                .contentMode(.scaleAspectFill)
                .set(contentHuggingPriority: .defaultHigh, for: .vertical)
                .set(compressionResistance: .defaultLow, for: .vertical)
                .clipsToBounds(true)

            imageView.kf.setImage(with: image)
            self.headerBackgroundView = imageView
        }
    }
}

final class ReusableCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ReusableCollectionViewCell"

    func inject(_ view: UIView) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.add(view)
        contentView.backgroundColor(.primaryWhite)
    }
}

struct CollectionViewLayout {
    let itemsPerRow: Int
}
