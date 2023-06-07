//
//  WeatherCell.swift
//  weather-app
//
//  Created by ios.kwon on 2023/06/01.
//

import UIKit
import Kingfisher
import weathers_domain


/**
 
 # WeatherCell #
 
 홈 화면의 날씨 정보를 표시하는 cell
 
*/

class WeatherCell: UITableViewCell {
    
    static let cellHeight: CGFloat = 80
    

    // MARK: - Outlets
    
    let titleLbl: UILabel! = {
        let ui = UILabel()
        ui.textColor = .darkGray
        return ui
    }()
    
    let weatherImg: UIImageView! = {
        let ui = UIImageView()
        ui.contentMode = .scaleAspectFill
        return ui
    }()
    
    let weatherLbl: UILabel! = {
        let ui = UILabel()
        ui.font = UIFont.systemFont(ofSize: 14)
        ui.textColor = .darkGray
        return ui
    }()
    
    let celsiusStack: UIStackView! = {
        let ui = UIStackView()
        ui.axis = .horizontal
        ui.distribution = .fillEqually
        return ui
    }()
    
    let minCelsiusLbl: UILabel! = {
        let ui = UILabel()
        ui.font = UIFont.systemFont(ofSize: 14)
        ui.textAlignment = .right
        ui.textColor = .darkGray
        return ui
    }()
    
    let maxCelsiusLbl: UILabel! = {
        let ui = UILabel()
        ui.font = UIFont.systemFont(ofSize: 14)
        ui.textAlignment = .right
        ui.textColor = .darkGray
        return ui
    }()
    
    
    
    // MARK: - Properties
    
    let kelvin: Double = 273.15
    
    
    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Methods
    
    func setContent(data: Weather) {
        titleLbl.text = data.day.toWeatherDateString()
        
        if let url = URL(string: data.weatherImgUrl) {
            weatherImg.kf.setImage(with: url)
        }
        
        weatherLbl.text = data.weatherText.capitalized
        
        minCelsiusLbl.text = "Min : \(Int(ceil(data.minCelsius - kelvin)))°C"
        
        maxCelsiusLbl.text = "Max : \(Int(ceil(data.maxCelsius - kelvin)))°C"
    }

    private func setLayout() {
        self.contentView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(8)
            make.width.greaterThanOrEqualTo(0)
            make.height.equalTo(20)
        }
        
        self.contentView.addSubview(weatherImg)
        weatherImg.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(40)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        self.contentView.addSubview(weatherLbl)
        weatherLbl.snp.makeConstraints { make in
            make.leading.equalTo(weatherImg.snp.trailing).offset(8)
            make.width.greaterThanOrEqualTo(0)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        self.contentView.addSubview(celsiusStack)
        celsiusStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        celsiusStack.addArrangedSubview(minCelsiusLbl)
        celsiusStack.addArrangedSubview(maxCelsiusLbl)
    }
}
