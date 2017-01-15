//
//  addItemViewController.swift
//  TimeAccount
//
//  Created by tobuer on 2017/1/14.
//  Copyright © 2017年 tobuer. All rights reserved.
//

import UIKit

class addItemViewController: UIViewController , UIGestureRecognizerDelegate{
    var db:SQLiteDB!
    let dateFormatter:DateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db = SQLiteDB.sharedInstance//获取数据库实例
        //_ = db.execute(sql: "drop table if exists Items")//如果表还不存在则创建表（其中uid为自增主键）
        
        let result = db.execute(sql: "create table if not exists Items(inOrOut char(1) not null,kind varchar(20),number double not null,time varchar(20) not null)")
        print(result)
        //如果有数据则加载
        initUser()
        
        IO_label_bool = true
        
        image1.image = image_in1
        image2.image = image_in2
        image3.image = image_in3
        image4.image = image_in4
        image5.image = image_in5
        image6.image = image_in6
        image7.image = image_in7
        image8.image = image_in8
        image9.image = image_in9
        
        image_label1.text = "普通"
        image_label2.text = "工资"
        image_label3.text = "红包"
        image_label4.text = "股票"
        image_label5.text = "礼物"
        image_label6.text = "奖金"
        image_label7.text = "报销"
        image_label8.text = "兼职"
        image_label9.text = "零花钱"
        
        final_image.image = image_in1
        final_kind.text = "普通"
        choose = 1
        image_no = 1
        
        final_number.layer.borderWidth = 1
        final_number.layer.cornerRadius = 16
        final_number.layer.borderColor = UIColor.gray.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewTap(_ sender: UITapGestureRecognizer){
        final_image.image = image_in3
        final_kind.text = "红包"
    }
    
    @IBOutlet weak var final_image: UIImageView!
    @IBOutlet weak var final_kind: UILabel!
    @IBOutlet weak var final_number: UITextView!
    
    
    var choose:Int = 1
    
    @IBOutlet weak var bar: UINavigationItem!
    
    @IBOutlet weak var IO_label: UIButton!
    var IO_label_bool: Bool = true//true 收入 false 支出
    
    
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    
    @IBOutlet weak var image_label1: UILabel!
    @IBOutlet weak var image_label2: UILabel!
    @IBOutlet weak var image_label3: UILabel!
    @IBOutlet weak var image_label4: UILabel!
    @IBOutlet weak var image_label5: UILabel!
    @IBOutlet weak var image_label6: UILabel!
    @IBOutlet weak var image_label7: UILabel!
    @IBOutlet weak var image_label8: UILabel!
    @IBOutlet weak var image_label9: UILabel!
    
    let image_in1 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/in_icon/common_in", ofType: "png")!)
    let image_in2 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/in_icon/salary", ofType: "png")!)
    let image_in3 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/in_icon/red_bag", ofType: "png")!)
    let image_in4 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/in_icon/stock", ofType: "png")!)
    let image_in5 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/in_icon/gift", ofType: "png")!)
    let image_in6 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/in_icon/jiang_jin", ofType: "png")!)
    let image_in7 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/in_icon/baoxiao", ofType: "png")!)
    let image_in8 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/in_icon/part_time_job", ofType: "png")!)
    let image_in9 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/in_icon/cash", ofType: "png")!)
    
    let image_out1 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/out_icon/common_out", ofType: "png")!)
    let image_out2 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/out_icon/daily", ofType: "png")!)
    let image_out3 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/out_icon/dinner", ofType: "png")!)
    let image_out4 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/out_icon/entertainment", ofType: "png")!)
    let image_out5 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/out_icon/health", ofType: "png")!)
    let image_out6 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/out_icon/house", ofType: "png")!)
    let image_out7 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/out_icon/snack", ofType: "png")!)
    let image_out8 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/out_icon/study", ofType: "png")!)
    let image_out9 = UIImage(contentsOfFile: Bundle.main.path(forResource: "icon/out_icon/traffic", ofType: "png")!)
    
    var image_no: Int = 1
    
    
    @IBAction func change_IO(_ sender: UIButton) {
        if IO_label_bool {
            IO_label.setTitle("支出", for: UIControlState.normal)
            IO_label_bool = false
            IO_label.setTitleColor(UIColor.red, for: UIControlState.normal)
            image1.image = image_out1
            image2.image = image_out2
            image3.image = image_out3
            image4.image = image_out4
            image5.image = image_out5
            image6.image = image_out6
            image7.image = image_out7
            image8.image = image_out8
            image9.image = image_out9
            
            image_label1.text = "普通"
            image_label2.text = "日常用品"
            image_label3.text = "餐饮"
            image_label4.text = "娱乐"
            image_label5.text = "医疗"
            image_label6.text = "房屋"
            image_label7.text = "零食"
            image_label8.text = "学习"
            image_label9.text = "交通"
            
            final_image.image = image_out1
            final_kind.text = "普通"
        }
        else{
            IO_label.setTitle("收入", for: UIControlState.normal)
            IO_label_bool = true
            IO_label.setTitleColor(UIColor.green, for: UIControlState.normal)
            image1.image = image_in1
            image2.image = image_in2
            image3.image = image_in3
            image4.image = image_in4
            image5.image = image_in5
            image6.image = image_in6
            image7.image = image_in7
            image8.image = image_in8
            image9.image = image_in9
            
            image_label1.text = "普通"
            image_label2.text = "工资"
            image_label3.text = "红包"
            image_label4.text = "股票"
            image_label5.text = "礼物"
            image_label6.text = "奖金"
            image_label7.text = "报销"
            image_label8.text = "兼职"
            image_label9.text = "零花钱"
            
            final_image.image = image_in1
            final_kind.text = "普通"
        }
    }
    
    
    @IBAction func choose_image1(_ sender: UITapGestureRecognizer) {
        if IO_label_bool {
            final_image.image = image_in1
            final_kind.text = "普通"
        }
        else{
            final_image.image = image_out1
            final_kind.text = "普通"
        }
        image_no = 1
    }
    
    @IBAction func choose_image2(_ sender: UITapGestureRecognizer) {
        if IO_label_bool {
            final_image.image = image_in2
            final_kind.text = "工资"
        }
        else{
            final_image.image = image_out2
            final_kind.text = "日常用品"
        }
        image_no = 2
    }
    
    @IBAction func choose_image3(_ sender: UITapGestureRecognizer) {
        if IO_label_bool {
            final_image.image = image_in3
            final_kind.text = "红包"
        }
        else{
            final_image.image = image_out3
            final_kind.text = "餐饮"
        }
        image_no = 3
    }
    
    @IBAction func choose_image4(_ sender: UITapGestureRecognizer) {
        if IO_label_bool {
            final_image.image = image_in4
            final_kind.text = "股票"
        }
        else{
            final_image.image = image_out4
            final_kind.text = "娱乐"
        }
        image_no = 4
    }
    
    @IBAction func choose_image5(_ sender: UITapGestureRecognizer) {
        if IO_label_bool {
            final_image.image = image_in5
            final_kind.text = "礼物"
        }
        else{
            final_image.image = image_out5
            final_kind.text = "医疗"
        }
        image_no = 5
    }
    
    @IBAction func choose_image6(_ sender: UITapGestureRecognizer) {
        if IO_label_bool {
            final_image.image = image_in6
            final_kind.text = "奖金"
        }
        else{
            final_image.image = image_out6
            final_kind.text = "房屋"
        }
        image_no = 6
    }
    
    @IBAction func choose_image7(_ sender: UITapGestureRecognizer) {
        if IO_label_bool {
            final_image.image = image_in7
            final_kind.text = "报销"
        }
        else{
            final_image.image = image_out7
            final_kind.text = "零食"
        }
        image_no = 7
    }
    
    @IBAction func choose_image8(_ sender: UITapGestureRecognizer) {
        if IO_label_bool {
            final_image.image = image_in8
            final_kind.text = "兼职"
        }
        else{
            final_image.image = image_out8
            final_kind.text = "学习"
        }
        image_no = 8
    }
    
    @IBAction func choose_image9(_ sender: UITapGestureRecognizer) {
        if IO_label_bool {
            final_image.image = image_in9
            final_kind.text = "零花钱"
        }
        else{
            final_image.image = image_out9
            final_kind.text = "交通"
        }
        image_no = 9
    }
    
    @IBAction func CancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var IO: Int
        if IO_label_bool {
            IO = 0
        }
        else{
            IO = 1
        }
        
        var number = final_number.text!
        
        let kind = final_kind.text!
        if final_number.text == ""{
            number = "0"
        }
        
        let time = time2string(time: Date())
        
        let sql = "insert into Items(inOrOut,kind,number,time,k) values('\(IO)','\(kind)',\(number),\'\(time)\',\(image_no))"
        print("sql: \(sql)")
        let result = db.execute(sql: sql)
        print(result)
        
        //presentedViewController?.viewDidLoad()
        
        self.dismiss(animated: true, completion: nil)
    }

    func initUser() {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
    }
    
    func time2string(time: Date) -> String{
        return dateFormatter.string(from: time)
    }
    
    func string2time(timestr: String) -> Date{
        return dateFormatter.date(from: timestr)!
    }
}
