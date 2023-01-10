//
//  ViewController.swift
//  Weather
//
//  Created by Anatoliy on 10.01.2023.
//

import UIKit

class ViewController: UIViewController {

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "-20"
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Avenir Next", size: 100)
        //label.font = .systemFont(ofSize: 40, weight: .light)
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
    
    @objc func handleAnimate() {
        
        leftAnchor1?.isActive = false
        leftAnchor2?.isActive = true
        
        UIView.animate(withDuration: 1000, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, animations: {
            
            self.view.layoutIfNeeded()
            
            //self.imageView.frame = CGRect(x: 200, y: 0, width: 50, height: 50)
        })
    }
    
    var leftAnchor1: NSLayoutConstraint?
    var leftAnchor2: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //mainLogoImageView.frame = CGRect.zero
       // mainLogoImageView.center = view.center
        
        view.addSubview(backgroundImageView)
        view.addSubview(temperatureLabel)
        
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100).isActive = true
        
        leftAnchor1 = backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -300)
        leftAnchor1?.isActive = true
        
        leftAnchor2 = backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -500)
        leftAnchor2?.isActive = false
        
        //imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        //imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        // Do any additional setup after loading the view.
    
        
        temperatureLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
        temperatureLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
//        temperatureLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = false
//        temperatureLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = false
        temperatureLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }


}

