//
//  ImageLoadService.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 12/14/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation
import UIKit

public protocol ImageLoadService {
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> ()) -> Cancellable
}
