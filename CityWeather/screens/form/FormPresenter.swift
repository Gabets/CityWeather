//
//  FormVCPresenter.swift
//  CityWeather
//
//  Created by Alex Gabets on 6/18/20.
//  Copyright © 2020 Gabets. All rights reserved.
//

import Alamofire
import Foundation

protocol FormPresenterProtocol {
    init(view: FormViewProtocol)
    
    func checkCityName(_ cityName: String?)
}

class FormPresenter: FormPresenterProtocol {
    unowned let view: FormViewProtocol
    
    required init(view: FormViewProtocol) {
        self.view = view
    }
    
    func checkCityName(_ cityName: String?) {
        (cityName?.trimmingCharacters(in: .whitespaces).isEmpty ?? true) ? view.showError() : getData(cityName ?? "")
    }
    
    func getData(_ cityName: String) {
        view.startAnimating()
        let urlString = "https://api.openweathermap.org/data/2.5/weather"
        let parameters: [String : String] = ["q" : cityName,
                                             "appid" : Constants.apiKey]
    
        AF.request(urlString, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: WeatherData.self) { response in
                self.view.stopAnimating()
                debugPrint(response)
                
                switch response.result {
                    case .success(let value):
                        self.view.goToNextScreen(value)
          
                    case .failure:
                        self.view.showError()
                }
        }
    }
}
