//
//  FormVC.swift
//  CityWeather
//
//  Created by Alex Gabets on 6/18/20.
//  Copyright © 2020 Gabets. All rights reserved.
//

import UIKit

protocol FormViewProtocol: class {
    func showError()
    func goToNextScreen(_ weather: WeatherData)
    func startAnimating()
    func stopAnimating()
}

class FormVC: UIViewController {

    private let buttonHeight: CGFloat = 50.0
    private var presenter: FormPresenterProtocol!
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .systemBlue
        indicator.style = .large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var textFieldCity: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = " Введите название города"
        textField.returnKeyType = .done
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var labelError: UILabel = {
        let label = UILabel()
        label.text = "Неверное название города!"
        label.textColor = .red
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private lazy var buttonShow: UIButton = {
        let button = UIButton()
        button.setTitle("Показать погоду", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = buttonHeight / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedShow), for: .touchUpInside)
        return button
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = FormPresenter(view: self)
        
        setupViews()
        setupConstraints()
        view.backgroundColor = .white
    }

    //MARK: - Setup
    private func setupViews() {
        self.navigationController?.navigationBar.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
                
        view.addSubview(textFieldCity)
        view.addSubview(labelError)
        view.addSubview(buttonShow)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        
            textFieldCity.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textFieldCity.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constants.padding),
            textFieldCity.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.padding),
            
            labelError.topAnchor.constraint(equalTo: textFieldCity.bottomAnchor, constant: Constants.padding),
            labelError.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonShow.topAnchor.constraint(equalTo: labelError.bottomAnchor, constant: Constants.padding),
            buttonShow.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: Constants.padding),
            buttonShow.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -Constants.padding),
            buttonShow.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    //MARK: - Actions
    @objc func tappedShow(sender: UIButton!) {
        presenter.checkCityName(textFieldCity.text)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//MARK: - Extensions
extension FormVC: FormViewProtocol {
    func showError() {
        labelError.isHidden = false
    }
    
    func goToNextScreen(_ weather: WeatherData) {
        let vc = WeatherVC()
        vc.cityName = textFieldCity.text
        vc.weather = weather
        navigationController?.show(vc, sender: self)
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
}

extension FormVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        labelError.isHidden = true
    }
}

