//
//  ViewController.swift
//  UICodePractice
//
//  Created by 석민솔 on 2023/07/14.
//

import UIKit

class ViewController: UIViewController {
    var bookImageView   = UIImageView()
    var appNameLabel    = UILabel()
    var questionLabel   = UILabel()
    var dateTextField   = UITextField()
    var nameTextField   = UITextField()
    var addBookButton   = UIButton()
    var listLabel       = UILabel()
    var listTextView    = UITextView()
    
    var bookList: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // bookImageView
        bookImageView.image = UIImage(named: "bookStack")
        bookImageView.contentMode = .scaleAspectFit
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bookImageView)
        
        // appNameLabel
        appNameLabel.text = "MY BOOK STACK"
        appNameLabel.font = .systemFont(ofSize: 25, weight: .medium)
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(appNameLabel)
        
        // questionLabel
        questionLabel.text = "What book did you read?"
        questionLabel.font = .systemFont(ofSize: 20)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionLabel)

        // dateTextField
        dateTextField.placeholder = "date (ex. 00/00)"
        dateTextField.keyboardType = .numbersAndPunctuation
        dateTextField.borderStyle = .roundedRect
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateTextField)
        
        // nameTextField
        nameTextField.placeholder = "book name"
        nameTextField.borderStyle = .roundedRect
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameTextField)
        
        // addBookButton
        addBookButton.setTitle("ADD >", for: .normal)
        addBookButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        addBookButton.setTitleColor(.systemBlue, for: .normal)
        addBookButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addBookButton)
        
        // listLabel
        listLabel.text = "A List of books you read"
        listLabel.font = .systemFont(ofSize: 20)
        listLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listLabel)
        
        // listTextView
        listTextView.text = "Add books..."
        listTextView.font = .systemFont(ofSize: 17)
        listTextView.textColor = .placeholderText
        listTextView.isEditable = false
        listTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(listTextView)
        
        setupConstraints()
        
        // 키보드 없애기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

    }
    
    func setupConstraints() {
        
        // bookImageView
        NSLayoutConstraint.activate([
            bookImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            bookImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            bookImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            bookImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15)
        ])
        
        // appNameLabel
        NSLayoutConstraint.activate([
            appNameLabel.centerXAnchor.constraint(equalTo: bookImageView.centerXAnchor),
            appNameLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 10)
        ])
        
        // questionLabel
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 30),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
        
        // dateTextField
        NSLayoutConstraint.activate([
            dateTextField.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 10),
            dateTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            dateTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
        ])

        
        // nameTextField
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 15),
            nameTextField.leadingAnchor.constraint(equalTo: dateTextField.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        // addBookButton
        NSLayoutConstraint.activate([
            addBookButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            addBookButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        // listLabel
        NSLayoutConstraint.activate([
            listLabel.topAnchor.constraint(equalTo: addBookButton.bottomAnchor, constant: 40),
            listLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
        
        // listTextView
        NSLayoutConstraint.activate([
            listTextView.topAnchor.constraint(equalTo: listLabel.bottomAnchor, constant: 10),
            listTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            listTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            listTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func addButtonAction() {
        
        let date: String = self.dateTextField.text!
        let bookName: String = self.nameTextField.text!
        
        // textField 글자들 리셋
        self.dateTextField.text!.removeAll()
        self.nameTextField.text!.removeAll()
        
        // 키보드를 닫는다
        dismissKeyboard()
        
        
        // textField가 채워져있는지 체크
        if !date.isEmpty, !bookName.isEmpty {
            listTextView.textColor = .label
            bookList += "- \(date)\t \(bookName)\n"
            listTextView.text = bookList
        }
        // 하나라도 값이 입력되지 않았을 때 알람이 발생
        else {
            let alertController = UIAlertController(title: "ERROR", message: "fill in the blanks", preferredStyle: .alert)
            
            // ok를 누르면 알람이 꺼진다
            let okAction = UIAlertAction(title: "OK", style: .default) {_ in
                alertController.dismiss(animated: true)
            }
            
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    // 키보드를 닫는다.
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
