//
//  WelcomeViewController.swift
//  iOS-Assignments
//
//  Created by h2e on 4/13/26.
//

import UIKit

import SnapKit

class WelcomeViewController: UIViewController {
    
    var email: String?
    var nickname: String?
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "watcha")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 23)
        label.numberOfLines = 2
        return label
    }()
    
    private let mainButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("메인으로", for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUI()
        setLayout()
        setAction()
        configureWelcomeLabel()
    }
    
    private func setUI() {
        [logoImageView, welcomeLabel, mainButton].forEach { view.addSubview($0) }
    }
    
    private func setLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(240)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(319)
            $0.height.equalTo(167)
        }
        
        welcomeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(306)
            $0.centerX.equalToSuperview()
        }
        
        mainButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(709)
            $0.leading.equalToSuperview().inset(22)
            $0.height.equalTo(56)
        }
    }
    
    private func setAction() {
        mainButton.addTarget(self, action: #selector(didTapMainButton), for: .touchUpInside)
    }
    
    private func configureWelcomeLabel() {
        let name = (nickname?.isEmpty == false) ? nickname! : (email ?? "")
        welcomeLabel.text = "\(name)님\n가입을 환영합니다!"
    }
    
    @objc private func didTapMainButton() {
        let tabBarController = TabBarController()
        
        guard let windowScene = view.window?.windowScene,
              let window = windowScene.windows.first else { return }
        
        window.rootViewController = tabBarController
        
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil
        )
    }}
