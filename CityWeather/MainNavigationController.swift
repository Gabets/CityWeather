//
//  MainNavigationController.swift
//  CityWeather
//
//  Created by Alex Gabets on 6/18/20.
//  Copyright © 2020 Gabets. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewControllers = [FormVC()]
    }

}
