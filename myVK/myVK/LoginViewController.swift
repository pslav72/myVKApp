//
//  ViewController.swift
//  myVK
//
//  Created by Вячеслав Поляков on 11.02.2021.
//

import UIKit

class LoginViewController: UIViewController {
    

    @IBOutlet var lognTextFiled: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var progressLoadView1: UIView!
    @IBOutlet var progressLoadView2: UIView!
    @IBOutlet var progressLoadView3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView.addGestureRecognizer(hideKeyboardGesture)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let animateDuration: TimeInterval = 1
        
        progressLoadView1.backgroundColor = .systemBlue
        progressLoadAnimatedButtom(viewAnimated: progressLoadView1, colorBackground: .systemRed, withAnimtedDuration: animateDuration, delayAnimated: 0)
        progressLoadView2.backgroundColor = .systemGreen
        progressLoadAnimatedButtom(viewAnimated: progressLoadView2, colorBackground: .systemIndigo, withAnimtedDuration: animateDuration, delayAnimated: 0.3)
        progressLoadView3.backgroundColor = .systemRed
        progressLoadAnimatedButtom(viewAnimated: progressLoadView3, colorBackground: .systemYellow, withAnimtedDuration: animateDuration, delayAnimated: 0.7)
    }
    
    func progressLoadAnimatedButtom (viewAnimated view: UIView, colorBackground color: UIColor, withAnimtedDuration withDuration: TimeInterval, delayAnimated delay: TimeInterval) {
        UIView.animate(withDuration: withDuration, delay: delay, options: [.repeat]) {
            [self] in
            view.backgroundColor = color
            view.bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
//            view.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
            view.alpha = 0.1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

// Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
    }

    @objc func hideKeyboard() {
        scrollView.endEditing(true)
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        // Получаем текст логина
        let login = lognTextFiled.text!
        // Получаем текст-пароль
        let password = passwordTextField.text!
        
        // Проверяем, верны ли они
        if login == "" && password == "" {
            print("успешная авторизация")
            performSegue(withIdentifier: "MainTabBarSegue", sender: self)
        } else {
            print("неуспешная авторизация")
            showLoginError()
        }
    }
    
    func showLoginError() {
        // Создаем контроллер
        let alter = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // Добавляем кнопку на UIAlertController
        alter.addAction(action)
        // Показываем UIAlertController
        present(alter, animated: true, completion: nil)
    }

    
}

