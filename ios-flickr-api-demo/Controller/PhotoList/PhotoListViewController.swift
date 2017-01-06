//
//  PhotoListViewController.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tagsTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!

    fileprivate let photoSearchAPI = PhotoSearchAPI()
    fileprivate let dataSource = PhotoListCollectionView()
    fileprivate var photoListStatusType = PhotoSearchStatus.none
    fileprivate var reqCount = PhotoSearchRequestCount()
    fileprivate var tags = ""

    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    //MARK:-Actions
    @IBAction func searchDidTap(_ sender: UIButton) {
        
        resetPhotoList(status: .loading)
        loadPhotoSearch(tags: tagsTextField.text ?? "")
        tagsTextField.resignFirstResponder()
    }

    //MARK:-Private
    private func setupView() {
        
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        tagsTextField.delegate = self
        searchButton.isEnabled = false
        resetPhotoList(status: .none)
    }

    fileprivate func resetPhotoList(status: PhotoSearchStatus) {

        reqCount.reset()
        dataSource.add(status: status, photos: [])
        collectionView.reloadData()
    }

    private func loadPhotoSearch(tags: String) {

        self.tags = tags
        photoSearchAPI.loadable = self
        photoSearchAPI.load(tags: tags, page: reqCount.current())
    }
}

//MARK:-UICollectionViewDelegate
extension PhotoListViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        guard hasMorePhotoList() else{ return }
        nextloadPhotoList()
    }

    private func hasMorePhotoList() -> Bool{

        if collectionView.contentOffset.y >=
            (collectionView.contentSize.height - collectionView.bounds.size.height) {

            if photoSearchAPI.waiting(){ return false }
            return reqCount.isMoreRequest()
        }
        return false
    }

    private func nextloadPhotoList() {
        reqCount.incement()
        photoSearchAPI.load(tags: tags, page: reqCount.current())
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension PhotoListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return photoListStatusType.cellSize()
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
            updatePhotoList(result: result)
            
        default:
            resetPhotoList(status: status)
        }
    }
    
    private func updatePhotoList(result: PhotoSearchResult?) {
        
        if let pages = result?.photos?.pages, let photos = result?.photos {
            reqCount.updateTotal(total: pages)
            dataSource.append(status: photoListStatusType,
                              photos: photos.photo.map {$0})
        }
        collectionView.reloadData()
        scrollToTop()
    }
    
    private func scrollToTop() {
        
        if reqCount.current() == 1 {
           collectionView.scrollToTop()
        }
    }
}
