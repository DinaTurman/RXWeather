//
//  Reusable.swift
//  RxWeather
//
//  Created by Дина Турман on 03.09.2022.
//

import UIKit

/// Протокол для любой вьюшки, которая имеет reuseIdentifier.
/// Протоколу следуют UITableViewCell, UITableViewHeaderFooterView, UITableViewHeaderFooterView и
/// UICollectionReusableView (соответственно, так же UICollectionViewCell)
public protocol Reusable: AnyObject {
    /// По умолчанию совпадает с названием типа. При необходимости можно переопределить.
    static var reuseIdentifier: String { get }
    
    /// Соответствующий Nib-файл. По умолчанию проверяет есть ли Nib с названием, совпадающим с названием класса, и,
    /// если есть, возвращает его, в противном случае возвращает nil. При необходимости можно переопределить.
    static func nib() -> UINib?
}

public extension Reusable {
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    static func nib() -> UINib? {
        guard Bundle(for: self).path(forResource: String(describing: self), ofType: "nib") != nil else {
            return  nil
        }
        
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}
extension UICollectionReusableView: Reusable {}


import UIKit

public extension UITableView {
    // MARK: - UITableViewCell
    
    /// Регистрирует переданные типы ячеек. Если удалось найти nib-файл для типа, регистрирует nib, если нет, то
    /// регистрирует сам тип.
    @objc(registerCellTypes:)
    final func register(_ cellTypes: [UITableViewCell.Type]) {
        cellTypes.forEach(register)
    }

    /// Регистрирует переданный тип ячейки. Если удалось найти nib-файл для типа, регистрирует nib, если нет, то
    /// регистрирует сам тип.
    final func register(_ cellType: UITableViewCell.Type) {
        if let nib = cellType.nib() {
            register(nib, forCellReuseIdentifier: cellType.reuseIdentifier)
        } else {
            register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
        }
    }
    
    /// Делает dequeueReusableCell(withIdentifier:for:) и сразу кастит возвращаемую ячейку в нужный тип.
    /// В качестве идентификатора используется название класса. Для задания своего идентификатора нужно переопределить
    /// static var reuseIdentifier в классе ячейки.
    final func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Не удалось сделать dequeue ячейки с типом \(T.self) " +
                    "и reuseIdentifier \(T.reuseIdentifier). " +
                    "Убедитесь, что вы зарегистировали ячейку"
            )
        }
        
        return cell
    }
    
    // MARK: - UITableViewHeaderFooterView
    
    /// Регистрирует переданный тип headerFooterView. Если удалось найти nib-файл для типа, регистрирует nib,
    /// если нет, то регистрирует сам тип.
    final func register(_ headerFooterViewType: UITableViewHeaderFooterView.Type) {
        if let nib = headerFooterViewType.nib() {
            register(nib,
                     forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
        } else {
            register(headerFooterViewType,
                     forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
        }
    }
    
    /// Делает dequeueReusableHeaderFooterView(withIdentifier:) и сразу кастит возвращаемую вьюшку в нужный тип.
    /// В качестве идентификатора используется название класса. Для задания своего идентификатора нужно переопределить
    /// static var reuseIdentifier в классе вьюшки.
    final func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError(
                "Не удалось сделать dequeue headerFooterView с типом \(T.self) " +
                    "и reuseIdentifier \(T.reuseIdentifier). " +
                    "Убедитесь, что вы зарегистировали headerFooterView"
            )
        }
        
        return cell
    }
        
    /// Проверяет по IndexPath есть ли в таблице данный row.
    final func hasRow(at indexPath: IndexPath) -> Bool {
        indexPath.section < numberOfSections && indexPath.row < numberOfRows(inSection: indexPath.section)
    }
}


extension UICollectionView {
    func register<T: UICollectionViewCell >(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: "\(T.self)", bundle: bundle)
        
        register(nib, forCellWithReuseIdentifier: "\(T.self)")
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath)
                as? T else { fatalError(" table view cell identifier does not exist") }
        return cell
    }
    
    func registerNib(with type: UITableViewCell.Type) {
        let nibName = String(describing: type.self)
        let nib = UINib(nibName: nibName, bundle: .main)
        register(nib, forCellReuseIdentifier: nibName)
    }
}
