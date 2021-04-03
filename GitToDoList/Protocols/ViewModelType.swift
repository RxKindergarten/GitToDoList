//
//  ViewModelType.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/03/20.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
