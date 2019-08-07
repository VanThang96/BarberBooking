//
//  HomeViewController.swift
//  BarberBooking
//
//  Created by Nguyen Van Thang on 7/26/19.
//  Copyright © 2019 Nguyen Van Thang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var colBanner: UICollectionView!
    @IBOutlet weak var pgBanner: UIPageControl!
    @IBOutlet weak var tbLookBook: UITableView!
    
    //MARK:- Variable
    var timer : Timer?
    var currentPage : Int?
    let listBanner = [UIImage(named: "ico_banner_1"),UIImage(named: "ico_banner_2"),UIImage(named: "ico_banner_3")]
    let listLookBook = [UIImage(named: "ico_booking_01"),UIImage(named: "ico_booking_02"),UIImage(named: "ico_booking_03"),UIImage(named: "ico_booking_04"),UIImage(named: "ico_booking_05")]
    let colCellId = "colCellId"
    let tbCellId = "tbCellId"
    
    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupBannerCollectionView()
        setupLookBookTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(handleScrollCollectionView), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
}

//MARK:- REGISTER COLLECTIONVIEW
extension HomeViewController {
    private func setupBannerCollectionView(){
        colBanner.register(UINib(nibName: String(describing: BannerCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: colCellId)
    }
    
    private func setupLookBookTableView(){
        tbLookBook.isPagingEnabled = true
        tbLookBook.register(UINib(nibName: String(describing: LookBookTableViewCell.self), bundle: nil), forCellReuseIdentifier: tbCellId)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: colCellId, for: indexPath) as! BannerCollectionViewCell
        cell.banner = listBanner[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        timer?.invalidate()
        
        let center = CGPoint(x: targetContentOffset.pointee.x + (scrollView.frame.width/2), y: scrollView.frame.height/2)
        
        if let indexPath = colBanner.indexPathForItem(at: center) {
            self.pgBanner.currentPage = indexPath.item
        }
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(handleScrollCollectionView), userInfo: nil, repeats: true)
    }
}

//MARK:-  COLLECTIONVIEW DELEGATE FLOW LAYOUT
extension HomeViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

//MARK:- TABLEVIEW DELEGATE, TABLEVIEW DATASOURCE
extension HomeViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listLookBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tbCellId, for: indexPath) as! LookBookTableViewCell
        cell.lookBook = listLookBook[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tbLookBook.bounds.height
    }
}
