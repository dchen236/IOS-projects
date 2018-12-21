//
//  SwipeController.swift
//  AutoLayout_Programmatically


//  Created by Danni on 12/17/18.
//  Copyright © 2018 Danni Chen. All rights reserved.
//

import UIKit

class SwippingController: UICollectionViewController,UICollectionViewDelegateFlowLayout {


 
    
    let pages = [Page(imageName: "bear_first", headerText: "Join us today in our fun games!",bodyText:"\n\nAre you ready for loads and loads of fun?Don't wait any longer ! We hope to see you in our stores soon."),
                 Page(imageName: "heart_second", headerText: "Substribe and get coupons on our daily events!",bodyText:"\n\nGet notified of the savings immediately when we announce them"),
                 Page(imageName: "leaf_third", headerText: "and get membership and service today!",bodyText:"\n\nTo be determined!")]

    
    
    private let previousButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("prev", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    @objc private func handlePrev(){
        let previousIndex = max(pageControl.currentPage-1,0)
        let indexPath = IndexPath(item: previousIndex, section: 0)
        collectionView.scrollToItem(at:indexPath,at:.centeredHorizontally, animated:true)
        pageControl.currentPage = previousIndex
        
    }
    private let nextButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("next", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleNext(){
        
      
        let nextIndex = min(pageControl.currentPage+1,pages.count-1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private lazy var pageControl:UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .mainPink
        return pc
    }()
    
    fileprivate func setupBottomControl(){
        //view.addSubview(previousButton)

        let bottomControlStackView = UIStackView(arrangedSubviews:[previousButton,pageControl,nextButton])
        bottomControlStackView.distribution = .fillEqually
        // bottomControlStackView.axis = .vertical vertially placement
        view.addSubview(bottomControlStackView)
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomControlStackView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        setupBottomControl()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height:view.frame.height)
    }
}
