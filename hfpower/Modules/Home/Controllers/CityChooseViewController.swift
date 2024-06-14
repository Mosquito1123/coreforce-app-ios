//
//  CityChooseViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/6.
//

import UIKit

class CityChooseViewController: UIViewController {
    
    // MARK: - Accessor
    var citys = [[String:Any]]()
    //存放相同首字母的城市数组
    var cityGroups = [String:[[String:Any]]]()
    //存放所有地址首字母
    var groupTitles = [String]()
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(CityChooseViewCell.self, forCellReuseIdentifier: CityChooseViewCell.cellIdentifier())
        self.view.addSubview(tableView)
        return tableView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupNavbar()
        setupSubviews()
        setupLayout()
        addCityData()
    }
    func addCityData() {
        if let filePath = Bundle.main.path(forResource: "area", ofType: "json"),
           let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
           let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] {
            let array:[[[String : Any]]] =  jsonObject.compactMap{$0["children"] as? [[String : Any]]}
            self.citys = array.flatMap { dictArray in
                return dictArray
            }
        } else {
            print("Error parsing JSON")
        }
        //遍历城市数组
        for city in citys {
           //将城市名字转化成拼音
            let cityName = city["name"] as? String
            var cityMutableString = NSMutableString(string: cityName ?? "");
                        
            cityMutableString = self.transformMandarinToLatin(cityMutableString: cityMutableString)
            
            //拿到拼音首字母作为key,并转化成大写
            let firstLetter = cityMutableString.substring(to: 1).uppercased()
            //NSLog("firstLetter = %@", firstLetter);
            //判断:检查是否存在以firstLetter为数组对应的分组存在,如果有就添加到对应的分组中,否则就新建一个以firstLetter为可以的数组
            if var value = cityGroups[firstLetter] {
                //存在,就添加
                value.append(city)
                cityGroups[firstLetter] = value
            }
            else
            {
                cityGroups[firstLetter] = [city]
            }

        }
        //拿到所有的key将他排序,作为每组的标题
        groupTitles = cityGroups.keys.sorted()
        
        //自定义表格索引
        let items = self.items()
        let configuration = SectionIndexViewConfiguration.init()
        configuration.adjustedContentInset = 20 + 44
        self.tableView.sectionIndexView(items: items, configuration: configuration)
       
    }
    private func items() -> [SectionIndexViewItemView] {
        var items = [SectionIndexViewItemView]()
        for title in self.groupTitles {
            let item = SectionIndexViewItemView.init()
            item.title = title
            item.indicator = SectionIndexViewItemIndicator.init(title: title)
            items.append(item)
        }
        return items
    }
}

// MARK: - Setup
private extension CityChooseViewController {
    
    private func setupNavbar() {
        self.title = "城市选择"
        let item = UIBarButtonItem(barButtonSystemItem: .close, target: self, action:  #selector(closeButton(_:)))
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.leftBarButtonItem = item
    }
   
    private func setupSubviews() {
        self.view.addSubview(self.tableView)
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension CityChooseViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cityGroups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let firstLetter = groupTitles[section]
        return cityGroups[firstLetter]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellCity = tableView.dequeueReusableCell(withIdentifier: CityChooseViewCell.cellIdentifier(), for: indexPath)
        let firstLetter = groupTitles[indexPath.section]
        let citysInAGroup = cityGroups[firstLetter] ?? [[String:Any]]()
        cellCity.textLabel?.text = citysInAGroup[indexPath.row]["name"] as? String
        return cellCity
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        let firstLetter = groupTitles[indexPath.section]
        let citysInAGroup = cityGroups[firstLetter] ?? [[String:Any]]()
        CityCodeManager.shared.cityCode = citysInAGroup[indexPath.row]["code"] as? String
        CityCodeManager.shared.cityName = citysInAGroup[indexPath.row]["name"] as? String
        self.navigationController?.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        NSLog("title = %@", groupTitles[section])
        return groupTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    /// 多音字处理
    /// - Parameter string: 出入的字符串
    /// - Returns: 返回去的字符串
    func transformMandarinToLatin(cityMutableString : NSMutableString) -> NSMutableString {
        
        /*复制出一个可变的对象*/
        let preString :NSMutableString = NSMutableString(string: cityMutableString)
        
        //转换成成带音 调的拼音
        CFStringTransform(preString, nil, kCFStringTransformToLatin, false)
        //去掉音调
        CFStringTransform(preString, nil, kCFStringTransformStripDiacritics, false)        
        
        if cityMutableString.substring(to: 1).compare("长") == ComparisonResult.orderedSame{
            preString.replaceCharacters(in: NSRange(location: 0,length: 5), with: "chang")
        }
        if cityMutableString.substring(to: 1).compare("沈") == ComparisonResult.orderedSame
        {
            preString.replaceCharacters(in: NSRange(location: 0,length: 4), with: "shen")
        }
        if cityMutableString.substring(to: 1).compare("厦") == ComparisonResult.orderedSame
        {
            preString.replaceCharacters(in: NSRange(location: 0,length: 4), with: "xia")
        }
        if cityMutableString.substring(to: 1).compare("地") == ComparisonResult.orderedSame
        {
            preString.replaceCharacters(in: NSRange(location: 0,length: 3), with: "di")
        }
        if cityMutableString.substring(to: 1).compare("重") == ComparisonResult.orderedSame
        {
            preString.replaceCharacters(in: NSRange(location: 0,length: 5), with: "chong")
        }
        
        return preString
    }
    
}

// MARK: - Request
private extension CityChooseViewController {
    
}

// MARK: - Action
@objc private extension CityChooseViewController {
    @objc func closeButton(_ sender:UIBarButtonItem){
        self.navigationController?.dismiss(animated: true)
    }
}

// MARK: - Private
private extension CityChooseViewController {
    
}
