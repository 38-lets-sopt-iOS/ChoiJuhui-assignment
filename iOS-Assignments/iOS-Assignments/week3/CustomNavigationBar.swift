//
//  CustomNavigationBar.swift
//  iOS-Assignments
//
//  Created by h2e on 5/1/26.
//

import UIKit

import SnapKit
import Then

class CustomNavigationBar: UIView {
    
    private let titleLabel = UILabel().then {
        $0.text = "구독"
        $0.textColor = .white
        $0.font = .head1
    }
    
    private let videoButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "video"), for: .normal)
        $0.tintColor = .white
    }
    
    private let notificationButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "notification"), for: .normal)
        $0.tintColor = .white
    }
    private let profileButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "profile"), for: .normal)
        $0.tintColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var buttonStackView = UIStackView(
        arrangedSubviews: [videoButton, notificationButton, profileButton]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 44
    }
    
    private func setUI() {
        backgroundColor = .black
        [titleLabel, buttonStackView].forEach { addSubview($0)}
    }
    
    private func setLayout() {
        buttonStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
                }
    }
    
}
