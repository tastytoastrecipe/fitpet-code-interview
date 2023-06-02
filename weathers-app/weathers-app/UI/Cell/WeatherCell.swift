//
//  WeatherCell.swift
//  weather-app
//
//  Created by ios.kwon on 2023/06/01.
//

import UIKit
import Kingfisher
import weathers_domain

class WeatherCell: UITableViewCell {

    // MARK: - Outlets
    
    let titleLbl: UILabel! = {
        let ui = UILabel()
        return ui
    }()
    
    let weatherImg: UIImageView! = {
        let ui = UIImageView()
        return ui
    }()
    
    let weatherLbl: UILabel! = {
        let ui = UILabel()
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
        return ui
    }()
    
    let maxCelsiusLbl: UILabel! = {
        let ui = UILabel()
        return ui
    }()
    
    
    
    // MARK: - Properties
    
    
    
    
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
        titleLbl.text = data.day
        
        if let url = URL(string: data.wetherImgUrl) {
            weatherImg.kf.setImage(with: url)
        }
        
        weatherLbl.text = data.weatherText
        
        minCelsiusLbl.text = data.minCelsius
        
        maxCelsiusLbl.text = data.maxCelsius
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
            make.width.greaterThanOrEqualTo(0)
            make.height.equalTo(20)
        }
        
        celsiusStack.addArrangedSubview(minCelsiusLbl)
        celsiusStack.addArrangedSubview(maxCelsiusLbl)
    }
}
