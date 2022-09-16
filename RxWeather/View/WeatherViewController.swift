//
//  WeatherViewController.swift
//  RxWeather
//
//  Created by Дина Турман on 03.09.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class WeatherViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel: WeatherViewModel
    
    let searchTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Search City"
        
        return textfield
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.text = "City"
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.text = "Temp"
        return label
    }()
    
    let iconLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 100)
        label.text = "N"
        return label
    }()
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.text = "Weather"
        return label
    }()
    
    let maxMinTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.text = "Max & Min"
        return label
    }()
    
    init(viewModelFactory: WeatherViewModelFactory) {
        self.viewModel = viewModelFactory.makeWeatherViewModelFactory()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 
        setUp()
        layout()
        
        
        searchTextField.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)

        
        viewModel.cityName
            .bind(to: cityLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.temperature
            .bind(to: temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.iconWeather
            .bind(to: iconLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.weatherDescription
            .bind(to: weatherLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.maxMinTemperature
            .bind(to: maxMinTemperatureLabel.rx.text)
            .disposed(by: disposeBag)
        }
   
    private func layout() {
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 16),
            cityLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 40),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            temperatureLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 40),
            view.trailingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 16),
            iconLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 16),
            iconLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 32),
            weatherLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            maxMinTemperatureLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 16),
            maxMinTemperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setUp() {
        view.addSubview(searchTextField)
        view.addSubview(cityLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(iconLabel)
        view.addSubview(weatherLabel)
        view.addSubview(maxMinTemperatureLabel)
    }
}

protocol WeatherViewModelFactory {
    func makeWeatherViewModelFactory() -> WeatherViewModel
}
