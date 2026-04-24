//
//  PasswordViewController.swift
//  iOS-Assignments
//
//  Created by h2e on 4/13/26.
//

import UIKit
import SnapKit

class PasswordViewController: UIViewController {
    
    var email: String?
    private var nickname: String?
    
    private let titlelabel: UILabel = {
        let label = UILabel()
        label.text = "사용할 비밀번호를\n입력해주세요"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "Pretendard-SemiBold", size: 23)
        label.numberOfLines = 2
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .grayplus
        label.font = UIFont(name: "Pretendard-Medium", size: 12)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호 입력"
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .gray600
        textField.layer.cornerRadius = 16
        textField.font = UIFont(name: "Pretendard-Regular", size: 12)
        textField.textColor = .white
        return textField
    }()
    
    private let eyeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "eye-off"), for: .normal)
        button.tintColor = .gray300
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        return button
    }()
    
    private let validationLabel: UILabel = {
        let label = UILabel()
        label.text = "영문, 숫자, 특수문자 포함 10글자 이상"
        label.textColor = .gray100
        label.font = UIFont(name: "Pretendard-Regular", size: 12)
        return label
    }()
    
    private let nicknameButton: UIButton = {
        let button = UIButton()
        let title = NSAttributedString(
            string: "닉네임 설정",
            attributes: [
                .foregroundColor: UIColor.gray100,
                .font: UIFont(name: "Pretendard-Regular", size: 12) ?? .systemFont(ofSize: 12),
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        button.setAttributedTitle(title, for: .normal)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray300
        button.setTitle("가입하기", for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        button.setTitleColor(.gray200, for: .normal)
        button.layer.cornerRadius = 16
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUI()
        setLayout()
        setAction()
        configureEmail()
        updateSignUpButton()
    }
    
    private func setUI() {
        [titlelabel, emailLabel, passwordTextField, validationLabel, nicknameButton, signUpButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setLayout() {
        titlelabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(152)
            $0.leading.equalToSuperview().offset(30)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(219)
            $0.leading.equalToSuperview().offset(30)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(277)
            $0.leading.equalToSuperview().offset(31)
            $0.height.equalTo(47)
        }
        
        validationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(337)
            $0.leading.equalTo(passwordTextField).offset(4)
        }
        
        nicknameButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(391)
            $0.centerX.equalToSuperview()
        }
        
        signUpButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(709)
            $0.leading.equalToSuperview().offset(22)
            $0.height.equalTo(56)
        }
    }
    
    private func setAction() {
        let rightContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        rightContainer.addSubview(eyeButton)
        passwordTextField.rightView = rightContainer
        passwordTextField.rightViewMode = .always
        
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        nicknameButton.addTarget(self, action: #selector(didTapNicknameButton), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
    }
    
    private func configureEmail() {
        emailLabel.text = "\(email ?? "")로 가입중"
    }
    
    @objc private func textFieldDidChange() {
        updateSignUpButton()
    }
    
    private func updateSignUpButton() {
        let hasText = !(passwordTextField.text?.isEmpty ?? true)
        signUpButton.isEnabled = hasText
        signUpButton.backgroundColor = hasText ? .systemPink : .gray400
        signUpButton.setTitleColor(hasText ? .white : .gray200, for: .normal)
    }
    
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye-off" : "eye-on"
        eyeButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    @objc private func didTapNicknameButton() {
        let sheetVC = NicknameBottomSheetViewController()
        sheetVC.onNicknameConfirmed = { [weak self] nickname in
            self?.nickname = nickname
            self?.updateNicknameButton(nickname: nickname)
        }
        sheetVC.modalPresentationStyle = .pageSheet
        if let sheet = sheetVC.sheetPresentationController {
            sheet.detents = [.custom { context in
                return context.maximumDetentValue * 0.5
            }]
            sheet.prefersGrabberVisible = true
        }
        present(sheetVC, animated: true)
    }
    
    private func updateNicknameButton(nickname: String) {
        let title = NSAttributedString(
            string: nickname,
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont(name: "Pretendard-Medium", size: 12) ?? .systemFont(ofSize: 12)
            ]
        )
        nicknameButton.setAttributedTitle(title, for: .normal)
    }
    
    @objc private func didTapSignUpButton() {
        let welcomeVC = WelcomeViewController()
        welcomeVC.email = email
        welcomeVC.nickname = nickname
        navigationController?.pushViewController(welcomeVC, animated: true)
    }
}
