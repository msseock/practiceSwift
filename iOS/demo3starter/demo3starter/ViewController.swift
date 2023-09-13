//
//  ViewController.swift
//  demo3starter
//
//  Created by Elvis Marcelo on 3/8/23.
//

import UIKit

class ViewController: UIViewController {
    let catImageButton = UIButton()
    let catLabel = UILabel()
    var cat: Cat = Cat(name: "Kimba", image: "cat3")
    let changeNameButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Cat"
        view.backgroundColor = .white

        catImageButton.setImage(UIImage(named: cat.image), for: .normal)
        catImageButton.translatesAutoresizingMaskIntoConstraints = false
        catImageButton.addTarget(self, action: #selector(presentView), for: .touchUpInside)
        view.addSubview(catImageButton)

        catLabel.text = cat.name
        catLabel.translatesAutoresizingMaskIntoConstraints = false
        catLabel.font = .systemFont(ofSize: 30)
        view.addSubview(catLabel)

        changeNameButton.setTitle("Edit Cat", for: .normal)
        changeNameButton.backgroundColor = .systemBlue
        changeNameButton.layer.cornerRadius = 5
        changeNameButton.translatesAutoresizingMaskIntoConstraints = false
        changeNameButton.addTarget(self, action: #selector(pushView), for: .touchUpInside)
        view.addSubview(changeNameButton)

        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            catImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            catImageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            catImageButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            catImageButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])

        NSLayoutConstraint.activate([
            catLabel.topAnchor.constraint(equalTo: catImageButton.bottomAnchor, constant: 15),
            catLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            changeNameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeNameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            changeNameButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }

    //TODO: 1 - Present View
    @objc func presentView() {
        present(CatPresentViewController(cat: cat, delegate: self), animated: true)
    }

    //TODO: 7 - Push View
    @objc func pushView() {
        print("I'm supposed to push")
    }
}

//TODO: #4 - Create Extension
extension ViewController: ChangeImageDelegate {
    func changeImage(image: String) {
        catImageButton.setImage(UIImage(named: image), for: .normal)
    }
}
