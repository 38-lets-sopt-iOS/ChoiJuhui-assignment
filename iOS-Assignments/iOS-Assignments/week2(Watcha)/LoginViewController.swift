//
//  LoginViewController.swift
//  iOS-Assignments
//
//  Created by h2e on 4/13/26.
//

import UIKit

import SnapKit

class LoginViewController: UIViewController {
    
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.text = "로그인/가입하려는\n이메일을 입력해주세요"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Pretendard-SemiBold", size: 23)
        label.numberOfLines = 2
        return label
    }()
    
    private let textlabel1: UILabel = {
        let label = UILabel()
        label.text = "결제 등 중요 정보 알림, 로그인, 비밀번호 찾기에 필요해요."
        label.textColor = .gray50
        label.font = UIFont(name: "Pretendard-Medium", size: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let textlabel2: UILabel = {
        let label = UILabel()
        label.text = "사용 중인 이메일을 입력해주세요"
        label.textColor = .gray50
        label.font = UIFont(name: "Pretendard-Medium", size: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email@address.com"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .gray600
        textField.layer.cornerRadius = 16
        textField.font = UIFont(name: "Pretendard-Regular", size: 12)
        textField.textColor = .white
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray400
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        button.setTitleColor(.gray200, for: .normal)
        button.layer.cornerRadius = 10
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUI()
        setLayout()
        setAction()
        updateLoginButton()
    }
    
    private func setUI() {
        [titlelabel, textlabel1, textlabel2, emailTextField, loginButton].forEach { view.addSubview($0) }
    }
    
    private func setLayout() {
        titlelabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(152)
            $0.leading.equalToSuperview().inset(30)
        }
        
        textlabel1.snp.makeConstraints {
            $0.top.equalToSuperview().inset(219)
            $0.leading.equalToSuperview().inset(30)
        }
        
        textlabel2.snp.makeConstraints {
            $0.top.equalToSuperview().inset(238)
            $0.leading.equalToSuperview().inset(30)
        }
        
        emailTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(279)
            $0.leading.equalToSuperview().inset(31)
            $0.height.equalTo(47)
        }
        
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(709)
            $0.leading.equalToSuperview().inset(22)
            $0.height.equalTo(56)
        }
    }
    
    private func setAction() {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    @objc private func textFieldDidChange() {
        updateLoginButton()
    }
    
    private func updateLoginButton() {
        let hasText = !(emailTextField.text?.isEmpty ?? true)
        loginButton.isEnabled = hasText
        loginButton.backgroundColor = hasText ? .systemPink : .gray400
        loginButton.setTitleColor(hasText ? .white : .gray200, for: .normal)
    }
    
    @objc private func didTapLoginButton() {
        let passwordViewController = PasswordViewController()
        passwordViewController.email = emailTextField.text
        navigationController?.pushViewController(passwordViewController, animated: true)
    }
}
