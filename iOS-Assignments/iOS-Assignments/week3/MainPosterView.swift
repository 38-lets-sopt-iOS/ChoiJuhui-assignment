//
//  MainPosterView.swift
//  iOS-Assignments
//
//  Created by h2e on 5/1/26.
//

import UIKit

import SnapKit
import Then

class MainPosterView: UIView {
    
    private let posterImages: [UIImage?] = [
        UIImage(named: "poster1"),
        UIImage(named: "poster2"),
        UIImage(named: "poster3"),
        UIImage(named: "poster4"),
        UIImage(named: "poster5")
    ]
    
    private let sideInset: CGFloat = 51
    private let itemSpacing: CGFloat = 12
    
    private lazy var collectionViewLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = itemSpacing
        $0.minimumInteritemSpacing = 0
    }
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout
    ).then {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.decelerationRate = .fast
        $0.contentInset = UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
        $0.dataSource = self
        $0.delegate = self
        $0.register(PosterCell.self, forCellWithReuseIdentifier: PosterCell.identifier)
    }
    
    private let pageControl = UIPageControl().then {
        $0.numberOfPages = 5
        $0.currentPage = 0
        $0.pageIndicatorTintColor = .gray
        $0.currentPageIndicatorTintColor = .white
    }
    
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
        [collectionView, pageControl].forEach { addSubview($0)}
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }
    }
}

extension MainPosterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posterImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PosterCell.identifier,
            for: indexPath
        ) as? PosterCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(image: posterImages[indexPath.item])
        return cell
    }
}

extension MainPosterView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width - (sideInset * 2)
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
}

extension MainPosterView {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let cellWidth = collectionView.bounds.width - (sideInset * 2) + itemSpacing
        let estimatedIndex = (scrollView.contentOffset.x + sideInset) / cellWidth
        
        let index: CGFloat
        if velocity.x > 0 {
            index = ceil(estimatedIndex)
        } else if velocity.x < 0 {
            index = floor(estimatedIndex)
        } else {
            index = round(estimatedIndex)
        }
        
        let clampedIndex = max(0, min(index, CGFloat(posterImages.count - 1)))
        targetContentOffset.pointee = CGPoint(
            x: clampedIndex * cellWidth - sideInset,
            y: 0
        )
        
        pageControl.currentPage = Int(clampedIndex)
    }
}
