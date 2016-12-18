//
//  PhotoListViewController.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListViewController: UIViewController {

    let photoSearchAPI = PhotoSearchAPI()
    let dataSource = PhotoListCollectionView()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tagsTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!

    var photos: [Photo] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var photoListStatusType: PhotoListStatusable?
    var page = PhotoListPage()
    var tags = ""

    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStatus()
        setupView()
    }

    @IBAction func searchDidTap(_ sender: UIButton) {
        resetPage()
        loadPhotoSearch(tags: tagsTextField.text ?? "")
        tagsTextField.resignFirstResponder()
    }

    //MARK:-Private
    fileprivate func setupStatus() {
        photoListStatusType = PhotoListStatusNone()
    }

    fileprivate func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        tagsTextField.delegate = self
        searchButton.isEnabled = false
        photoListStatusType?.updateView(result: nil, topOf: self)
    }

    fileprivate func resetPage() {
        photos = []
        page.resetPage()
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

        guard hasExsistPhotoList() else{
            return
        }
        updatePage()
    }

    fileprivate func hasExsistPhotoList() -> Bool{

        if collectionView.contentOffset.y >=
            (collectionView.contentSize.height - collectionView.bounds.size.height) {

            if photoSearchAPI.waiting(){
                return false
            }

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

        return photoListStatusType?.cellSize(topOf: self) ??
            PhotoListStatusNone().cellSize(topOf: self)
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

    func setStatus(status: PhotoSearchStatus, result: PhotoSearchResult?) {
        photoListStatusType = status.type()
        photoListStatusType?.updateView(result: result, topOf: self)
    }
}
