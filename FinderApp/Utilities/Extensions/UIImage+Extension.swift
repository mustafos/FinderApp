//
//  UIImage+Extension.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 17.05.2024.
//

import CloudKit
import UIKit

extension UIImage {
    func convertToCKAsset() -> CKAsset? {
        
        guard let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Document Directory url came back nil")
            return nil
        }
        
        let fileUrl = urlPath.appendingPathComponent("selectedAvatarImage")
        
        guard let imageData = jpegData(compressionQuality: 0.25) else { return nil }
        
        do {
            try imageData.write(to: fileUrl)
            return CKAsset(fileURL: fileUrl)
        } catch {
            return nil
        }
    }
}

