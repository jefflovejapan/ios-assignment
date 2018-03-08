//
//  UITableView+MadoLabs.swift
//  MadoHomework
//
//  Created by Jeffrey Blagdon on 3/7/18.
//  Copyright © 2018 Mado Labs. All rights reserved.
//

import UIKit

extension UITableView {
    func register(cellClass: AnyClass) {
        self.register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }

    func dequeue<A>(for indexPath: IndexPath) -> A {
        return self.dequeueReusableCell(withIdentifier: String(describing: A.self), for: indexPath) as! A
    }

    func registerHeaderFooter(headerFooterClass: AnyClass) {
        self.register(headerFooterClass, forHeaderFooterViewReuseIdentifier: String(describing: headerFooterClass))
    }

    func dequeueHeaderFooter<A>() -> A {
        return self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: A.self)) as! A
    }
}
