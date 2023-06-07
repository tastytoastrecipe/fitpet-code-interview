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
        let daysGap = calculateDays()
        if daysGap == 0 { return "Today" }
        else if daysGap == 1 { return "Tomorrow" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E d MMM"
        return formatter.string(from: self)
    }
    
    /// self와 오늘이 몇일 차이인지 구함
    private func calculateDays() -> Int {
        let calendar = Calendar.current
        let now = Date()
        
        // 오늘 자정
        let midnight = calendar.startOfDay(for: now)
        
        // 오늘 자정과 현재 시간(일)의 차이
        let components = calendar.dateComponents([.day], from: midnight, to: self)

        return components.day ?? 0
    }
}
