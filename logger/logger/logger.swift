//
//  logger.swift
//  logger
//
//  Created by ios.kwon on 2023/06/02.
//

public enum LogType: String {
    case normal = "💬"
    case warning = "⚠️"
    case err = "🚫"
    case api = "📥"
    case weather = "☁️"
}

public func showLog(logType: LogType = .normal, title: String = "LOG", _ log: String) {
    
    #if DEBUG
    
    let seperator = "**********************************************"
    let log = "\n\(seperator)\n\n\(logType.rawValue) [\(title)]\n\(log)\n"
    print(log)
    
    #endif
    
}
