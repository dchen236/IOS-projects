//
//  PageCell.swift
//  AutoLayout_Programmatically
//
//  Created by Danni on 12/17/18.
//  Copyright © 2018 Danni Chen. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell{


    var page:Page?{
        didSet{
            guard let unwarppedPage = page else{return}
            bearImageView.image = UIImage(named: (unwarppedPage.imageName))
            let attributeText = NSMutableAttributedString(string:unwarppedPage.headerText,attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
            attributeText.append(NSAttributedString(string: "\n\n\n\(unwarppedPage.bodyText).", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)]))
            descriptionTextView.attributedText = attributeText
        }
    }
    private let bearImageView:UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionTextView:UITextView = {
        let textView = UITextView()
        let attributeText = NSMutableAttributedString(string:"Join us today in our fun and games!",attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        attributeText.append(NSAttributedString(string: "\n\n\nAre you ready for loads of fun? Don't wait any longer! We hope t see you in our stores soon.", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)]))
        textView.attributedText = attributeText
        //        textView.text = "Join us today in our fun and games!"
        //        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.textAlignment = .center
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       setUpLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout(){
        //        add container to hold the bearImage View
        let topImageContainer = UIView()
        addSubview(topImageContainer)
        addSubview(descriptionTextView)
        topImageContainer.translatesAutoresizingMaskIntoConstraints = false
        topImageContainer.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
        topImageContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        topImageContainer.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        topImageContainer.rightAnchor.constraint(equalTo:safeAreaLayoutGuide.rightAnchor).isActive = true
        topImageContainer.addSubview(bearImageView)
        //        set up layout for bear image
        bearImageView.centerYAnchor.constraint(equalTo: topImageContainer.safeAreaLayoutGuide.centerYAnchor).isActive = true
        bearImageView.centerXAnchor.constraint(equalTo: topImageContainer.safeAreaLayoutGuide.centerXAnchor).isActive = true
        bearImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        bearImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
//                set up layout for descriptionTextView
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainer.safeAreaLayoutGuide.bottomAnchor,constant:30).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor,constant:25).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo:safeAreaLayoutGuide.rightAnchor,constant:-25).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo:safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}
