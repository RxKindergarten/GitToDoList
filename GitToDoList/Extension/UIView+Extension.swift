//
//  UIView+Extension.swift
//  GitToDoList
//
//  Created by 선민승 on 2021/03/20.
//

import UIKit

extension UIView {
    func setRounded(radius: CGFloat?) {
        // UIView 의 모서리 둥글 때
        if let cornerRadius = radius {
            self.layer.cornerRadius = cornerRadius
        } else {
            // cornerRadius 가 nil 일 경우의 default
            self.layer.cornerRadius = self.layer.frame.height / 2
        }
        self.layer.masksToBounds = true
    }
    func setBorder(borderColor: UIColor?, borderWidth: CGFloat?) {
        // UIView의 테두리 설정
        // UIView 의 테두리 색상 설정
        if let borderColor = borderColor {
            self.layer.borderColor = borderColor.cgColor
        }
        // UIView 의 테두리 두께 설정
        if let borderWidth = borderWidth {
            self.layer.borderWidth = borderWidth
        } else {
            // borderWidth 변수가 nil 일 경우의 default
            self.layer.borderWidth = 1.0
        }
    }
}
