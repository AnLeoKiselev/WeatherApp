//
//  ViewController.swift
//  Weather
//
//  Created by Anatoliy on 10.01.2023.
//

import UIKit

class ViewController: UIViewController {

    var leftAnchor1: NSLayoutConstraint?
    var leftAnchor2: NSLayoutConstraint?
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Moscow"
        label.textColor = .white
        label.font = .systemFont(ofSize: 40, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "-22\u{00B0}"
        label.textColor = .white
        //label.font = UIFont(name: "Avenir Next", size: 100)
        //label.font = UIFont.systemFont(ofSize: 108
        label.font = .systemFont(ofSize: 100, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherConditionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunny"
        label.textColor = .white
        //label.font = UIFont(name: "Avenir Next", size: 100)
        //label.font = UIFont.systemFont(ofSize: 108
        label.font = .systemFont(ofSize: 30, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = UIImage(named: "clouds")
        imageView.image = UIImage(named: "sun")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAnimate)))
        return imageView
    } ()
    
    private lazy var dayNightSegmentedControl: UISegmentedControl = {
        let items = ["Day", "Night"]
        let segmentedControl = UISegmentedControl(items: items)
        //segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 0.5654026866, green: 0.4771631956, blue: 0.8172003031, alpha: 1)
        //segmentedControl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(dayNightSegmentedControlDidChange(_:)), for:.valueChanged)
        //segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private lazy var weatherConditionsSegmentedControl: UISegmentedControl = {
        let items = ["clear", "clouds", "shower rain", "rain", "thunderstorm", "snow", "mist"]
        let segmentedControl = UISegmentedControl(items: items)
        //segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 0.5654026866, green: 0.4771631956, blue: 0.8172003031, alpha: 1)
        //segmentedControl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(weatherConditionsSegmentedControlDidChange(_:)), for:.valueChanged)
        //segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    @objc func handleAnimate() {
        leftAnchor1?.isActive = false
        leftAnchor2?.isActive = true
        
        UIView.animate(withDuration: 5) {
            self.view.layoutIfNeeded()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addToSubview()
        setSubviewsLayouts()
    }
    
    private func addToSubview() {
        view.addSubview(backgroundImageView)
        view.addSubview(temperatureLabel)
        view.addSubview(cityLabel)
        view.addSubview(weatherConditionsLabel)
        view.addSubview(weatherConditionsSegmentedControl)
        view.addSubview(dayNightSegmentedControl)
    }
    
    @objc func dayNightSegmentedControlDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print ("0")
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 1:
            print ("1")
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        default:
            return
        }
    }
    
    @objc func weatherConditionsSegmentedControlDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print ("0")
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 1:
            print ("1")
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 2:
            print ("2")
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 3:
            print ("0")
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 4:
            print ("1")
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 5:
            print ("2")
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 6:
            print ("2")
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        default:
            return
        }
    }
    
    private func setSubviewsLayouts() {
        
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        leftAnchor1 = backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -200)
        leftAnchor1?.isActive = true
        
        leftAnchor2 = backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -400)
        leftAnchor2?.isActive = false
        
        cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        cityLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        //cityLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 0).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        weatherConditionsLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 0).isActive = true
        weatherConditionsLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        weatherConditionsSegmentedControl.bottomAnchor.constraint(equalTo: dayNightSegmentedControl.topAnchor, constant: -20).isActive = true
        weatherConditionsSegmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        weatherConditionsSegmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        dayNightSegmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        dayNightSegmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        dayNightSegmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
}

