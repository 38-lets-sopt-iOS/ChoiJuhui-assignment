//
//  UIFont+.swift
//  iOS-Assignments
//
//  Created by h2e on 5/1/26.
//


import UIKit

enum PretendardWeight: String {
    case light = "Pretendard-Light"
    case regular = "Pretendard-Regular"
    case medium = "Pretendard-Medium"
    case semiBold = "Pretendard-SemiBold"
    
    var systemWeight: UIFont.Weight {
        switch self {
        case .light: return .light
        case .regular: return .regular
        case .medium: return .medium
        case .semiBold: return .semibold
        }
    }
}

extension UIFont {
    private static func pretendard(size: CGFloat, weight: PretendardWeight) -> UIFont {
        return UIFont(name: weight.rawValue, size: size) ?? .systemFont(ofSize: size, weight: weight.systemWeight)
    }
    
    static let head1 = pretendard(size: 30, weight: .semiBold)
    static let head2 = pretendard(size: 23, weight: .semiBold)
    static let head3 = pretendard(size: 20, weight: .semiBold)
    static let subhead1 = pretendard(size: 18, weight: .semiBold)
    static let subhead2 = pretendard(size: 15, weight: .semiBold)
    static let subhead3 = pretendard(size: 12, weight: .semiBold)
    static let medium = pretendard(size: 18, weight: .medium)
    static let body1  = pretendard(size: 12, weight: .medium)
    static let body2  = pretendard(size: 12, weight: .regular)
    static let cap1   = pretendard(size: 12, weight: .light)
}
