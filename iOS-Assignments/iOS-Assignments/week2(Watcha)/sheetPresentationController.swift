//
//  sheetPresentationController.swift
//  iOS-Assignments
//
//  Created by h2e on 4/13/26.
//

import UIKit
import SnapKit

final class NicknameBottomSheetViewController: UIViewController {
    
    var onNicknameConfirmed: ((String) -> Void)?
    
    private let nicknameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "닉네임을 입력해주세요"
        tf.backgroundColor = .gray600
        tf.layer.cornerRadius = 12
        tf.textColor = .white

        
        return tf
    }()
    
    private let saveButton: UIButton = {
        let b = UIButton()
        b.setTitle("저장하기", for: .normal)
        b.backgroundColor = .systemPink
        b.layer.cornerRadius = 12
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUI()
        setLayout()
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
    }
    
    private func setUI() {
        [nicknameTextField, saveButton].forEach { view.addSubview($0) }
    }
    
    private func setLayout() {
        nicknameTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        saveButton.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(56)
        }
    }
    
    @objc private func didTapSave() {
        let nickname = nicknameTextField.text ?? ""
        onNicknameConfirmed?(nickname)
        dismiss(animated: true)
    }
}
