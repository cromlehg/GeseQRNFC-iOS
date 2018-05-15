//
//  UICollectionView+Extensions.swift
//

import Foundation
import UIKit

extension UICollectionView {

  // Use one of these methods to register collectionView's cell without using a UINib or
  // dequeue cell without using string literals in reuseIdentifiers.
  // Every method uses class's name as an identifier and a nibName.
  //
  // Example usage 1: collectionView.registerClass(CustomCollectionViewCell)
  // Example usege 2: let cell = collectionView.dequeueReusableCellForIndexPath(indexPath) as CustomCollectionViewCell

  public func registerNib<T: UICollectionViewCell>(_: T.Type, bundle: Bundle? = nil) {
    let nib = UINib(nibName: String(describing: T.self), bundle: bundle)
    self.register(nib, forCellWithReuseIdentifier: String(describing: T.self))
  }

  public func registerClass<T: UICollectionViewCell>(_: T.Type) {
    self.register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
  }

  public func dequeueReusableCellForIndexPath<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
    return self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
  }

  public func registerNibForSupplementaryView<T: UICollectionReusableView>(_: T.Type, elementKind: String, bundle: Bundle? = nil) {
    let nib = UINib(nibName: String(describing: T.self), bundle: bundle)
    self.register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: String(describing: T.self))
  }

  public func registerClassForSupplementaryView<T: UICollectionReusableView>(_: T.Type, elementKind: String) {
    self.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: String(describing: T.self))
  }

  public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(_ elementKind: String, indexPath: IndexPath) -> T {
    return self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
  }
}
