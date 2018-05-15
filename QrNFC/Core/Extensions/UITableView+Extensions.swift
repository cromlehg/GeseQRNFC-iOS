//
//  UITableView+Extensions.swift
//

import Foundation
import UIKit

extension UITableView {
  
  // Use one of these methods to register tableView's cell without using a UINib or
  // dequeue cell without using string literals in reuseIdentifiers.
  // Every method uses class's name as an identifier and a nibName.
  //
  // Example usage 1: tableView.registerClass(CustomTableViewCell)
  // Example usege 2: let cell = tableView.dequeueReusableCellForIndexPath(indexPath) as CustomTableViewCell
  // Example usege 3: tableView.registerNibForHeaderFooterView(CustomHeaderFooterView)
  // Example usege 4: let headerFooterView = tableView.dequeueReusableHeaderFooterView(CustomHeaderFooterView)
  
  public func registerNib<T: UITableViewCell>(_: T.Type, bundle: Bundle? = nil) {
    let nib = UINib(nibName: String(describing: T.self), bundle: bundle)
    self.register(nib, forCellReuseIdentifier: String(describing: T.self))
  }
  
  public func registerClass<T: UITableViewCell>(_: T.Type) {
    self.register(T.self, forCellReuseIdentifier: String(describing: T.self))
  }
  
  public func dequeueReusableCellForIndexPath<T: UITableViewCell>(_ indexPath: IndexPath) -> T {
    return self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
  }
  
  public func registerNibForHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type, bundle: Bundle? = nil) {
    let nib = UINib(nibName: String(describing: T.self), bundle: bundle)
    self.register(nib, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
  }

  public func registerClassForHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) {
    self.register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
  }

  public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) -> T? {
    return self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as! T?
  }
  
  public func configureForAutolayout(_ estimateHeight: CGFloat = 44) {
    rowHeight = UITableViewAutomaticDimension
    estimatedRowHeight = estimateHeight
    tableFooterView = UIView()
  }
}
