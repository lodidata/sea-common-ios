//
//  WLChartView.swift
//  DNYTY
//
//  Created by wulin on 2022/6/28.
//

import UIKit
//import AAInfographics
import Charts

class WLChartView: UIView {

    var dateArr = [String]()
    private var betAmountArr = [Double]()
    private var bkgeArr = [Double]()
    private lazy var formatter: DateFormatter = {
        let dateFormmater = DateFormatter.init()
        dateFormmater.dateFormat = "yyyy/MM/dd"
        return dateFormmater
    }()
    lazy var dateBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        let date = formatter.string(from: Date())
        btn.setTitleColor(UIColor.init(hexString: "30333A"), for: .normal)
        btn.set(image: RImage.cannder_icon(), title: date, titlePosition: .left, additionalSpacing: -15, state: .normal)
        btn.contentEdgeInsets = UIEdgeInsets.init(top: 9, left: 15, bottom: 9, right: 25)
        btn.titleLabel?.font = kSystemFont(14)
        btn.layer.cornerRadius = 16
        btn.layer.masksToBounds = true
        btn.layer.borderColor = UIColor.init(hexString: "DDDEE8")?.cgColor
        btn.layer.borderWidth = 1
        btn.backgroundColor = .white
        return btn
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "72788B")
        lab.font = kSystemFont(12)
        lab.text = "agency27".wlLocalized
        return lab
    }()

    private lazy var flowWaterView: WLLabView = {
        let aView = WLLabView()
        aView.colorView.backgroundColor = UIColor.init(hexString: "8849F1")
        aView.titleLab.text = "agency28".wlLocalized
        return aView
    }()
    private lazy var fenhongView: WLLabView = {
        let aView = WLLabView()
        aView.colorView.backgroundColor = UIColor.init(hexString: "FF9B00")
        aView.titleLab.text = "agency29".wlLocalized
        return aView
    }()
    lazy var chartView: CombinedChartView = {
        let chartView = CombinedChartView()
        chartView.backgroundColor = .white
        chartView.chartDescription?.enabled = false
        chartView.drawBarShadowEnabled = false
        chartView.highlightFullBarEnabled = false
        chartView.drawOrder = [DrawOrder.bar.rawValue, DrawOrder.line.rawValue]
        /* 设置图表的属性 */
        chartView.noDataText = "game1".wlLocalized; // 无数据时显示的文字
        chartView.legend.enabled = false; // 隐藏图例
        chartView.pinchZoomEnabled = false; // 触控放大
        chartView.doubleTapToZoomEnabled = false; // 双击放大
        chartView.scaleXEnabled = false; // X 轴缩放
        chartView.scaleYEnabled = false; // Y 轴缩放
        chartView.scaleXEnabled = false; // 缩放
        chartView.scaleYEnabled = false
        chartView.highlightPerTapEnabled = true; // 单击高亮
        chartView.highlightPerDragEnabled = false; // 拖拽高亮
        chartView.dragEnabled = false; // 拖拽图表
        chartView.dragDecelerationEnabled = false; // 拖拽后是否有惯性效果
        chartView.dragDecelerationFrictionCoef = 0.5; // 拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显

        /* 设置 X 轴显示的值的属性 */
        let xAxis = chartView.xAxis;
        xAxis.labelPosition = .bottom // 显示位置
        xAxis.drawGridLinesEnabled = false; // 网格绘制
        xAxis.axisLineColor = UIColor.lightGray; // X 轴颜色
        xAxis.axisLineWidth = 0.5 // X 轴线宽
        xAxis.labelFont = kSystemFont(10) // 字号
        xAxis.labelTextColor = .lightGray // 颜色
        xAxis.labelRotationAngle = 0; // 文字倾斜角度
        xAxis.spaceMin = 0.5
        xAxis.spaceMax = 0.5
        xAxis.valueFormatter = self

        /* 设置左侧 Y 轴显示的值的属性 */
        let leftAxis = chartView.leftAxis;
        leftAxis.labelPosition = .outsideChart // 显示位置
        leftAxis.drawGridLinesEnabled = true; // 网格绘制
        leftAxis.gridColor = .lightGray; // 网格颜色
        leftAxis.gridLineWidth = 0.5; // 网格线宽
        leftAxis.drawAxisLineEnabled = false; // 是否显示轴线
        leftAxis.labelFont = kSystemFont(10) // 字号
        leftAxis.labelTextColor = .lightGray // 颜色
        leftAxis.axisMinimum = 0; // 最小值
//        leftAxis.axisMaximum = 500; // 最大值（不设置会根据数据自动设置）
//        [leftAxis setLabelCount:6 force:YES]; // Y 轴段数（会自动分成对应段数）
        leftAxis.labelCount = 6
        leftAxis.forceLabelsEnabled = true
//        leftAxis.valueFormatter = self
        
        /* 设置右侧 Y 轴显示的值的属性 */
        let rightAxis = chartView.rightAxis;
        rightAxis.labelPosition = .outsideChart // 显示位置
        rightAxis.drawGridLinesEnabled = false; // 网格绘制
        rightAxis.drawAxisLineEnabled = false; // 是否显示轴线
        rightAxis.labelFont = kSystemFont(10) // 字号
        rightAxis.labelTextColor = .lightGray // 颜色
        rightAxis.axisMinimum = 0; // 最小值
//        rightAxis.axisMaximum = 100; // 最大值（不设置会根据数据自动设置）
//        [rightAxis setLabelCount:6 force:YES]; // Y 轴段数（会自动分成对应段数）
        rightAxis.labelCount = 6
        rightAxis.forceLabelsEnabled = true
//        rightAxis.valueFormatter = self
            
        chartView.delegate = self
        
        chartView.drawMarkers = true
        return chartView
    }()
    //总流水柱状图
//    lazy var waterAAChartView: AAChartView = {
//        let aView = AAChartView()
//        aView.layer.cornerRadius = 5
//        aView.layer.masksToBounds = true
//        return aView
//    }()
    //总分红折图
//    lazy var profitAAChartView: AAChartView = {
//        let aView = AAChartView()
//        aView.layer.cornerRadius = 5
//        aView.layer.masksToBounds = true
//        aView.backgroundColor = .clear
//        return aView
//    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(dateBtn)
        addSubview(titleLab)
        addSubview(flowWaterView)
        addSubview(fenhongView)
        addSubview(chartView)
//        addSubview(waterAAChartView)
//        addSubview(profitAAChartView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setChartModel(dates: [String], betAmounts: [Double], bkges: [Double]) {
        /*
        // 初始化图表模型
        let waterChartModel = AAChartModel()
            .inverted(false)//是否翻转图形
            //.yAxisTitle("摄氏度")// Y 轴标题
            .legendEnabled(false)//是否启用图表的图例(图表底部的可点击的小圆点)
            //.tooltipValueSuffix("摄氏度")//浮动提示框单位后缀
            .categories(dates)
            .colorsTheme(["#8849F1"])//主题颜色数组
            .margin(top: 30, right: 20, bottom: 40, left: 60)
            .series([
                AASeriesElement()
                    .name("总流水")
                    .type(.column)
                    .borderWidth(10)
                    .data(betAmounts)
                    .toDic()!
                ])
        // 初始化图表模型
        let profitChartModel = AAChartModel()
            .inverted(false)//是否翻转图形
            //.yAxisTitle("摄氏度")// Y 轴标题
            .legendEnabled(false)//是否启用图表的图例(图表底部的可点击的小圆点)
            //.tooltipValueSuffix("摄氏度")//浮动提示框单位后缀
            .categories(dates)
            .colorsTheme(["#FF9B00"])//主题颜色数组
            .margin(top: 30, right: 20, bottom: 40, left: 60)
            .series([
                AASeriesElement()
                    .name("总分红")
                    .type(.line)
                    .data(bkges)
                    .toDic()!
                ])
        let aaOptions = AAOptionsConstructor.configureChartOptions(profitChartModel)
        aaOptions.yAxis?.opposite(true)
        profitAAChartView.aa_drawChartWithChartOptions(aaOptions)
        // 图表视图对象调用图表模型对象,绘制最终图形
        waterAAChartView.aa_drawChartWithChartModel(waterChartModel)
         */
        dateArr = dates
        self.betAmountArr = betAmounts
        self.bkgeArr = bkges
        let data = CombinedChartData()
        data.lineData = generateLineData(bkges: bkges)
        data.barData = generateBarData(betAmounts: betAmounts)
        
//        chartView.xAxis.axisMaximum = data.xMax + 0.25
        chartView.data = data
    }
    
    func generateLineData(bkges: [Double]) -> LineChartData {
        var entries = [ChartDataEntry]()
        for i in 0..<bkges.count {
            let entry = ChartDataEntry.init(x: Double(i), y: bkges[i])
            entries.append(entry)
        }
        
        let dataSet = LineChartDataSet.init(entries: entries)
        dataSet.colors = [RGB(255, 155, 0)] // 线的颜色
        dataSet.lineWidth = 1; // 线宽
        dataSet.circleRadius = 2.5; // 圆点外圆半径
        dataSet.circleHoleRadius = 1.5; // 圆点内圆半径
        dataSet.circleColors = [RGB(255, 155, 0, 0.3)]; // 圆点外圆颜色
        dataSet.circleHoleColor = RGB(255, 155, 0) // 圆点内圆颜色
        dataSet.axisDependency = .right; // 根据右边数据显示
        dataSet.drawValuesEnabled = false; // 是否显示数据
        dataSet.mode = .linear; // 折线图类型
        dataSet.drawFilledEnabled = false; // 是否显示折线图阴影
        dataSet.highlightEnabled = true
        dataSet.highlightColor = RGB(255, 155, 0)
//        NSArray *shadowColors = @[(id)[[UIColor orangeColor] colorWithAlphaComponent:0].CGColor, (id)[[UIColor orangeColor] colorWithAlphaComponent:0.7].CGColor];
//        CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)shadowColors, nil);
//        dataSet.fill = [ChartFill fillWithLinearGradient:gradient angle:90.0f]; // 阴影渐变效果
//        dataSet.fillAlpha = 1.0f; // 阴影透明度
        let lineData = LineChartData.init(dataSet: dataSet)
        
        return lineData;
        
    }
    func generateBarData(betAmounts: [Double]) -> BarChartData {
        
        var barEntries = [BarChartDataEntry]()
        for i in 0..<betAmounts.count {
            let barEntry = BarChartDataEntry.init(x: Double(i), y: betAmounts[i])
            barEntries.append(barEntry)
        }
        
        let dataSet = BarChartDataSet.init(entries: barEntries)
        dataSet.colors = [RGB(136, 73, 241)]
        dataSet.axisDependency = .left
        dataSet.drawValuesEnabled = false
//        dataSet.barBorderWidth = 15
//        dataSet.barBorderColor = .white
        dataSet.highlightEnabled = true
        dataSet.highlightColor = RGB(136, 73, 241)
        let data = BarChartData.init(dataSet: dataSet)
        data.barWidth = 0.2
        return data
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dateBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(0)
//            make.height.equalTo(32)
//            make.width.equalTo(120)
        }
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(dateBtn.snp.right).offset(5)
            make.centerY.equalTo(dateBtn)
        }
        flowWaterView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(15)
            make.width.equalTo(75)
        }
        fenhongView.snp.makeConstraints { make in
            make.top.equalTo(flowWaterView.snp.bottom).offset(5)
            make.right.width.height.equalTo(flowWaterView)
        }
        chartView.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(fenhongView.snp.bottom).offset(13)
//            make.height.equalTo(chartView.snp.width).multipliedBy(256.0/343)
            make.bottom.equalToSuperview()
        }
//        profitAAChartView.snp.makeConstraints { make in
//            make.left.right.top.bottom.equalTo(waterAAChartView)
//        }
    }
    
    
    func showMarkerView(betAmount: Double, bkge: Double) {
//        let marker = WLMarkerView.init()
//        marker.chartView = chartView
//        marker.minimumContentSizeCategory = .large
//        marker.waterLab.text = "\(betAmount)"
//        marker.profitsLab.text = "\(bkge)"
        
//        chartView.marker = marker
        
        
        
        
         //设置气泡
        let marker = WLBalloonMarker(color: RGB(0, 0, 0, 0.5),
                                        font: .systemFont(ofSize: 12),
                                        textColor: .white,
                                        insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
         marker.chartView = chartView
         marker.minimumSize = CGSize(width: 80, height: 50)
        marker.betAmount = betAmount
        marker.bkge = bkge
         chartView.marker = marker
         
         
    }
    
    
}
extension WLChartView: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateArr[Int(value) % dateArr.count]
    }
}
extension WLChartView: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        print("选中了一个数据")
        //显示该点的MarkerView标签
        let index = Int(entry.x)
        self.showMarkerView(betAmount: betAmountArr[index], bkge: bkgeArr[index])
    }
}
class WLLabView: UIView {
    
    lazy var colorView: UIView = {
        let aView = UIView()
        return aView
    }()
    lazy var titleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.init(hexString: "30333A")
        lab.font = kSystemFont(12)
        lab.numberOfLines = 0
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(colorView)
        addSubview(titleLab)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(10)
        }
        titleLab.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalTo(colorView.snp.right).offset(3)
        }
    }
    
}
