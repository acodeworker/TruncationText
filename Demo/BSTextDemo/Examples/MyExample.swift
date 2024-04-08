//
//  MyExample.swift
//  BSTextDemo
//
//  Created by BruceLiu on 2020/6/20.
//  Copyright © 2020 GeekBruce. All rights reserved.
//

import UIKit
import BSText
import SwiftyMarkdown
import YYWebImage

private var kExampleCellReuseId = "kExampleCellReuseId"


public class TableViewCell:UITableViewCell{
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.addSubview(bgView)

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var obj:StringObject?{
    didSet{
      if let obj = obj{
        self.bgView.frame = CGRect(origin: CGPointMake(32, 32), size: obj.size)
        self.bgView.obj = obj
      }
    }
  }
  
  lazy var bgView:SwiftMarkDownView = {
    let bgView = SwiftMarkDownView()
    bgView.backgroundColor = UIColor.white
    return bgView
  }()
  
}

class MyExample: UITableViewController {

    private var titles: [String] = []
    
    var datas:[StringObject] = []
  
    override func viewDidLoad() {
      super.viewDidLoad()
      
      tableView.tableFooterView = UIView()
      tableView.register(TableViewCell.self, forCellReuseIdentifier: kExampleCellReuseId)
      
      let concurrentQueue = DispatchQueue(label: "com.example.concurrent", attributes: .concurrent)
      concurrentQueue.async {
        self.titles = [
          "1. First item\n2. Second item\n3. Third item\n4. Fourth item",
          "| 参数       | 智能半球摄像机 T1 | 智能枪型摄像机 T1 |\n|------------|-------------------|-------------------|\n| 产品尺寸   | 105*105*88mm      | 196*99*95mm       |\n| 电源输入   | 12V⎓1A, 9W MAX    | 12V⎓1A, 7W MAX; PoE(802.3af, 44V-57V),300mA MAX, 13W |\n| 分辨率     | 1920*1080p        | 2560*1440         |\n| 焦距       | 2.8mm             | 4mm               |\n| 视频编码   | H.265             | H.265             |\n| 工作温度   | -10℃~45℃         | -30℃~60℃         |\n| 工作湿度   | 0～95% RH，无冷凝 | 0～95% RH，无冷凝 |\n| 执行标准   | Q/QLML033         | Q/QLML033         |\n| 净重       | 263g              | 360g              |\n| 包装尺寸   |147*145*173mm      |232*110*102mm      |\n\n智能半球摄像机 T1的官方售价为xxx元，具体价格和购买时间及渠道有关，想了解更多详情，请前往官方网站或天猫旗舰店进行查询。",
            "![这是图片](https://images.pexels.com/photos/19294343/pexels-photo-19294343.jpeg)",
            "I just love **bold text**.",
            "I think I'll use it to format all of my documents from now on.I think I'll use it to format all of my documents from now on.I think I'll use it to format all of my documents from now on.",
            "### Heading level 3 \nThis is the first line.And this is the second line.",
          "I just love **bold text**.",
          "I think I'll use it to format all of my documents from now on.I think I'll use it to format all of my documents from now on.I think I'll use it to format all of my documents from now on.",
          "### Heading level 3 \nThis is the first line.And this is the second line.",
          "| 参数       | 智能半球摄像机 T1 | 智能枪型摄像机 T1 |\n|------------|-------------------|-------------------|\n| 产品尺寸   | 105*105*88mm      | 196*99*95mm       |\n| 电源输入   | 12V⎓1A, 9W MAX    | 12V⎓1A, 7W MAX; PoE(802.3af, 44V-57V),300mA MAX, 13W |\n| 分辨率     | 1920*1080p        | 2560*1440         |\n| 焦距       | 2.8mm             | 4mm               |\n| 视频编码   | H.265             | H.265             |\n| 工作温度   | -10℃~45℃         | -30℃~60℃         |\n| 工作湿度   | 0～95% RH，无冷凝 | 0～95% RH，无冷凝 |\n| 执行标准   | Q/QLML033         | Q/QLML033         |\n| 净重       | 263g              | 360g              |\n| 包装尺寸   |147*145*173mm      |232*110*102mm      |\n\n智能半球摄像机 T1的官方售价为xxx元，具体价格和购买时间及渠道有关，想了解更多详情，请前往官方网站或天猫旗舰店进行查询。",
            "![这是图片](https://images.pexels.com/photos/19294343/pexels-photo-19294343.jpeg)",
          "1. First item\n2. Second item\n3. Third item\n4. Fourth item",
          "| 参数       | 智能半球摄像机 T1 | 智能枪型摄像机 T1 |\n|------------|-------------------|-------------------|\n| 产品尺寸   | 105*105*88mm      | 196*99*95mm       |\n| 电源输入   | 12V⎓1A, 9W MAX    | 12V⎓1A, 7W MAX; PoE(802.3af, 44V-57V),300mA MAX, 13W |\n| 分辨率     | 1920*1080p        | 2560*1440         |\n| 焦距       | 2.8mm             | 4mm               |\n| 视频编码   | H.265             | H.265             |\n| 工作温度   | -10℃~45℃         | -30℃~60℃         |\n| 工作湿度   | 0～95% RH，无冷凝 | 0～95% RH，无冷凝 |\n| 执行标准   | Q/QLML033         | Q/QLML033         |\n| 净重       | 263g              | 360g              |\n| 包装尺寸   |147*145*173mm      |232*110*102mm      |\n\n智能半球摄像机 T1的官方售价为xxx元，具体价格和购买时间及渠道有关，想了解更多详情，请前往官方网站或天猫旗舰店进行查询。",
            "![这是图片](https://images.pexels.com/photos/19294343/pexels-photo-19294343.jpeg)",
            "I just love **bold text**.",
            "I think I'll use it to format all of my documents from now on.I think I'll use it to format all of my documents from now on.I think I'll use it to format all of my documents from now on.",
            "### Heading level 3 \nThis is the first line.And this is the second line.",
          "I just love **bold text**.",
          "I think I'll use it to format all of my documents from now on.I think I'll use it to format all of my documents from now on.I think I'll use it to format all of my documents from now on.",
          "### Heading level 3 \nThis is the first line.And this is the second line.",
          "| 参数       | 智能半球摄像机 T1 | 智能枪型摄像机 T1 |\n|------------|-------------------|-------------------|\n| 产品尺寸   | 105*105*88mm      | 196*99*95mm       |\n| 电源输入   | 12V⎓1A, 9W MAX    | 12V⎓1A, 7W MAX; PoE(802.3af, 44V-57V),300mA MAX, 13W |\n| 分辨率     | 1920*1080p        | 2560*1440         |\n| 焦距       | 2.8mm             | 4mm               |\n| 视频编码   | H.265             | H.265             |\n| 工作温度   | -10℃~45℃         | -30℃~60℃         |\n| 工作湿度   | 0～95% RH，无冷凝 | 0～95% RH，无冷凝 |\n| 执行标准   | Q/QLML033         | Q/QLML033         |\n| 净重       | 263g              | 360g              |\n| 包装尺寸   |147*145*173mm      |232*110*102mm      |\n\n智能半球摄像机 T1的官方售价为xxx元，具体价格和购买时间及渠道有关，想了解更多详情，请前往官方网站或天猫旗舰店进行查询。",
            "![这是图片](https://images.pexels.com/photos/19294343/pexels-photo-19294343.jpeg)"]
        for text in self.titles {
          let md = SwiftyMarkdown(string: text)
          md.body.fontSize = 16
          md.body.fontName = "PingFangSC-Regular"
          if #available(iOS 13.0, *) {
              md.strikethrough.color = .tertiaryLabel
          } else {
              md.strikethrough.color = .lightGray
          }
          let obj:StringObject = md.generateCTFrame(from:text)
          self.datas.append(obj)
        }
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
      
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kExampleCellReuseId),let cell = cell as? TableViewCell else {
            fatalError("have not register cell class")
        }
        cell.obj = self.datas[indexPath.row]
        return cell
    }
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let obj = self.datas[indexPath.row]
    return obj.size.height + 64
  }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
