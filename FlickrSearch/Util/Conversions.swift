//
//  Conversions.swift
//  FlickrSearch
//
//  Created by Sha'Marcus Walker on 2/10/25.
//
import Foundation

struct Conversions {
    static func formattedDate(from dateString: String) -> String? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            return displayFormatter.string(from: date)
        }
        return nil
    }

    static func parseImageDimensions(from description: String) -> (width: Int, height: Int)? {
        let regex = try? NSRegularExpression(pattern: #"(\d+) x (\d+)"#)
        
        if let match = regex?.firstMatch(in: description, range: NSRange(description.startIndex..., in: description)) {
            if let widthRange = Range(match.range(at: 1), in: description), let heightRange = Range(match.range(at: 2), in: description) {
                
                let width = Int(description[widthRange]) ?? 0
                let height = Int(description[heightRange]) ?? 0
                return (width, height)

                
            }
        }
        return nil
    }

}
