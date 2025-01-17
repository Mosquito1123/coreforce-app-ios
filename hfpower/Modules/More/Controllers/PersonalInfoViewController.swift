//
//  PersonalInfoViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/9.
//

import UIKit
import ZLPhotoBrowser
class PersonalInfoViewController: BaseTableViewController<PersonalInfoListViewCell,PersonalInfo> {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    func loadData(){
        self.getData(memberUrl, param: [:], isLoading: false) { responseObject in
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any] {
                if let memberData = HFMember.mj_object(withKeyValues: body["member"]){
                    if let headerView = self.tableView.tableHeaderView as? PersonalInfoTableHeaderView{
                        headerView.avatarImageView.setHeaderImage(placeholder: UIImage(named: "setup-head-default"))

                    }
                    self.items = [
                        PersonalInfo(id: 0, title:  "用户姓名",content: memberData.realName,isNext: false),
                        PersonalInfo(id: 1, title: "性别",content: self.gender(from: memberData.idCard),isNext: false),
                        PersonalInfo(id: 2, title: "手机号",content: memberData.phoneNum.maskPhoneNumber(),isNext: false),
                        PersonalInfo(id: 3, title: "实名认证",content: memberData.isAuth == 1 ? "已实名认证":"未实名，前往认证",isEditable: memberData.isAuth != 1, isNext: true),
                       

                      
                    ]

                }

            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }

    }
    func gender(from idNumber: String) -> String? {
        // 判断身份证号长度是否为18位
        guard idNumber.count == 18 else {
            return nil // 无效的身份证号
        }

        // 获取倒数第二位字符
        let index = idNumber.index(idNumber.endIndex, offsetBy: -2)
        let genderDigit = idNumber[index]

        // 判断是否为数字并转换为整数
        if let genderNumber = Int(String(genderDigit)) {
            // 奇数为男性，偶数为女性
            return genderNumber % 2 == 0 ? "女" : "男"
        } else {
            return nil // 无效的性别标识符
        }
    }

    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        if item.title == "实名认证" && item.isEditable == true{
            let realNameAuthVC = RealNameAuthViewController()
            self.navigationController?.pushViewController(realNameAuthVC, animated: true)
        }
    }
    
}

// MARK: - Setup
private extension PersonalInfoViewController {
    
    private func setupNavbar() {
        self.title = "个人信息"
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(hex:0xF7F7F7FF)
        self.view.addSubview(self.tableView)
        let tableHeaderView = PersonalInfoTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 180))
        tableHeaderView.editAction = { sender in
            let ps = ZLPhotoPreviewSheet()
            ps.selectImageBlock = { [weak self] results, isOriginal in
                // your code
                if let image = results.first?.image{
                    self?.uploadData(headPicUrl, param: [:], image: image, name: "file", fileName: "pic_image", success: { responseObject in
                        self?.showSuccess(withStatus: "修改成功")
                        tableHeaderView.avatarImageView.image = image
                    }, error: { error in
                        self?.showError(withStatus: error.localizedDescription)
                        
                    })
                    
                    
                }
            }
            ps.showPreview(animate: true, sender: self)
        }
        
        tableView.tableHeaderView = tableHeaderView
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}

// MARK: - Public


// MARK: - Request
private extension PersonalInfoViewController {
    
}

// MARK: - Action
@objc private extension PersonalInfoViewController {
    
}

// MARK: - Private
private extension PersonalInfoViewController {
    
}
