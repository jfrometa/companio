import Foundation

extension Double {
    func displayTimestamp() -> String {
        let date: TimeInterval = self

        let dateTimeStamp = NSDate(timeIntervalSince1970: Double(date) / 1000)

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "dd MMMM yyyy"

        let strDateSelect = dateFormatter.string(from: dateTimeStamp as Date)

        return strDateSelect
    }
}
