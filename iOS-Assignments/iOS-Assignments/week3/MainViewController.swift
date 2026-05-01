//
//  MainViewController.swift
//  iOS-Assignments
//
//  Created by h2e on 5/1/26.
//

import UIKit

import SnapKit
import Then

class MainViewController: UIViewController {
    
    private let customNavigationBar = CustomNavigationBar()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let mainPosterView = MainPosterView()
    
    private let newContentSection = NewContentSectionView()
    private let watgorithmSection = HorizontalSectionView()
    private let upcomingSection = HorizontalSectionView()
    private let watchaPartySection = HorizontalSectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        scrollView.contentInsetAdjustmentBehavior = .never
        setUI()
        setLayout()
        configureSections()
    }
    
    private func setUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [mainPosterView, newContentSection, watgorithmSection, upcomingSection, watchaPartySection]
            .forEach { contentView.addSubview($0) }
        
        view.addSubview(customNavigationBar)
    }
    
    private func setLayout() {
        customNavigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
        }
        
        mainPosterView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(420)
        }
        
        newContentSection.snp.makeConstraints {
            $0.top.equalTo(mainPosterView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        watgorithmSection.snp.makeConstraints {
            $0.top.equalTo(newContentSection.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
        }
        
        upcomingSection.snp.makeConstraints {
            $0.top.equalTo(watgorithmSection.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
        }
        
        watchaPartySection.snp.makeConstraints {
            $0.top.equalTo(upcomingSection.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func configureSections() {
        let mainPosters: [UIImage?] = [
            UIImage(named: "poster1"),
            UIImage(named: "poster2"),
            UIImage(named: "poster3"),
            UIImage(named: "poster4"),
            UIImage(named: "poster5")
        ]
        
        let newContents: [UIImage?] = [
            UIImage(named: "newposter1"),
            UIImage(named: "newposter2"),
            UIImage(named: "newposter3"),
            UIImage(named: "newposter4")
        ]
        
        newContentSection.configure(images: newContents)
        watgorithmSection.configure(titleImage: UIImage(named: "watgorithm"), subtitle: "예능부터 드라마까지!", images: mainPosters)
        upcomingSection.configure(title: "공개 예정 콘텐츠", images: mainPosters)
        watchaPartySection.configure(title: "왓챠 파티", images: mainPosters)
    }
}
