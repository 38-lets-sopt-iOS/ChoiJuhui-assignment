//
//  HorizontalSectionView.swift
//  iOS-Assignments
//
//  Created by h2e on 5/1/26.
//

import UIKit

import SnapKit
import Then

class HorizontalSectionView: UIView {
    
    private var images: [UIImage?] = []
    
    private let titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .subhead1
    }
    
    private let titleImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    private let subtitleLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .subhead1
        $0.isHidden = true
    }
    
    private let moreButton = UIButton(type: .system).then {
        $0.setTitle("더보기", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = .cap1
    }
    
    private let collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 8
        $0.minimumInteritemSpacing = 0
        $0.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.dataSource = self
        cv.delegate = self
        cv.register(SmallPosterCell.self, forCellWithReuseIdentifier: SmallPosterCell.identifier)
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
        [titleLabel, titleImageView, subtitleLabel, moreButton, collectionView].forEach { addSubview($0) }
    }
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
        
        titleImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(40)
            $0.width.lessThanOrEqualTo(200)
        }
        
        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(160)
        }
    }
    
    func configure(title: String, images: [UIImage?], showMoreButton: Bool = true) {
        titleLabel.text = title
        titleLabel.isHidden = false
        titleImageView.isHidden = true
        subtitleLabel.isHidden = true
        self.images = images
        moreButton.isHidden = !showMoreButton
        collectionView.reloadData()
    }
    
    func configure(titleImage: UIImage?, subtitle: String, images: [UIImage?], showMoreButton: Bool = true) {
        titleImageView.image = titleImage
        titleImageView.isHidden = false
        titleLabel.isHidden = true
        subtitleLabel.text = subtitle
        subtitleLabel.isHidden = false
        self.images = images
        moreButton.isHidden = !showMoreButton
        collectionView.reloadData()
    }
}

extension HorizontalSectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SmallPosterCell.identifier,
            for: indexPath
        ) as? SmallPosterCell else {
            return UICollectionViewCell()
        }
        
        if let image = images[indexPath.item] {
            cell.configure(image: image)
        } else { return cell }
        
        return cell
    }
}

extension HorizontalSectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 110, height: 160)
    }
}
