//
//  CKAsset+Extension.swift
//  FinderApp
//
//  Created by Mustafa Bekirov on 08.05.2024.
//  Copyright © 2024 Mustafa Bekirov. All rights reserved.

import CloudKit
import UIKit

extension CKAsset {
    func convertToUIImage(in dimension: ImageDimension) -> UIImage {
        let placeholder = ImageDimension.getPlaceholder(for: dimension)
        
        guard let fileURL = self.fileURL else { return placeholder }
        
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data) ?? placeholder
        } catch {
            return placeholder
        }
    }
}
