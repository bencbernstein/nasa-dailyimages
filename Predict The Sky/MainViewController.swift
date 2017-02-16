//
//  ViewController.swift
//  Predict The Sky
//
//  Created by Benjamin Bernstein on 2/14/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var sectionInsets: UIEdgeInsets!
    var spacing: CGFloat!
    var itemSize: CGSize!
    var referenceSize: CGSize!
    var numberOfRows: CGFloat!
    var numberOfColumns: CGFloat!
    let leftAndRightPadding: CGFloat = 80.0
    var collectionView: UICollectionView!
    var collectionLayout: UICollectionViewFlowLayout!
    var formattedDates = [String]()
    var planets = [Planet]()
    var planetStructs = [PlanetStruct]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
     
        getDates()

        for i in 1..<formattedDates.count {
            NASA.makePlanetTest(date: formattedDates[i], addPlanet: { (planet) in
                self.planetStructs.append(planet)
                OperationQueue.main.addOperation {
                    self.collectionView.reloadData()
                }
            })
        }

            collectionLayout = UICollectionViewFlowLayout()
            collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: collectionLayout)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(PlanetCell.self, forCellWithReuseIdentifier: "Cell")
            
            configureLayout()
            
            self.collectionLayout.itemSize = CGSize(width: view.frame.width, height: 700)

            collectionView.backgroundColor = UIColor.white
            
            self.view.addSubview(collectionView)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection: Int) ->  Int {
        return self.planetStructs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PlanetCell
        let planet = planetStructs[indexPath.item]
        cell.planet = planet
        print(cell.planet)
  
        return cell
    }
    
    
    // methods to conform with UIflow delegate protocol
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return referenceSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return referenceSize
    }
    
    func configureLayout() {
        
        let mainWidth = UIScreen.main.bounds.width
        let mainHeight = UIScreen.main.bounds.height
        numberOfRows = 4
        numberOfColumns = 2
        spacing = 20
        sectionInsets = UIEdgeInsetsMake(spacing, spacing, spacing, spacing)
        referenceSize = CGSize(width: mainWidth, height: 60)
        let itemwidth = (mainWidth / numberOfColumns) - (sectionInsets.left + sectionInsets.right)
        
        let itemheight = (mainHeight / numberOfRows) - (sectionInsets.top + sectionInsets.bottom)
        itemSize = CGSize.init(width: itemwidth, height: itemheight)
        
        
    }

    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    

    func getDates() {
        for i in 0...5 {
            let date = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            let year =  String(describing: components.year ?? 2000)
            let month = String(describing: components.month ?? 01)
            let day = String(describing: (components.day ?? 01) - i)
            let formattedDate = year + "-" + month + "-" + day
            
            print(year)
            print(month)
            print(day)
            formattedDates.append(formattedDate)

        }
        
    }
    
    
}




