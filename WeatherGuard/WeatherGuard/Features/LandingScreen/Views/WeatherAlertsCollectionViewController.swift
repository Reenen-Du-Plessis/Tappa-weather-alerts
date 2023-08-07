import UIKit

class WeatherAlertsCollectionViewController: UICollectionViewController {
    var viewModel: WeatherAlertsViewModel = WeatherAlertsCollectionViewModel(networkClient: WeatherAlertsNetworkClient())

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemGroupedBackground
        viewModel.fetchData { [weak self] success in
            self?.collectionView.reloadData()
        }
        registerCells()
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 20, height: 110)
        }
    }

    private func registerCells() {
        let cellClassString = WeatherAlertCollectionViewCell.cellID
        let nib = UINib(nibName: cellClassString, bundle: .main)
        let identifier = cellClassString
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items(for: section).count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherAlertCollectionViewCell.cellID, for: indexPath) as? WeatherAlertCollectionViewCell

        let cellModel = viewModel.model(for: indexPath)
        cell?.setUp(with: cellModel)

        cellModel?.fetchImage() { [weak collectionView] success in
            if success {
                UIView.performWithoutAnimation {
                    collectionView?.reloadItems(at: [indexPath])
                }
            }
        }
    
        return cell ?? UICollectionViewCell()
    }
}

extension WeatherAlertsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
    }
}
