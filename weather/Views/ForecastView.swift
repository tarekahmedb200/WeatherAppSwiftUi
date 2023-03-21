//
//  ForecastView.swift
//  weather
//
//  Created by lapshop on 3/17/23.
//

import SwiftUI

struct ForecastView: View {
    
   var weatherForecastViewModel: WeatherForecastViewModel
    
    var body: some View {
        VStack {
            Text(weatherForecastViewModel.dateTime)
                .font(.system(size: 20))
            
            if let imageData = weatherForecastViewModel.imageData,
               let image = UIImage(data: imageData) ,
               let img = Image(uiImage: image) {
                img
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
            }
            
            Text("\(weatherForecastViewModel.weatherCelsius)°")
                .font(.system(size: 20))
        }
        .frame(width: 150, height: 150)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.gray]), startPoint: .top, endPoint: .bottom)
        )
       
        .cornerRadius(10)
    }

}

//struct ForecastView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastView(time: "12:00 PM", IconImage: "", temp: "12c")
//    }
//}
