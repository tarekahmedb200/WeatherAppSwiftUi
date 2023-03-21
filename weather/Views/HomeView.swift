//
//  ContentView.swift
//  WeatherApp
//
//  Created by lapshop on 3/11/23.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    let gridItem = GridItem(.fixed(150))
    
    var body: some View {
        
        
        NavigationView {
            
        ZStack {
            
        ScrollView {
            VStack(spacing:20) {
               
                VStack {
                    
                    if let imageData = viewModel.imageData,
                       let image = UIImage(data: imageData) ,
                       let img = Image(uiImage: image) {
                        img
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                    }
                    
                    Text(viewModel.weatherCelsius)
                        .font(.system(size: 50, weight: .bold))
                        
                    Text(viewModel.weatherMainTitle)
                        .font(.system(size: 30, weight: .bold))
                        
                    HStack {
                        Text(viewModel.weatherMaxCelsius)
                            .font(.system(size: 30, weight: .bold))
                            
                        Text(viewModel.weatherMinCelsius)
                            .font(.system(size: 30, weight: .bold))
                    }
                    
                }
                
                ScrollView(.horizontal) {
                    LazyHGrid(rows: [gridItem]) {
                        ForEach(viewModel.weatherForecastViewModelList,id: \.id) {
                            ForecastView(weatherForecastViewModel: $0)
                        }
                        
                    }
                }
            }
        }
        .searchable(text: $viewModel.cityName)
        .onSubmit(of: .search) {
            viewModel.fetchCurrentWeatherLocation()
            viewModel.fetchWeatherForecast()
        }
            
        }
        
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.gray]), startPoint: .top, endPoint: .bottom)
        )
        }
        
        
        
        
    }
       
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
