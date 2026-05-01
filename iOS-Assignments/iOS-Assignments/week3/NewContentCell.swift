//
//  NewContentCell.swift
//  iOS-Assignments
//
//  Created by h2e on 5/1/26.
//

import UIKit

import SnapKit
import Then

class NewContentCell: UICollectionViewCell {
    
    static let identifier = "NewContentCell"
    
    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        contentView.addSubview(posterImageView)
    }
    
    private func setLayout() {
        posterImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(image: UIImage?) {
        posterImageView.image = image
    }
}
