//
//  WeatherVC.swift
//  CityWeather
//
//  Created by Alex Gabets on 6/18/20.
//  Copyright © 2020 Gabets. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {
    
    var cityName: String!
    var weather: WeatherData!
    
    private lazy var labelTemperature: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelWeatherMainTitle: UILabel = {
        let label = UILabel()
        label.text = "Погода:"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelWeatherMainValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelWeatherDescriptionTitle: UILabel = {
        let label = UILabel()
        label.text = "Описание:"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelWeatherDescriptionValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        setupViews()
        setupConstraints()
        view.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Setup
    private func setupViews() {
        self.title = cityName
        
        view.addSubview(labelTemperature)
        view.addSubview(labelWeatherMainTitle)
        view.addSubview(labelWeatherMainValue)
        view.addSubview(labelWeatherDescriptionTitle)
        view.addSubview(labelWeatherDescriptionValue)
        
        if let temperature = weather.main?.temp {
            labelTemperature.text = "\(getFormattedTemp(temperature - 273.15))\u{00B0} C"
        }
        
        if let weatherMain = weather.weather?[0].main {
            labelWeatherMainValue.text = weatherMain
        }
        
        if let weatherDescription = weather.weather?[0].description {
            labelWeatherDescriptionValue.text = weatherDescription
        }
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            labelTemperature.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelTemperature.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            labelWeatherMainTitle.topAnchor.constraint(equalTo: labelTemperature.bottomAnchor, constant: Constants.padding),
            labelWeatherMainTitle.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constants.padding),
            
            labelWeatherMainValue.topAnchor.constraint(equalTo: labelTemperature.bottomAnchor, constant: Constants.padding),
            labelWeatherMainValue.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.padding),
            
            labelWeatherDescriptionTitle.topAnchor.constraint(equalTo: labelWeatherMainTitle.bottomAnchor, constant: Constants.padding),
            labelWeatherDescriptionTitle.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constants.padding),
            
            labelWeatherDescriptionValue.topAnchor.constraint(equalTo: labelWeatherMainValue.bottomAnchor, constant: Constants.padding),
            labelWeatherDescriptionValue.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.padding)
        ])
    }
    
    //MARK: - Logic
    private func getFormattedTemp(_ value: Double) -> String {
        let nf = NumberFormatter()
        nf.roundingMode = .up
        nf.maximumFractionDigits = 2
        
        return nf.string(for: value) ?? "0.0"
    }
        
}
