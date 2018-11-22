//
//  TabBar.swift
//  Goalkeeper
//
//  Created by Artesia Ko on 11/18/18.
//  Copyright © 2018 ACRY. All rights reserved.
//

import UIKit

import UIKit

class TabBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //weak var delegate: changeTab?
    
    var tbArr: [TabItem]!
    var collectionView: UICollectionView!
    let cellIdentifier = "cellID"
    
    var co_background: UIColor = .darkGray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = co_background
        
        //TODO: change this accordingly to fit tabs needed
        let t1 = TabItem(image: "defaultImage", name: "Calendar", selected: false)
        let t2 = TabItem(image: "defaultImage", name: "Home", selected: true)
        let t3 = TabItem(image: "defaultImage", name: "Progress", selected: false)
        tbArr = [t1, t2, t3]
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(tabCell.self, forCellWithReuseIdentifier: cellIdentifier)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor),
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            ])
    }
    
/**********         COLLECTION VIEW functions           **********/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tbArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! tabCell
        let type = tbArr[indexPath.item]
        cell.configure(for: type)
        cell.backgroundColor = .clear
        if (type.selected) {
            cell.rec.alpha = 0
        }
        else {
            cell.rec.alpha = 0.5
        }
        cell.setNeedsUpdateConstraints()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width)/CGFloat(tbArr.count), height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //when tab clicked
        for i in 0...tbArr.count-1 {
            tbArr[i].selected = false
        }
        tbArr[indexPath.item].selected = true
        //self.delegate?.changeType(newType: tbArr[indexPath.item].name)
        collectionView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



/********       TabCVC        ******/
class tabCell: UICollectionViewCell {
    
    var co_tabBar: UIColor = .darkGray
    var co_text: UIColor = .white
    
    var label: UILabel!
    var image: UIImageView!
    var rec: UIImageView!
    
    var t: String = "text"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 5, weight: .light)
        label.text = t
        label.textColor = co_text
        label.isHidden = true
        contentView.addSubview(label)
        
        image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "defaultImage")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        image.contentMode = .scaleAspectFill
        contentView.addSubview(image)
        
        rec = UIImageView()
        rec.translatesAutoresizingMaskIntoConstraints = false
        rec.backgroundColor = co_tabBar
        rec.alpha = 0
        contentView.addSubview(rec)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            image.widthAnchor.constraint(equalTo: contentView.heightAnchor, constant: -10),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
            ])
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5)
            ])
        NSLayoutConstraint.activate([
            rec.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rec.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rec.topAnchor.constraint(equalTo: contentView.topAnchor),
            rec.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
    
    func configure(for tb: TabItem) {
        label.text = tb.name
        image.image = UIImage(named: tb.image)
        if (tb.selected) {
            contentView.backgroundColor = co_tabBar
            rec.alpha = 0
        }
        else {
            contentView.backgroundColor = co_tabBar
            rec.alpha = 0.50
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
