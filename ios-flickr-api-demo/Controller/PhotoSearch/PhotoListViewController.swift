//
//  PhotoListViewController.swift
//  ios-flicr-api-demo
//
//  Created by Eiji Kushida on 2016/12/17.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit
import SVProgressHUD

final class PhotoListViewController: UIViewController {

    fileprivate let photoSearchAPI = PhotoSearchAPI()
    fileprivate let dataSource = PhotoListCollectionView()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tagsTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet var noDataView: UIView!

    fileprivate var photos = PhotoSearchResult() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    fileprivate var page = PhotoListPage()
    fileprivate var tags = ""

    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func searchDidTap(_ sender: UIButton) {

        resetPage()
        loadPhotoSearch(tags: tagsTextField.text ?? "")
        tagsTextField.resignFirstResponder()
        SVProgressHUD.show()
    }

    //MARK:-Private
    fileprivate func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        tagsTextField.delegate = self
        searchButton.isEnabled = false
    }

    fileprivate func resetPage() {
        photos.photo = []
        page.resetPage()
        noDataView.removeFromSuperview()
    }

    fileprivate func loadPhotoSearch(tags: String) {
        photoSearchAPI.loadable = self

        self.tags = tags
        photoSearchAPI.load(tags: tags, page: page.currentPage())
    }
}

//MARK:-UICollectionViewDelegate
extension PhotoListViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if collectionView.contentOffset.y >=
            (collectionView.contentSize.height - collectionView.bounds.size.height) {

            if photoSearchAPI.waiting(){
                return
            }

            if page.total() > page.currentPage() * PhotoSearchParamsBuilder.perPage {
                updatePage()
            }
        }
    }

    fileprivate func updatePage() {

        page.incementPage()
        photoSearchAPI.load(tags: tags, page: page.currentPage())
        print("\(page.currentPage())ページ目読みます")
    }
}

//MARK:- UITextFieldDelegate
extension PhotoListViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        if let text = textField.text {
            searchButton.isEnabled = (text + string).characters.count > 1
        } else {
            fatalError("入力文字列が取得できない")
        }
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

        SVProgressHUD.dismiss()

        switch status {
        case .noData:
            addNoDataView()
            break

        case .done:
            break

        case .offline:
            break

        case .error:
            print("通信エラーが発生しました。")
        }
    }

    func completed(result: PhotoSearchResult) {

        page.updatePages(pages: result.pages)
        appendPhoto(photos: result.photo.map {$0})
        scrollToTop()
    }

    fileprivate func addNoDataView() {
        dataSource.add(photos: [])
        noDataView.frame = self.view.frame
        noDataView.center = self.view.center
        self.collectionView.addSubview(noDataView)
    }

    fileprivate func appendPhoto(photos: [Photo]) {

        for photo in photos {
            self.photos.photo.append(photo)
        }
        dataSource.add(photos: self.photos.photo)
    }

    fileprivate func scrollToTop() {

        if page.currentPage() == 1 {
            collectionView.contentOffset = CGPoint(x: 0, y: -collectionView.contentInset.top)
        }
    }
}
