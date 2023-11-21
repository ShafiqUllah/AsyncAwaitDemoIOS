//
//  GitError.swift
//  AsyncAwaitDemo
//
//  Created by Shafiq  Ullah on 11/21/23.
//

import Foundation

enum GitError: Error{
    case GitURLNotFound
    case GitInvalidResponse
    case GitInvalidData
}
