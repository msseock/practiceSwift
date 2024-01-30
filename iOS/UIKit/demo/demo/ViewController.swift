//
//  ViewController.swift
//  demo
//
//  Created by 석민솔 on 2023/07/11.
//

import UIKit

class ViewController: UIViewController {
    var profileImageView = UIImageView()
    var nameLabel = UILabel()
    var descriptionTextView = UITextView()
    var editProfileButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        profileImageView.image = UIImage(named: "profileImage")
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImageView)
        
        nameLabel.text = "Jamie Gonzalez"
        nameLabel.font = .systemFont(ofSize: 25)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        editProfileButton.setTitle("EDIT MY PROFILE >", for: .normal)
        editProfileButton.setTitleColor(.purple, for: .normal)
        editProfileButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editProfileButton)
        
        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            editProfileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            editProfileButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
    
    @objc func buttonAction() {
        if (editProfileButton.isSelected) {
            editProfileButton.backgroundColor = .purple
        }
        else {
            editProfileButton.backgroundColor = .clear
        }
        
        editProfileButton.isSelected.toggle()
    }
}

