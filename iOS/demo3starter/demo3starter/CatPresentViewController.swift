//
//  CatPushViewController.swift
//  demo3starter
//
//  Created by Elvis Marcelo on 3/8/23.
//

import UIKit

class CatPresentViewController: UIViewController {

    let catImageView = UIImageView()
    let cat1Button = UIButton()
    let cat2Button = UIButton()
    let cat3Button = UIButton()
    var cat: Cat?
    weak var delegate: ChangeImageDelegate?

    //TODO: #5 - delegates

    //TODO: #6 - init
    init(cat: Cat, delegate: ChangeImageDelegate) {
        self.cat = cat
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        catImageView.image = UIImage(named: cat.image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        catImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(catImageView)

        //TODO: #2.5 - add tags to buttons & target
        cat1Button.setImage(UIImage(named: "cat1"), for: .normal)
        cat1Button.addTarget(self, action: #selector(catButton), for: .touchUpInside)
        cat1Button.tag = 0
        cat1Button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cat1Button)

        cat2Button.setImage(UIImage(named: "cat2"), for: .normal)
        cat2Button.addTarget(self, action: #selector(catButton), for: .touchUpInside)
        cat2Button.tag = 1
        cat2Button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cat2Button)

        cat3Button.setImage(UIImage(named: "cat3"), for: .normal)
        cat3Button.addTarget(self, action: #selector(catButton), for: .touchUpInside)
        cat3Button.tag = 2
        cat3Button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cat3Button)

        setupConstraints()
    }
    

    func setupConstraints() {
        let padding: CGFloat = 15
        let topPadding: CGFloat = 50
        let ratio: CGFloat = 0.45

        NSLayoutConstraint.activate([
            catImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            catImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            catImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            catImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            cat1Button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: ratio),
            cat1Button.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: ratio),
            cat1Button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cat1Button.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: topPadding)
        ])

        NSLayoutConstraint.activate([
            cat2Button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: ratio),
            cat2Button.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: ratio),
            cat2Button.topAnchor.constraint(equalTo: cat1Button.bottomAnchor, constant: padding),
            cat2Button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding)
        ])

        NSLayoutConstraint.activate([
            cat3Button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: ratio),
            cat3Button.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: ratio),
            cat3Button.topAnchor.constraint(equalTo: cat2Button.topAnchor),
            cat3Button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }

//TODO: #2 - Change catImageView to respective cat
    
    @objc func catButton(sender: UIButton) {
        if (sender.tag == 0) {
            catImageView.image = UIImage(named: "cat1")
            delegate?.changeImage(image: "cat1")
            cat?.image = "cat1"
        }
        if (sender.tag == 1) {
            catImageView.image = UIImage(named: "cat2")
            delegate?.changeImage(image: "cat2")
            cat?.image = "cat2"
        }
        if (sender.tag == 2) {
            catImageView.image = UIImage(named: "cat3")
            delegate?.changeImage(image: "cat3")
            cat?.image = "cat3"
        }
    }
//TODO: #7 - Delegate Cat

}


//TODO: #3 - Create Protocol
protocol ChangeImageDelegate: ViewController {
    func changeImage(image: String)
}
