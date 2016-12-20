//
//  PhotoListViewController.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListViewController: UIViewController {

    fileprivate let photoSearchAPI = PhotoSearchAPI()
    fileprivate let dataSource = PhotoListCollectionView()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tagsTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!

    fileprivate var photoListStatusType = PhotoSearchStatus.none
    fileprivate var page = PhotoListPage()
    fileprivate var tags = ""

    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func searchDidTap(_ sender: UIButton) {
        resetPage(status: .loading)
        loadPhotoSearch(tags: tagsTextField.text ?? "")
        tagsTextField.resignFirstResponder()
    }

    //MARK:-Private

    fileprivate func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        tagsTextField.delegate = self
        searchButton.isEnabled = false
        resetPage(status: .none)
    }

    fileprivate func resetPage(status: PhotoSearchStatus) {

        page.resetPage()
        dataSource.add(status: status, photos: [])
        collectionView.reloadData()
    }

    fileprivate func loadPhotoSearch(tags: String) {

        self.tags = tags
        photoSearchAPI.loadable = self
        photoSearchAPI.load(tags: tags, page: page.currentPage())
    }
}

//MARK:-UICollectionViewDelegate
extension PhotoListViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        guard hasLoadMore() else{ return }
        updatePage()
    }

    fileprivate func hasLoadMore() -> Bool{

        if collectionView.contentOffset.y >=
            (collectionView.contentSize.height - collectionView.bounds.size.height) {

            if photoSearchAPI.waiting(){ return false }

            if page.total() > page.currentPage() * PhotoSearchParamsBuilder.perPage {
                return true
            }
        }
        return false
    }

    fileprivate func updatePage() {
        page.incementPage()
        photoSearchAPI.load(tags: tags, page: page.currentPage())
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension PhotoListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return photoListStatusType.cellCeze()
    }
}

//MARK:- UITextFieldDelegate
extension PhotoListViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        searchButton.isEnabled = (textField.text ?? "" + string).characters.count > 1
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK:- PhotoSearchLoadable
extension PhotoListViewController: PhotoSearchLoadable {

    func setStatus(status: PhotoSearchStatus) {
        photoListStatusType = status
        
        switch status {
        case .normal(let result):
            updateView(result: result)
            
        default:
            resetPage(status: status)
        }
    }
    
    fileprivate func updateView(result: PhotoSearchResult?) {
        
        if let pages = result?.photos?.pages, let photos = result?.photos {
            page.updatePages(pages: pages)
            dataSource.append(status: photoListStatusType,
                              photos: photos.photo.map {$0})
        }
        collectionView.reloadData()
        scrollToTop()
    }
    
    
    fileprivate func scrollToTop() {
        
        if page.currentPage() == 1 {
           collectionView.scrollToTop()
        }
    }
}
