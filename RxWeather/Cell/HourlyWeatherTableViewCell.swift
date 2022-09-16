//
//  HourlyWeatherTableViewCell.swift
//  RxWeather
//
//  Created by Дина Турман on 03.09.2022.
//

import UIKit

class HourlyWeatherTableViewCell: UITableViewCell {
    // MARK: - Public properties
    
   // weak var delegate: AdvertDetailContainerViewControllerDelegate?
    
    // MARK: - Private properties
    
    @IBOutlet private var collectionView: UICollectionView!
    
//    private var carouselItems: [String] = [] {
//        didSet {
//            collectionView.reloadData()
//        }
//    }
//    
//    // MARK: - Init
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//        collectionView.register(HourlyWeatherCollectionViewCell.self)
//    }
//    
//    // MARK: - Public methods
//    
//    func configure(with items: [GuideCarouselItem]) {
//        carouselItems = items
//    }
//    
//    // MARK: - Private methods
//    
//    private func openGuideWebViewController(with indexPath: IndexPath) {
//        let carouselItem = carouselItems[indexPath.row]
//        let request = BaseWebViewRequest(urlString: carouselItem.url).request
//        let viewController = GuideWebViewController(request: request, shouldShare: carouselItem.kind == .article)
//        
//        delegate?.openGuideWebViewController(viewController, with: carouselItem)
//    }
//}
//
//extension HourlyWeatherTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        carouselItems.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView,
//                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell: GuideCarouselCollectionViewCell = collectionView.dequeueCell(for: indexPath)
//        cell.configure(with: carouselItems[indexPath.row])
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.cellForItem(at: indexPath)?.showAnimation { [weak self] in
//            self?.openGuideWebViewController(with: indexPath)
//        }
//    }
//}
//
//extension AdvertDetailGuideTableViewCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if carouselItems.count == 1 {
//            return CGSize(width: contentView.width - (16 * 2), height: 80)
//        }
//        
//        return CGSize(width: (268 / 320) * collectionView.frame.width, height: 80)
//    }
}
