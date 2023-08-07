import UIKit
import Kingfisher

class WeatherAlertCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!

    @IBOutlet weak var sourceLabel: UILabel!

    @IBOutlet weak var imageView: UIImageView!

    static let cellID = String(describing: WeatherAlertCollectionViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        imageView.image = nil
    }

    func setUp(with model: (any WeatherAlertCellModel)?) {
        titleLabel.text = model?.title
        durationLabel.text = model?.duration
        startLabel.text = model?.start
        endLabel.text = model?.end
        sourceLabel.text = model?.source
        imageView.image = model?.image
    }

    private func loadImage(from url: URL?, key: String?) {
        guard let url = url else { return }

        if let key = key {
            let resource = KF.ImageResource(downloadURL: url, cacheKey: key)
            imageView.kf.setImage(with: resource)
        } else {
            let image = UIImage(named: "default_profile_icon")
            imageView.kf.setImage(with: url, placeholder: image)
        }
    }
}
