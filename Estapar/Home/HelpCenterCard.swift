//
//  HelpCenterCard.swift
//  Estapar
//
//  Created by Eduardo Domene Junior on 18/07/24.
//

import UIKit
import DeclarativeUIKit

class HelpCenterCard: UIView {
    lazy var body: UIView = {
        VerticalStack {
            UILabel()
                .text(title)
                .font(.boldSystemFont(ofSize: 18))
                .numberOfLines(2)
                .padding(.bottom, 28)

            HorizontalStack {
                UILabel()
                    .text("\(articlesNumber) artigos")
                    .font(.systemFont(ofSize: 12))

                UIImageView(image: UIImage(systemName: "arrow.right"))
                    .contentMode(.scaleAspectFit)
                    .set(contentHuggingPriority: .defaultHigh, for: .horizontal)
                    .padding(.leading, 20)
            }
            .alignment(.top)
            .padding(.leading, 10)

        }
        .backgroundColor(.white)
        .dropShadow()
    }()

    private let title: String
    private let articlesNumber: Int

    init(title: String, articlesNumber: Int) {
        self.title = title
        self.articlesNumber = articlesNumber
        super.init(frame: .zero)
        add(body)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var collectionview: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create an instance of UICollectionViewFlowLayout since you cant
        // Initialize UICollectionView without a layout
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 20.0
        let width = view.frame.width / 2 - padding
        let height = width * 0.8
        layout.itemSize = CGSize(width: width, height: height)

        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        guard let collectionview else { return }

        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(ReusableCollectionViewCell.self,
                                forCellWithReuseIdentifier: ReusableCollectionViewCell.reuseIdentifier)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.white
        self.view.addSubview(collectionview)
        self.collectionview = collectionview
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReusableCollectionViewCell.reuseIdentifier,
                                                          for: indexPath) as? ReusableCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let view = HelpCenterCard(title: "Serviço Estapar", articlesNumber: 18)
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

//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//    }



    func inject(_ view: UIView) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.add(view)
        contentView.backgroundColor(.white)
    }
}
