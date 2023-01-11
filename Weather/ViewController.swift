//
//  ViewController.swift
//  Weather
//
//  Created by Anatoliy on 10.01.2023.
//

import UIKit

class ViewController: UIViewController {
    //var rightAnchor1: NSLayoutConstraint?
   // var rightAnchor2: NSLayoutConstraint?
    //var leftAnchor1: NSLayoutConstraint?
    //var leftAnchor2: NSLayoutConstraint?
    var dayOrNight: String = ""
    var firstConstraintsPosition: Bool = true
    
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
        imageView.image = UIImage(named: "clear_sky_night")
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
        //segmentedControl.selectedSegmentTintColor = .black
        //segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 0.5654026866, green: 0.4771631956, blue: 0.8172003031, alpha: 1)
        //segmentedControl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(dayNightSegmentedControlDidChange(_:)), for:.valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private lazy var weatherConditionsSegmentedControl: UISegmentedControl = {
        let items = ["Clear", "Clouds", "Shower", "Rain", "Thunderstorm", "Snow", "Mist"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentedControl.layer.borderWidth = 1
        //segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 0.5654026866, green: 0.4771631956, blue: 0.8172003031, alpha: 1)
        //segmentedControl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(weatherConditionsSegmentedControlDidChange(_:)), for:.valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
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
    
    @objc func handleAnimate() {
        
        //rightAnchor1?.isActive.toggle()
        //leftAnchor1?.isActive.toggle()
        //rightAnchor2?.isActive.toggle()
        //leftAnchor2?.isActive.toggle()

        //rightAnchor2?.isActive = true
        //leftAnchor2?.isActive = true
        
        //rightAnchor1?.isActive = false
        //leftAnchor1?.isActive = false
        
      //  firstConstraintsPosition.toggle()
//
//        backgroundImageView.frame = CGRect(x: -400, y: 0, width: 1920, height: 1080)
        
        
//
           UIView.animate(withDuration: 1) {
               self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -500).isActive = true
               
               self.view.layoutIfNeeded()
            }
        
//        UIView.animate(withDuration: 10, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, animations: {
//            self.view.layoutIfNeeded()
//        })
        
        //backgroundImageView.centerYConstraint.constant = 500.0
        
        //self.view.layoutIfNeeded()

//        UIView.animate(withDuration: Double(0.5), animations: {
//           // self.backgroundImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 500).isActive = true
//
//
//            self.backgroundImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
//
//                self.view.layoutIfNeeded()
//            })
//
    }
    
    @objc func dayNightSegmentedControlDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            dayOrNight = "_day"
            //handleAnimate()
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 1:
            dayOrNight = "_night"
            //handleAnimate()
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        default:
            return
            
        }
    }
    
    @objc func weatherConditionsSegmentedControlDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            backgroundImageView.image = UIImage(named: //"clear_sky\(dayOrNight)")
            "c")
            //handleAnimate()
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 1:
            backgroundImageView.image = UIImage(named: "clouds\(dayOrNight)")
            //handleAnimate()
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 2:
            backgroundImageView.image = UIImage(named: "shower_rain\(dayOrNight)")
            //handleAnimate()
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 3:
            backgroundImageView.image = UIImage(named: "rain\(dayOrNight)")
            //handleAnimate()
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 4:
            backgroundImageView.image = UIImage(named: "thunderstorm\(dayOrNight)")
            //handleAnimate()
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 5:
            backgroundImageView.image = UIImage(named: "snow\(dayOrNight)")
            //handleAnimate()
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case 6:
            backgroundImageView.image = UIImage(named: "mist\(dayOrNight)")
            //handleAnimate()
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        default:
            return
            
        }
    }
    
    private func setSubviewsLayouts() {
        
        backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        //backgroundImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 000).isActive = true
        
        
        //backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//
        
        //backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//
        //backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //backgroundImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        //leftAnchor1?.isActive = true
        //leftAnchor1
        
//        if firstConstraintsPosition {
//
//            backgroundImageView.frame = CGRect(x: -200, y: 0, width: 1920, height: 1080)
////            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -400).isActive = true
//
//        } else {
////
//            backgroundImageView.frame = CGRect(x: -500, y: 0, width: 1920, height: 1080)
//            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -400).isActive = true
      //  }
//
       // rightAnchor1?.isActive = true
        //rightAnchor1 = backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0) //350
        
//        leftAnchor2?.isActive = false
//        leftAnchor2 = backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0) //-500

        //rightAnchor2?.isActive = false
        //rightAnchor2 = backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 650) // 250
        
//        backgroundImageView.frame = CGRect(x: -200, y: 0, width: 1920, height: 1080)
        
        cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        cityLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        //cityLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 0).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        weatherConditionsLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 0).isActive = true
        weatherConditionsLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        dayNightSegmentedControl.bottomAnchor.constraint(equalTo: weatherConditionsSegmentedControl.topAnchor, constant: -20).isActive = true
        dayNightSegmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        dayNightSegmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        weatherConditionsSegmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        weatherConditionsSegmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        weatherConditionsSegmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
    }
}

