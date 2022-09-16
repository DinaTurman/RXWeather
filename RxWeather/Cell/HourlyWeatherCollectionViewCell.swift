//
//  HourlyWeatherCollectionViewCell.swift
//  RxWeather
//
//  Created by Дина Турман on 03.09.2022.
//

import UIKit

final class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var weatherImage: UIImageView!
    @IBOutlet private var temperatureLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.cgColor
    }
    
    // MARK: - Public methods
    
//    func configure(with item: GuideCarouselItem) {
//        self.item = item
//
//        configureBackgroundColor(with: UIColor(hexString: item.backgroundColor))
//        configureTitleLabel(with: item.title)
//        configureImageView(with: URL(string: item.imageUrl))
//
//        addBorderIfNeeded(for: item)
//    }
//
//    // MARK: - Private methods
//
//    private func configureBackgroundColor(with color: UIColor) {
//        backgroundColor = color
//    }
//
//    private func configureTitleLabel(with title: String) {
//        titleLabel.setText(title, textStyle: .body2, fontWeight: .semibold)
//    }
//
//    private func configureImageView(with url: URL?) {
//        imageView.sd_setImage(with: url,
//                              placeholderImage: ImageFactory.withType(.guideArticlePlaceholder),
//                              options: .retryFailed)
//    }
//
//    private func addBorderIfNeeded(for item: GuideCarouselItem) {
//        if item.backgroundColor == Color.white.toHexString() {
//            layer.borderWidth = 1
//            layer.borderColor = Color.black.withAlphaComponent(0.1).cgColor
//        }
//    }
}
//private var model: [BirthdayUser] = []
//weak var delegate: CellDelegate?
//
//override func awakeFromNib() {
//    super.awakeFromNib()
//    setupView()
//}
//    
//private func setupView() {
//    let layout = UICollectionViewFlowLayout()
//    layout.scrollDirection = .horizontal
//    layout.minimumLineSpacing = 24
//    layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//    birthdayCollectionView.collectionViewLayout = layout
//    birthdayCollectionView.register(BirthdayCollectionViewCell.self)
//}
//
//func configure(with model: [BirthdayUser]) {
//    self.model = model
//    birthdayCollectionView.reloadData()
//}
//}
//
//extension BirthdayTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
//func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    model.count
//}
//
//func collectionView(_ collectionView: UICollectionView,
//                    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell: BirthdayCollectionViewCell = birthdayCollectionView.dequeueReusableCell(for: indexPath)
//    cell.configureCollectionCell(with: model[indexPath.row])
//    return cell
//}
//
//func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    let id = "\(model[indexPath.row].id)"
//    let profileVC = ProfileViewController(id: id, backButtonIsHidden: false)
//    delegate?.showEmployeeDetail(vc: profileVC)
//}
//}
//
//extension BirthdayTableViewCell: UICollectionViewDelegateFlowLayout {
//func collectionView(_ collectionView: UICollectionView,
//                    layout collectionViewLayout: UICollectionViewLayout,
//                    sizeForItemAt indexPath: IndexPath) -> CGSize {
//    CGSize(width: 100, height: 180)
//}
//}
