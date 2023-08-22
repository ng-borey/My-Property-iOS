//
//  UserHelper.swift
//  My-Property-iOS
//
//  Created by Ngoun Lyborey on 8/6/23.
//

import Foundation

struct UserHelper {
    
    var token: Obervable<String> = Obervable(values: "MjNmYzM4ZjItYmI2MC00ZjMxLThjYzEtZjIyMGZkYTY2ZGJh")
}

class Obervable<T> {
    var values: T? {
        didSet {
            listener?(values)
        }
    }
    
    init(values: T? = nil) {
        self.values = values
    }
    
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(values)
        self.listener = listener
    }
}
