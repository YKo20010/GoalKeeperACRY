//
//  HeaderView2.swift
//  Goalkeeper
//
//  Created by Avani Aggrwal on 11/26/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

class HeaderView2: UIView {
    
    weak var delegate: pickDate?
    
    var d_name: UITextField!
    var d_date: UIButton!
    let dateFormatter = DateFormatter()
    
    var colorView: UIView!
    
    let co_dateColor: UIColor = UIColor(red: 120/255, green: 116/255, blue: 116/255, alpha: 1.0)
    var co_colorView: UIColor = UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65)
    var co_background: UIColor = UIColor(red: 134/255, green: 187/255, blue: 220/255, alpha: 0.65)
    var co_title: UIColor = .white
    let co_textColor: UIColor = .white
    
    var rec: UIImageView!
    
    init(frame: CGRect, viewHeight: CGFloat, viewWidth: CGFloat, t_Name: String, t_Date: Date) {
        super.init(frame: frame)
        
        self.backgroundColor = co_background
        
        colorView = UIView()
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.backgroundColor = co_colorView
        self.addSubview(colorView)
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let nameHeight: CGFloat = 40
        let dateHeight: CGFloat = 25
        
        d_name = UITextField()
        d_name.translatesAutoresizingMaskIntoConstraints = false
        d_name.backgroundColor = .clear
        d_name.textColor = co_textColor
        d_name.text = t_Name
        d_name.textAlignment = .center
        d_name.borderStyle = .none
        d_name.font = UIFont.boldSystemFont(ofSize: nameHeight-5)
        d_name.placeholder = "Goal"
        d_name.clearsOnBeginEditing = true
        self.addSubview(d_name)
        
        d_date = UIButton()
        d_date.translatesAutoresizingMaskIntoConstraints = false
        d_date.setTitleColor(co_dateColor, for: .normal)
        d_date.setTitle("by " + dateFormatter.string(from: t_Date), for: .normal)
        d_date.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        d_date.addTarget(self, action: #selector(pickDate), for: .touchDown)
        self.addSubview(d_date)
        
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: self.topAnchor),
            colorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        NSLayoutConstraint.activate([
            d_name.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 9/895*viewHeight),
            d_name.heightAnchor.constraint(equalToConstant: 46/895*viewHeight),
            d_name.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 1/414*viewWidth),
            d_name.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20/414*viewWidth)
            ])
        NSLayoutConstraint.activate([
            d_date.topAnchor.constraint(equalTo: d_name.bottomAnchor),
            d_date.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
    }
    
    @objc func pickDate() {
        d_date.isEnabled = false
        d_name.isEnabled = false
        self.delegate?.pickingDate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
