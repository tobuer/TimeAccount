//
//  empty.swift
//  TimeAccount
//
//  Created by tobuer on 2017/1/14.
//  Copyright © 2017年 tobuer. All rights reserved.
//

//import UIKit
//
//class empty: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    @IBAction func back(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}


import UIKit
import Charts

class empty: UIViewController , ChartViewDelegate{
    
    //@IBOutlet var barChartView: BarChartView!
    
    @IBOutlet weak var barChartView: BarChartView!
    //@IBOutlet weak var barChartView: UIView!
    //var months: [String]!
    var db:SQLiteDB!
    
    func setChart(values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<values.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i]);
            dataEntries.append(dataEntry)
        }
    
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "每日净消费金额")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        barChartView.chartDescription?.text = "月消费走势"
        //chartDataSet.colors = ChartColorTemplates.colorful()
        barChartView.xAxis.labelPosition = .bottom
        //barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = SQLiteDB.sharedInstance
        barChartView.delegate = self
        
        let date = Calendar(identifier: .gregorian)
        var comps : DateComponents = DateComponents()
        comps = date.dateComponents([.year,.month,.day,.hour,.minute,.second], from: Date())
        let year = comps.year!
        let month = comps.month!
        let day = comps.day!
        
        barChartView.chartDescription?.text="\(year)年\(month)月消费走势"
        var unitsSold:[Double] = []
        //unitsSold = select()
        var sql: String
        for i in 1...day{
            if month < 10 {
                if i < 10 {
                    sql = "select * from Items where time like \"\(year)-0\(month)-0\(i)%\""
                }
                else{
                    sql = "select * from Items where time like \"\(year)-0\(month)-\(i)%\""
                }
            }
            else{
                if i < 10 {
                    sql = "select * from Items where time like \"\(year)-\(month)-0\(i)%\""
                }
                else{
                    sql = "select * from Items where time like \"\(year)-\(month)-\(i)%\""
                }
            }
            //print(sql)
            var r: [[String: Any]] = []
            //print(r)
            var n: Double = 0.0
            r = db.query(sql: sql)
            for j in 0 ..< r.count{
                if r[j]["inOrOut"] as? Int == 0{
                    n += (r[j]["number"] as? Double)!
                }
                else{
                    n -= (r[j]["number"] as? Double)!
                }
            }
            unitsSold.append(n)
            //print("\(n): \(i) ")
            
        }
        
        //将此处的数据替换为数据库内的数据，只提取当月数据
        
        setChart(values: unitsSold)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SaveChart(_ sender: UIBarButtonItem) {
        // barChartView.save(to: /*此处填写保存路径*/, format: <#T##ChartViewBase.ImageFormat#>, compressionQuality: <#T##Double#>)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
}
