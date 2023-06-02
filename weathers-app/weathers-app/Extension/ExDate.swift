//
//  ExDate.swift
//  weathers-data
//
//  Created by ios.kwon on 2023/06/02.
//

import Foundation

extension Date {
    
    /// 원하는 날짜 String으로 변환
    /// 오늘: "Today"
    /// 내일: "Tomorrow"
    /// 모레 ~: "Sat 1 Dec"
    func toWeatherDateString() -> String {
        let days = calculateDays()
        if days == 0 { return "Today" }
        else if days == 1 { return "Tomorrow" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E d MMM"
        return formatter.string(from: self)
    }
    
    /// self와 오늘이 몇일 차이인지 구함
    private func calculateDays() -> Int {
        let today = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: today, to: self)

        return components.day ?? 0
    }
}
