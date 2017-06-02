//
//  Filters.swift
//  Filterer
//
//  Created by Ruziev on 5/28/17.
//  Copyright © 2017 UofT. All rights reserved.
//

import Foundation
import UIKit

class Filters {
    
    internal static func calculate_averages(rgbaImage: RGBAImage) -> (avgRed: Int, avgGreen: Int, avgBlue: Int) {
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width{
                let index = y * rgbaImage.width + x
                let pixel = rgbaImage.pixels[index]
                
                totalRed += Int(pixel.red)
                totalGreen += Int(pixel.green)
                totalBlue += Int(pixel.blue)
            }
        }
        let pixelCount = rgbaImage.width * rgbaImage.height
        let avgRed = totalRed / pixelCount
        let avgGreen = totalGreen / pixelCount
        let avgBlue = totalBlue / pixelCount
        return (avgRed, avgGreen, avgBlue)
    }
    
    internal static func makeRed(image: UIImage, intensity: Double = 3) -> UIImage {
        var image = RGBAImage(image: image)!
        let averages = calculate_averages(image)
        
        for y in 0..<image.height {
            for x in 0..<image.width {
                let index = y * image.width + x
                var pixel = image.pixels[index]
                
                let redDelta = Int(pixel.red) - averages.avgRed
                //let greenDelta = Int(pixel.green) - averages.avgGreen
                //let blueDelta = Int(pixel.blue) - averages.avgBlue
                
                let redVal: Double = Double(averages.avgRed) + intensity * Double(redDelta)
                //let greenVal: Double = Double(averages.avgGreen) + 4 * Double(greenDelta)
                //let blueVal: Double = Double(averages.avgBlue) + 4 * Double(blueDelta)
                pixel.red = UInt8(max(min(255, redVal), 0))
                //pixel.green = UInt8(max(min(255, greenVal), 0))
                //pixel.blue = UInt8(max(min(255, blueVal), 0))
                
                image.pixels[index] = pixel
            }
        }
        
        return image.toUIImage()!
    }
    
    internal static func makeGreen(image: UIImage, intensity: Double = 3) -> UIImage {
        var image = RGBAImage(image: image)!
        let averages = calculate_averages(image)
        
        for y in 0..<image.height {
            for x in 0..<image.width {
                let index = y * image.width + x
                var pixel = image.pixels[index]
                
                //let redDelta = Int(pixel.red) - averages.avgRed
                let greenDelta = Int(pixel.green) - averages.avgGreen
                //let blueDelta = Int(pixel.blue) - averages.avgBlue
                
                //let redVal: Double = Double(averages.avgRed) + 4 * Double(redDelta)
                let greenVal: Double = Double(averages.avgGreen) + intensity * Double(greenDelta)
                //let blueVal: Double = Double(averages.avgBlue) + 4 * Double(blueDelta)
                //pixel.red = UInt8(max(min(255, redVal), 0))
                pixel.green = UInt8(max(min(255, greenVal), 0))
                //pixel.blue = UInt8(max(min(255, blueVal), 0))
                
                image.pixels[index] = pixel
            }
        }
        
        return image.toUIImage()!
    }
    
    internal static func makeBlue(image: UIImage, intensity: Double = 3) -> UIImage {
        var image = RGBAImage(image: image)!
        let averages = calculate_averages(image)
        
        for y in 0..<image.height {
            for x in 0..<image.width {
                let index = y * image.width + x
                var pixel = image.pixels[index]
                
                //let redDelta = Int(pixel.red) - averages.avgRed
                //let greenDelta = Int(pixel.green) - averages.avgGreen
                let blueDelta = Int(pixel.blue) - averages.avgBlue
                
                //let redVal: Double = Double(averages.avgRed) + 4 * Double(redDelta)
                //let greenVal: Double = Double(averages.avgGreen) + 4 * Double(greenDelta)
                let blueVal: Double = Double(averages.avgBlue) + intensity * Double(blueDelta)
                //pixel.red = UInt8(max(min(255, redVal), 0))
                //pixel.green = UInt8(max(min(255, greenVal), 0))
                pixel.blue = UInt8(max(min(255, blueVal), 0))
                
                image.pixels[index] = pixel
            }
        }
        
        return image.toUIImage()!
    }
    
    internal static func makePurple(image: UIImage, intensity: Double = 3) -> UIImage {
        var image = RGBAImage(image: image)!
        let averages = calculate_averages(image)
        
        for y in 0..<image.height {
            for x in 0..<image.width {
                let index = y * image.width + x
                var pixel = image.pixels[index]
                
                let redDelta = Int(pixel.red) - averages.avgRed
                //let greenDelta = Int(pixel.green) - averages.avgGreen
                let blueDelta = Int(pixel.blue) - averages.avgBlue
                
                let redVal: Double = Double(averages.avgRed) + intensity * Double(redDelta)
                //let greenVal: Double = Double(averages.avgGreen) + 4 * Double(greenDelta)
                let blueVal: Double = Double(averages.avgBlue) + intensity * Double(blueDelta)
                pixel.red = UInt8(max(min(255, redVal), 0))
                //pixel.green = UInt8(max(min(255, greenVal), 0))
                pixel.blue = UInt8(max(min(255, blueVal), 0))
                
                image.pixels[index] = pixel
            }
        }
        
        return image.toUIImage()!
    }

    
    internal static func makeYellow(image: UIImage, intensity: Double = 3) -> UIImage {
        var image = RGBAImage(image: image)!
        let averages = calculate_averages(image)
        
        for y in 0..<image.height {
            for x in 0..<image.width {
                let index = y * image.width + x
                var pixel = image.pixels[index]
                
                let redDelta = Int(pixel.red) - averages.avgRed
                let greenDelta = Int(pixel.green) - averages.avgGreen
                //let blueDelta = Int(pixel.blue) - averages.avgBlue
                
                let redVal: Double = Double(averages.avgRed) + intensity * Double(redDelta)
                let greenVal: Double = Double(averages.avgGreen) + intensity * Double(greenDelta)
                //let blueVal: Double = Double(averages.avgBlue) + 3 * Double(blueDelta)
                pixel.red = UInt8(max(min(255, redVal), 0))
                pixel.green = UInt8(max(min(255, greenVal), 0))
                //pixel.blue = UInt8(max(min(255, blueVal), 0))
                
                image.pixels[index] = pixel
            }
        }
        
        return image.toUIImage()!
    }

}