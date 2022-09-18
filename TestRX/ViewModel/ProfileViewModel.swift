//
//  ProfileViewModel.swift
//  TestRX
//
//  Created by Mahmoud Alkady on 13/09/2022.
//

import RxSwift

class ProfileViewModel {
    public let post: BehaviorSubject<Post> = BehaviorSubject(value: Post())
}

