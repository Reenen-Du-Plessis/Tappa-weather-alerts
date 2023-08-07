import Foundation
import UIKit

class LayoutProvider {
    enum LayoutType {
        case flow
        case linByLine
    }

    static func layout(for type: LayoutType) -> UICollectionViewLayout {
        switch type {
        case .flow:
            return UICollectionViewFlowLayout()
        case .linByLine:
            return linByLineLayout()
        }
    }

    static private func linByLineLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let inset: CGFloat = 5

            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .estimated(150))

            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                         leading: inset,
                                                         bottom: 0,
                                                         trailing: inset)

            //Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .estimated(150))

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])

            //Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                            leading: 10,
                                                            bottom: 20,
                                                            trailing: 10)
            section.interGroupSpacing = 10

            return section
        })
    }
}
