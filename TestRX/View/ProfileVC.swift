//
//  ProfileVC.swift
//  TestRX
//
//  Created by Mahmoud Alkady on 13/09/2022.
//

import RxSwift
import RxCocoa

class ProfileVC: UIViewController {
    
    // MARK: - Outlets.
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    //MARK:- Propreties
    var profileViewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }
    
    // MARK: - Actions
    @IBAction func backBtnTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Private Methods
extension ProfileVC {
    private func setupBinding(){
        profileViewModel.post
            .subscribe(onNext: { [unowned self] post in
                self.displayData(post)
            }).disposed(by: disposeBag)
    }
    private func displayData(_ post: Post) {
        DispatchQueue.main.async {
            self.userName.text = post.user
            self.profileImage.kf.setImage(with: post.getUserImageURL(), placeholder: UIImage(named: "profile"))
            self.postImage.kf.setImage(with: post.getImageURL(), placeholder: UIImage(named: "placeholder"))
            self.tagsLabel.text = post.getTags()
        }
    }
    private func setupUI() {
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        postImage.layer.cornerRadius = 14
        backButton.layer.cornerRadius = 7
    }
}
