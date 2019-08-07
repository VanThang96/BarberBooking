//
//  HomeViewController.swift
//  BarberBooking
//
//  Created by Nguyen Van Thang on 7/26/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var colBanner: UICollectionView!
    @IBOutlet weak var pgBanner: UIPageControl!
    
    var timer : Timer?
    var currentPage : Int?
    let listBanner = [UIImage(named: "ico_banner_1"),UIImage(named: "ico_banner_2"),UIImage(named: "ico_banner_3")]
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupCollectionView()
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(handleScrollCollectionView), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
}

//MARK:- REGISTER COLLECTIONVIEW
extension HomeViewController {
    func setupCollectionView(){
        colBanner.register(UINib(nibName: String(describing: BannerCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    @objc func handleScrollCollectionView(){
        if let collectionView = colBanner{
            for cell in collectionView.visibleCells {
                let indexPath = collectionView.indexPath(for: cell)
                
                if indexPath!.item < 2 {
                    let destinationIndexPath = IndexPath(item: indexPath!.item + 1, section: indexPath!.section)
                    collectionView.scrollToItem(at: destinationIndexPath, at: .centeredHorizontally, animated: true)
                    currentPage = destinationIndexPath.item
                    self.pgBanner.currentPage = currentPage!
                }else {
                    let destinationIndexPath = IndexPath(item: 0, section: indexPath!.section)
                    collectionView.scrollToItem(at: destinationIndexPath, at: .centeredHorizontally, animated: false)
                    currentPage = destinationIndexPath.item
                    self.pgBanner.currentPage = currentPage!
                }
            }
        }
    }
}

//MARK:-  COLLECTIONVIEW DATASOURCE, COLLECTIONVIEW DELEGATE
extension HomeViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listBanner.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BannerCollectionViewCell
        cell.banner = listBanner[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK:-  COLLECTIONVIEW DELEGATE FLOW LAYOUT
extension HomeViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
