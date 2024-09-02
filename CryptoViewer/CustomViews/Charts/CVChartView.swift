//
//  CVChartView.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 01.09.2024.
//

import SwiftUI
import Charts

struct CVChartView: View {
    
    let minY: Double
    let maxY: Double
    
    var list: [PriceData] = []
    
    @State private var selectedData: PriceData?
    
    init(minY: Double, maxY: Double, list: [PriceData]) {
        self.minY = minY
        self.maxY = maxY
        self.list = list
    }
    
    var body: some View {
        Chart(list) { priceData in
            
            LineMark(
                x: .value("Date", priceData.time),
                y: .value("Price", priceData.price)
            )
            .interpolationMethod(.cardinal)
            .foregroundStyle(.blue)
            
            PointMark(
                x: .value("Date", priceData.time),
                y: .value("Price", priceData.price)
            )
            .foregroundStyle(.white)
            .symbolSize(8)
            
        }
        .padding()
        .chartYScale(domain: minY...maxY)
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        
        
        .chartOverlay { proxy in
            GeometryReader { geometry in
                Rectangle().fill(Color.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onEnded { value in
                                let location = value.location
                                if let date: Date = proxy.value(atX: location.x) {
                                    
                                    if let nearestData = list.min(by: {
                                        abs($0.time.timeIntervalSince(date)) < abs($1.time.timeIntervalSince(date))
                                    }) {
                                        selectedData = nearestData
                                    }
                                }
                            }
                    )
            }
        }
        .overlay(alignment: .bottom) {
            if let selected = selectedData {
                Text("Date: \(selected.time), Price: \(selected.price)")
                    .padding(5)
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
        }
    }
}
 

#Preview {
    CVChartView(minY: 69000, maxY: 71800,
                list: [
                    PriceData(time: "2024-06-05 13:04:29 +0000", price: 70979.39844584733),
                    PriceData(time: "2024-06-05 14:08:16 +0000", price: 70643.51067253706),
                    PriceData(time: "2024-06-05 15:04:34 +0000", price: 70883.84892621133),
                    PriceData(time: "2024-06-05 16:03:20 +0000", price: 71587.3390476925),
                    PriceData(time: "2024-06-05 17:01:35 +0000", price: 71331.28620844566),
                    PriceData(time: "2024-06-05 18:05:31 +0000", price: 71713.94076998901),
                    PriceData(time: "2024-06-05 19:05:36 +0000", price: 71118.28092102184),
                    PriceData(time: "2024-06-05 20:08:08 +0000", price: 71197.62590248944),
                    PriceData(time: "2024-06-05 21:01:14 +0000", price: 71218.07366859974),
                    PriceData(time: "2024-06-05 22:04:41 +0000", price: 71144.3179387504),
                    PriceData(time: "2024-06-05 23:04:02 +0000", price: 71162.3800160821),
                    PriceData(time: "2024-06-06 00:03:53 +0000", price: 71054.14439841534),
                    PriceData(time: "2024-06-06 01:04:53 +0000", price: 70990.2501658845),
                    PriceData(time: "2024-06-06 02:07:48 +0000", price: 71111.7771693848),
                    PriceData(time: "2024-06-06 03:03:50 +0000", price: 71163.70801347587),
                    PriceData(time: "2024-06-06 04:04:16 +0000", price: 71053.80230635182),
                    PriceData(time: "2024-06-06 05:07:17 +0000", price: 71066.23543064836),
                    PriceData(time: "2024-06-06 06:01:25 +0000", price: 70921.91695573041),
                    PriceData(time: "2024-06-06 07:07:46 +0000", price: 70891.01993148876),
                    PriceData(time: "2024-06-06 08:08:01 +0000", price: 70989.56581977903),
                    PriceData(time: "2024-06-06 09:04:37 +0000", price: 70907.02219682894),
                    PriceData(time: "2024-06-06 10:06:18 +0000", price: 70952.67189764655),
                    PriceData(time: "2024-06-06 11:00:05 +0000", price: 70958.65300241375),
                    PriceData(time: "2024-06-06 12:02:46 +0000", price: 71085.53126834088),
                    PriceData(time: "2024-06-06 13:01:11 +0000", price: 71173.32805060249),
                    PriceData(time: "2024-06-06 14:02:22 +0000", price: 71207.59435524222),
                    PriceData(time: "2024-06-06 15:04:16 +0000", price: 71469.15438887932),
                    PriceData(time: "2024-06-06 16:02:27 +0000", price: 71238.06260323075),
                    PriceData(time: "2024-06-06 17:07:41 +0000", price: 70768.22344988026),
                    PriceData(time: "2024-06-06 18:07:32 +0000", price: 71138.39580214774),
                    PriceData(time: "2024-06-06 19:00:55 +0000", price: 71069.18929010618),
                    PriceData(time: "2024-06-06 20:02:23 +0000", price: 70429.80683094825),
                    PriceData(time: "2024-06-06 21:08:48 +0000", price: 70730.16396597322),
                    PriceData(time: "2024-06-06 22:04:48 +0000", price: 70704.28903677444),
                    PriceData(time: "2024-06-06 23:01:55 +0000", price: 70897.66575927468),
                    PriceData(time: "2024-06-07 00:05:07 +0000", price: 70773.74598776827),
                    PriceData(time: "2024-06-07 01:03:09 +0000", price: 70858.3516640106),
                    PriceData(time: "2024-06-07 02:00:15 +0000", price: 70863.98433867987),
                    PriceData(time: "2024-06-07 03:06:26 +0000", price: 70823.64754475745),
                    PriceData(time: "2024-06-07 04:08:06 +0000", price: 71094.45975791331),
                    PriceData(time: "2024-06-07 05:05:56 +0000", price: 71218.7556793813),
                    PriceData(time: "2024-06-07 06:01:00 +0000", price: 71336.03392792157),
                    PriceData(time: "2024-06-07 07:00:25 +0000", price: 71280.68092471165),
                    PriceData(time: "2024-06-07 08:02:45 +0000", price: 71095.85098124442),
                    PriceData(time: "2024-06-07 09:00:57 +0000", price: 71080.68182932476),
                    PriceData(time: "2024-06-07 10:06:27 +0000", price: 71273.51614831026),
                    PriceData(time: "2024-06-07 11:03:24 +0000", price: 71327.90048172572),
                    PriceData(time: "2024-06-07 12:05:06 +0000", price: 71643.88933000261),
                    PriceData(time: "2024-06-07 13:06:42 +0000", price: 71186.33669913492),
                    PriceData(time: "2024-06-07 14:08:29 +0000", price: 71355.1403021001),
                    PriceData(time: "2024-06-07 15:07:34 +0000", price: 71341.85799237363),
                    PriceData(time: "2024-06-07 16:07:14 +0000", price: 70950.07816989005),
                    PriceData(time: "2024-06-07 17:03:09 +0000", price: 70768.04687954747),
                    PriceData(time: "2024-06-07 18:03:14 +0000", price: 69678.62142097896),
                    PriceData(time: "2024-06-07 19:04:24 +0000", price: 69123.85740127321),
                    PriceData(time: "2024-06-07 20:07:53 +0000", price: 69096.92925087264),
                    PriceData(time: "2024-06-07 21:07:51 +0000", price: 69228.75408533507),
                    PriceData(time: "2024-06-07 22:03:53 +0000", price: 69218.12095730139),
                    PriceData(time: "2024-06-07 23:01:43 +0000", price: 69461.03394002216),
                    PriceData(time: "2024-06-08 00:05:40 +0000", price: 69260.21173528439),
                    PriceData(time: "2024-06-08 01:01:55 +0000", price: 69382.28142333424),
                    PriceData(time: "2024-06-08 02:04:38 +0000", price: 69425.41471694803),
                    PriceData(time: "2024-06-08 03:07:33 +0000", price: 69409.18581526849),
                    PriceData(time: "2024-06-08 04:01:40 +0000", price: 69392.79120773365),
                    PriceData(time: "2024-06-08 05:02:43 +0000", price: 69308.10284340921),
                    PriceData(time: "2024-06-08 06:04:43 +0000", price: 69288.12202319676),
                    PriceData(time: "2024-06-08 07:03:23 +0000", price: 69308.1573604734),
                    PriceData(time: "2024-06-08 08:05:08 +0000", price: 69503.48114691078),
                    PriceData(time: "2024-06-08 09:08:16 +0000", price: 69391.17587185616),
                    PriceData(time: "2024-06-08 10:02:58 +0000", price: 69422.0549280154),
                    PriceData(time: "2024-06-08 11:05:32 +0000", price: 69432.25588125558),
                    PriceData(time: "2024-06-08 12:07:38 +0000", price: 69258.72930891113),
                    PriceData(time: "2024-06-08 13:00:08 +0000", price: 69337.60341855812),
                    PriceData(time: "2024-06-08 14:05:16 +0000", price: 69410.6900283224),
                    PriceData(time: "2024-06-08 15:03:55 +0000", price: 69443.1469916804),
                    PriceData(time: "2024-06-08 16:04:09 +0000", price: 69405.63763463982),
                    PriceData(time: "2024-06-08 17:07:54 +0000", price: 69361.46134430173),
                    PriceData(time: "2024-06-08 18:02:31 +0000", price: 69439.96089497658),
                    PriceData(time: "2024-06-08 19:09:28 +0000", price: 69487.75689863384),
                    PriceData(time: "2024-06-08 20:07:12 +0000", price: 69449.81437968381),
                    PriceData(time: "2024-06-08 21:00:38 +0000", price: 69359.75273517056),
                    PriceData(time: "2024-06-08 22:07:06 +0000", price: 69396.27529521167),
                    PriceData(time: "2024-06-08 23:06:45 +0000", price: 69311.00170202478),
                    PriceData(time: "2024-06-09 00:03:33 +0000", price: 69305.38413230315),
                    PriceData(time: "2024-06-09 01:00:27 +0000", price: 69271.82967363774),
                    PriceData(time: "2024-06-09 02:06:56 +0000", price: 69294.7352566043),
                    PriceData(time: "2024-06-09 03:07:23 +0000", price: 69189.27484588115),
                    PriceData(time: "2024-06-09 04:05:57 +0000", price: 69255.12336023682),
                    PriceData(time: "2024-06-09 05:08:07 +0000", price: 69268.84907656063),
                    PriceData(time: "2024-06-09 06:02:30 +0000", price: 69301.42826402026),
                    PriceData(time: "2024-06-09 07:08:09 +0000", price: 69402.31338469898),
                    PriceData(time: "2024-06-09 08:04:36 +0000", price: 69288.40380070929),
                    PriceData(time: "2024-06-09 09:03:56 +0000", price: 69341.41547524066)]
    )
}
