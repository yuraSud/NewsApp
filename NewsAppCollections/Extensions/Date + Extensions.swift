

import Foundation

extension Date {
    func format() -> String {
        let formatter = DateFormatter()
        if Calendar.current.isDateInToday(self) {
            formatter.dateFormat = "h:mm"
            
        } else {
            formatter.dateFormat = "d.MM.yy"
        }
        return formatter.string(from: self)
    }
}
