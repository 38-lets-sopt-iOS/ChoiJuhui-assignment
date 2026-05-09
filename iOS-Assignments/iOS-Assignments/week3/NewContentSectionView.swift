//
//  NewContentSectionView.swift
//  iOS-Assignments
//
//  Created by h2e on 5/1/26.
//

import UIKit

import SnapKit
import Then

class NewContentSectionView: UIView {
    
    private var images: [UIImage?] = []
    
    private let titleLabel = UILabel().then {
        $0.text = "방금 막 도착한 신상 컨텐츠"
        $0.textColor = .white
        $0.font = .head3
    }
    
    private let subtitleLabel = UILabel().then {
        $0.text = "예능부터 드라마까지!"
        $0.textColor = .lightGray
        $0.font = .subhead1
    }
    
    private let collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 8
        $0.minimumInteritemSpacing = 0
        $0.sectionInset = UIEdgeInsets(top: 0, left: 27, bottom: 0, right: 27)
    }
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.register(NewContentCell.self, forCellWithReuseIdentifier: NewContentCell.identifier)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        [titleLabel, subtitleLabel, collectionView].forEach { addSubview($0) }
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(27)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.equalTo(titleLabel)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(180)
        }
    }
    
    func configure(images: [UIImage?]) {
        self.images = images
        collectionView.reloadData()
    }
}

extension NewContentSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NewContentCell.identifier,
            for: indexPath
        ) as? NewContentCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(image: images[indexPath.item])
        return cell
    }
}

extension NewContentSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 321, height: 180)
    }
}
