//
//  ViewController.swift
//  Weather
//
//  Created by Anatoliy on 10.01.2023.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
   
    var dayOrNight: String = "_day"
    var firstConstraintsPosition: Bool = true
    var backgroundImage = ""
    
    var backgroundLeftAnchor1: NSLayoutConstraint?
    var backgroundLeftAnchor2: NSLayoutConstraint?
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()

    private lazy var navButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(
            pointSize: 34, weight: .medium, scale: .default)
        let image = UIImage(systemName: "location.circle.fill", withConfiguration: config)?.withTintColor(.white, renderingMode:.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(navButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    } ()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(
            pointSize: 35, weight: .medium, scale: .default)
        let image = UIImage(systemName: "magnifyingglass.circle.fill", withConfiguration: config)?.withTintColor(.white, renderingMode:.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    } ()
    
    private lazy var cityInputTextField: UITextField = {
        let textField = UITextField()
        //textField.placeholder = "Enter city"
        textField.enablesReturnKeyAutomatically = true
        textField.textColor = .white
        textField.layer.cornerRadius = 8
        textField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        textField.font = .systemFont(ofSize: 26, weight: .regular)
        textField.keyboardType = .default //тип клавиатуры
        textField.keyboardAppearance = .dark
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.isHidden = true
        textField.textAlignment = .center
        return textField
    }()
    
    private lazy var gearButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(
            pointSize: 32, weight: .medium, scale: .default)
        let image = UIImage(systemName: "gear", withConfiguration: config)?.withTintColor(.white, renderingMode:.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(gearButtonTapped), for: .touchUpInside)
        return button
    } ()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 37, weight: .regular)
        label.shadowColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 100, weight: .thin)
        label.shadowColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherConditionsLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 27, weight: .regular)
        label.shadowColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.shadowColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: backgroundImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAnimate)))
        return imageView
    } ()
    
    private lazy var dayNightSegmentedControl: UISegmentedControl = {
        let items = ["Day", "Night"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentedControl.layer.borderWidth = 1
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(dayNightSegmentedControlDidChange(_:)), for:.valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.isHidden = true
        return segmentedControl
    }()
    
    private lazy var weatherConditionsSegmentedControl: UISegmentedControl = {
        let items = ["Clear", "Clouds", "Shower", "Rain", "Thunderstorm", "Snow", "Mist"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentedControl.layer.borderWidth = 1
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(weatherConditionsSegmentedControlDidChange(_:)), for:.valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.isHidden = true
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
       
        weatherManager.delegate = self
        cityInputTextField.delegate = self
        
        addToSubview()
        setSubviewsLayouts()
        
        hideKeyboardWhenTappedAround() //клава убирается после тапа везде
        }
    
    override func viewDidAppear(_ animated: Bool) {
        weatherManager.fetchWeather(cityName: "Moscow")
        handleAnimate()
    }

    private func addToSubview() {
        view.addSubview(backgroundImageView)
        view.addSubview(temperatureLabel)
        view.addSubview(cityLabel)
        view.addSubview(weatherConditionsLabel)
        view.addSubview(weatherConditionsSegmentedControl)
        view.addSubview(dayNightSegmentedControl)
        view.addSubview(navButton)
        view.addSubview(searchButton)
        view.addSubview(gearButton)
        view.addSubview(cityInputTextField)
        view.addSubview(feelsLikeLabel)
        view.addSubview(spinner)
    }
    
    @objc func searchButtonTapped(){
        cityInputTextField.isHidden.toggle()
        cityInputTextField.endEditing(true) //скрывает клавиатуру
//        if let city = cityInputTextField.text {
//            if cityInputTextField.text != "" {
//                cityInputTextField.isHidden = true
//                handleAnimate()
//                weatherManager.fetchWeather(cityName: city)
//                cityInputTextField.text = ""
//                print ("вот")}
       // }
    }
    
    @objc func navButtonTapped(){
        spinner.startAnimating()
        locationManager.requestLocation()
        handleAnimate()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityInputTextField.endEditing(true) //скрывает клавиатуру
        return true
    }
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if cityInputTextField.text != "" {
//            return true
//        } else {
//            cityInputTextField.placeholder = "Type something"
//            return false
//        }
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = cityInputTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        cityInputTextField.isHidden = true
        cityInputTextField.text = ""
    }
   
    @objc func gearButtonTapped () {
        weatherConditionsSegmentedControl.isHidden = false
        dayNightSegmentedControl.isHidden = false
        gearButton.isHidden = true
    }
    
    @objc func handleAnimate() {
        UIView.animate(withDuration: 20) { //40
            self.backgroundLeftAnchor2?.isActive.toggle()
            self.backgroundLeftAnchor1?.isActive.toggle()
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func dayNightSegmentedControlDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            dayOrNight = "_day"
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 1:
            dayOrNight = "_night"
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        default:
            return
        }
    }
    
    @objc func weatherConditionsSegmentedControlDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            backgroundImage = "clear_sky\(dayOrNight)"
            backgroundImageView.image = UIImage(named: backgroundImage)
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 1:
            backgroundImageView.image = UIImage(named: "few_clouds\(dayOrNight)")
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 2:
            backgroundImageView.image = UIImage(named: "shower_rain\(dayOrNight)")
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 3:
            backgroundImageView.image = UIImage(named: "rain\(dayOrNight)")
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 4:
            backgroundImageView.image = UIImage(named: "thunderstorm\(dayOrNight)")
            //handleAnimate()
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 5:
            backgroundImageView.image = UIImage(named: "snow\(dayOrNight)")
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 6:
            backgroundImageView.image = UIImage(named: "mist\(dayOrNight)")
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        default:
            return
        }
    }
    
    func didUpdateWeather (_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.weatherConditionsLabel.text = weather.description
            self.feelsLikeLabel.text = "feels like: \(weather.feelsLikeString)"
            self.backgroundImageView.image = UIImage(named: weather.conditionName)
            self.spinner.stopAnimating()
            print(weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print ("ЕRRОR: \(error)")
    }
    
    private func setSubviewsLayouts() {
        
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        backgroundLeftAnchor1 = backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -500)
        backgroundLeftAnchor1?.isActive = false
        backgroundLeftAnchor2 = backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 000)
        backgroundLeftAnchor2?.isActive = true

        cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        cityLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 0).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        weatherConditionsLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 0).isActive = true
        weatherConditionsLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        feelsLikeLabel.topAnchor.constraint(equalTo: weatherConditionsLabel.bottomAnchor, constant: 10).isActive = true
        feelsLikeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        dayNightSegmentedControl.bottomAnchor.constraint(equalTo: weatherConditionsSegmentedControl.topAnchor, constant: -20).isActive = true
        dayNightSegmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        dayNightSegmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        weatherConditionsSegmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        weatherConditionsSegmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        weatherConditionsSegmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        cityInputTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21).isActive = true
        cityInputTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 70).isActive = true
        cityInputTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70).isActive = true
        cityInputTextField.heightAnchor.constraint(equalToConstant: 37).isActive = true
        
        navButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        navButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        
        spinner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        spinner.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        
        searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        
        gearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        gearButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print ("ERROR2: \(error)")
    }
}

//клава убирается после тапа везде
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
