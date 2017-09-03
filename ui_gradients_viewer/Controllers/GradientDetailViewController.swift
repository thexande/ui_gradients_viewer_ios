//
//  GradientDetailViewController.swift
//  ui_gradients_viewer
//
//  Created by Alexander Murphy on 8/28/17.
//  Copyright © 2017 Alexander Murphy. All rights reserved.
//

import Foundation
import UIKit

class GradientDetailViewController: UIViewController {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 60)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(pressedBack), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "back_button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(gradient: GradientColor) {
        super.init(nibName: nil, bundle: nil)
        configureGradient(gradient)
    }
    
    func pressedBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureGradient(_ gradient: GradientColor) {
        let gradientView = GradientHelper.produceGradientView(gradient)
        view.insertSubview(gradientView, at: 0)
        titleLabel.text = gradient.title.uppercased()
        subTitleLabel.text = gradient.colors.map({ (stringDict) -> String? in
            return stringDict.keys.first
        }).flatMap({ $0 }).map({ $0.uppercased() }).joined(separator: ", ")
        
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        
        self.navigationController?.navigationBar.barTintColor = .black
        
        let viewsDict = ["title":titleLabel, "grad":gradientView, "sub_title":subTitleLabel]
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:[title]-24-[sub_title]", options: [], metrics: nil, views: viewsDict))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[title]-12-|", options: [], metrics: nil, views: viewsDict))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[sub_title]-12-|", options: [], metrics: nil, views: viewsDict))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[grad]|", options: [], metrics: nil, views: viewsDict))
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[grad]|", options: [], metrics: nil, views: viewsDict))
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -36)
        ])
    }
    
}