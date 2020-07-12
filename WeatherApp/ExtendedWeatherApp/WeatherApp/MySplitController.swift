//
//  MySplitController.swift
//  ExtendedWeatherApp
//
//  Created by Student on 12/07/2020.
//  Copyright © 2020 Zuzanna Smiech. All rights reserved.
//

import Foundation
import UIKit

class MySplitController: UISplitViewController,UISplitViewControllerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = .allVisible

    }
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool{
        return true
    }
    
}
