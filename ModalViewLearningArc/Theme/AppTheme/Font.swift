//
//  Font.swift
//  ModalViewLearningArc
//
//  Created by Kesavan Panchabakesan on 13/04/25.
//


import Foundation
import SwiftUI

// SwiftUI Font Weight to CSS Equivalent values:

// Example usage: Text("listHeader").fontWeight(.regular)
// .ultraLight
// Normalized Weight: -0.8
// CSS Equivalent: 100

// .thin
// Normalized Weight: -0.6
// CSS Equivalent: 200

// .light
// Normalized Weight: -0.4
// CSS Equivalent: 300

// .regular
// Normalized Weight: 0
// CSS Equivalent: 400 (normal)

// .medium
// Normalized Weight: 0.23
// CSS Equivalent: 500

// .semibold
// Normalized Weight: 0.3
// CSS Equivalent: 600

// .bold
// Normalized Weight: 0.4
// CSS Equivalent: 700

// .heavy
// Normalized Weight: 0.56
// CSS Equivalent: 800

// .black
// Normalized Weight: 0.62
// CSS Equivalent: 900

extension Font {
    // Predefined Font Sizes
    static var largeTitle: Font {
        return Font.system(size: 34, weight: .regular)
    }
    
    static var title: Font {
        return Font.system(size: 28, weight: .regular)
    }
    
    static var title2: Font {
        return Font.system(size: 22, weight: .regular)
    }
    
    static var title3: Font {
        return Font.system(size: 20, weight: .regular)
    }
    
    static var headline: Font {
        return Font.system(size: 17, weight: .semibold)
    }
    
    static var callout: Font {
        return Font.system(size: 16, weight: .regular)
    }
    
    static var subheadline: Font {
        return Font.system(size: 15, weight: .regular)
    }
    
    static var body: Font {
        return Font.system(size: 17, weight: .regular)
    }
    
    static var footnote: Font {
        return Font.system(size: 13, weight: .regular)
    }
    
    static var caption: Font {
        return Font.system(size: 12, weight: .regular)
    }
    
    static var caption2: Font {
        return Font.system(size: 11, weight: .regular)
    }
    
    // Custom Font Sizes
    static var extraLargeHeader: Font {
        return Font.system(size: 80, weight: .regular)
    }
    
    static var extraLargeHeader2: Font {
        return Font.system(size: 70, weight: .regular)
    }
    
    static var extraLargeTitle: Font {
        return Font.system(size: 40, weight: .regular)
    }
    
    static var subLargeTitle: Font {
        return Font.system(size: 32, weight: .regular)
    }
    
    static var titleMedium: Font {
        return Font.system(size: 24, weight: .regular)
    }
    
    static var subTitle: Font {
        return Font.system(size: 18, weight: .regular)
    }
    
    static var regular: Font {
        return Font.system(size: 14, weight: .regular)
    }
    
    static var caption3: Font {
        return Font.system(size: 10, weight: .regular)
    }
    
    static var note: Font {
        return Font.system(size: 8, weight: .regular)
    }
}