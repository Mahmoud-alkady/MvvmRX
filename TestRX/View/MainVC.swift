//
//  MainVC.swift
//  TestRX
//
//  Created by Mahmoud Alkady on 13/09/2022.
//

import RxSwift
import RxCocoa
import Kingfisher

class MainVC: UIViewController {

    // MARK: - Outlets.
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties.
    var mainViewModel = MainViewModel()
    private var activityIndicator: UIActivityIndicatorView!
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize and setup the activity indicator
        activityIndicator = UIActivityIndicatorView()
        setup(activityIndicator: activityIndicator)
        registerCell()
        setupBinding()
        mainViewModel.fetchData()
    }
}

// MARK: - Private Methods
extension MainVC {
    private func setupBinding() {
        mainViewModel.isLoading
            .subscribe(onNext: { [unowned self] isLoading in
                self.updateUI(isLoading: isLoading)
            }).disposed(by: disposeBag)

        // Bind the posts in the ViewModel to the DataSource of the TableView
        bindThePosts()
        
        // Deselect an item when it is selected
        deselectAnItem()
        
        // Get the model of the selected cell and inject it to the profile screen
        getTheData()
        
        // Get the errors and view it.
        bindErrors()
    }
    
    private func setup(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.color = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    private func goToProfileScreen(for post: Post) {
        let profileVC = UIStoryboard(name: "ProfleVC", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        profileVC.profileViewModel.post.onNext(post)
        present(profileVC, animated: true, completion: nil)
    }
    
    private func updateUI(isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading {
                self.activityIndicator.startAnimating()
                self.tableView.isHidden = true
            } else {
                self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
            }
        }
    }
    private func registerCell(){
        let nib = UINib(nibName: "PostCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PostCell")
    }
    private func bindThePosts(){
        mainViewModel
            .posts
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "PostCell", cellType: PostCell.self)) { row, data, cell in
                cell.post = data
                }.disposed(by: disposeBag)
    }
    private func deselectAnItem(){
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] indexPath in
                self.tableView.deselectRow(at: indexPath, animated: true)}).disposed(by: disposeBag)
    }
    private func getTheData(){
        tableView.rx.modelSelected(Post.self)
            .subscribe(onNext: { [unowned self] post in
                self.goToProfileScreen(for: post)
            }).disposed(by: disposeBag)
    }
    private func bindErrors(){
        mainViewModel.error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {error in
                self.showAlertMesage(error)
            }).disposed(by: disposeBag)
    }
}

