//
//  CollectionViewCell + Ext .swift
//  RxWeather
//
//  Created by Дина Турман on 03.09.2022.
//

import UIKit

public extension UICollectionView {
    // MARK: - UICollectionViewCell
    
    /// Регистрирует переданные типы ячеек. Если удалось найти nib-файл для типа, регистрирует nib, если нет, то
    /// регистрирует сам тип.
    final func register(_ cellTypes: [UICollectionViewCell.Type]) {
        cellTypes.forEach(register)
    }

    /// Регистрирует переданный тип ячейки. Если удалось найти nib-файл для типа, регистрирует nib, если нет, то
    /// регистрирует сам тип.
    final func register(_ cellType: UICollectionViewCell.Type) {
        if let nib = cellType.nib() {
            register(nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
        } else {
            register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
        }
    }
    
    /// Делает dequeueReusableCell(withReuseIdentifier:for:) и сразу кастит возвращаемую ячейку в нужный тип.
    /// В качестве идентификатора используется название класса. Для задания своего идентификатора нужно переопределить
    /// static var reuseIdentifier в классе ячейки.
    final func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Не удалось сделать dequeue ячейки с типом \(T.self) " +
                    "и reuseIdentifier \(T.reuseIdentifier). " +
                    "Убедитесь, что вы зарегистировали ячейку"
            )
        }
        
        return cell
    }
    
    // MARK: - UICollectionReusableView
    
    /// Регистрирует переданный тип supplementaryView. Если удалось найти nib-файл для типа, регистрирует nib,
    /// если нет, то регистрирует сам тип.
    final func register(supplementaryViewType: UICollectionReusableView.Type,
                        ofKind elementKind: String) {
        if let nib = supplementaryViewType.nib() {
            register(nib,
                     forSupplementaryViewOfKind: elementKind,
                     withReuseIdentifier: supplementaryViewType.reuseIdentifier)
        } else {
            register(supplementaryViewType.self,
                     forSupplementaryViewOfKind: elementKind,
                     withReuseIdentifier: supplementaryViewType.reuseIdentifier)
        }
    }

    /// Делает dequeueReusableSupplementaryView(ofKind:withReuseIdentifier:for:) и сразу кастит возвращаемую ячейку в
    /// нужный тип.
    /// В качестве идентификатора используется название класса. Для задания своего идентификатора нужно переопределить
    /// static var reuseIdentifier в классе ячейки.
    final func dequeueSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String,
                                                                     for indexPath: IndexPath) -> T {
        guard let view = self.dequeueReusableSupplementaryView(ofKind: elementKind,
                                                               withReuseIdentifier: T.reuseIdentifier,
                                                               for: indexPath) as? T else {
            fatalError(
                "Не удалось сделать dequeue supplementary view с типом \(T.self) " +
                    "и reuseIdentifier \(T.reuseIdentifier). " +
                    "Убедитесь, что вы зарегистировали supplementary view"
            )
        }
        
        return view
    }
}
