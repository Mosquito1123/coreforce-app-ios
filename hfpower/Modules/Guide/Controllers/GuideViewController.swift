//
//  GuideViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/12.
//

import UIKit

class GuideViewController: UIViewController {
    
    // MARK: - Accessor
    var titles = ["让用户不焦虑","让换电更安全","让换电更智能"]
    var subtitles = ["骑行无忧 单电续航超百公里","核蜂科技 专注不着火锂电","科技引领 迈向智能换电时代"]

    //页面数量
        var numOfPages = 3
    // MARK: - Subviews
    lazy var okButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintAdjustmentMode = .automatic
        button.frame = CGRect(x: 0, y: 0, width: 210, height: 50)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitle("立即开启", for: .normal)
        button.setTitle("立即开启", for: .highlighted)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).toImage(), for: .highlighted)
        button.isHidden = true
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()
    var pageControl:UIPageControl?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Setup
private extension GuideViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        let frame = self.view.bounds
        //scrollView的初始化
        let scrollView = UIScrollView()
        scrollView.frame = self.view.bounds
        scrollView.delegate = self
        //为了能让内容横向滚动，设置横向内容宽度为3个页面的宽度总和
        scrollView.contentSize = CGSizeMake(frame.size.width * CGFloat(numOfPages),
                                            frame.size.height)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        for i in 0..<titles.count{
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
            label.textColor = UIColor(hex:0x262626FF)
            label.text = titles[i]
            label.numberOfLines = 0
            label.adjustsFontSizeToFitWidth = true
            label.frame = CGRectMake(frame.size.width*CGFloat(i)+frame.midX - 185/2,CGFloat(115.5),
                                     frame.size.width*185.0/375.0,35)
            scrollView.addSubview(label)
        }
        for i in 0..<subtitles.count{
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = UIColor(hex:0x999999FF)
            label.text = subtitles[i]
            label.numberOfLines = 0
            label.adjustsFontSizeToFitWidth = true
            label.frame = CGRectMake(frame.size.width*CGFloat(i)+frame.midX - 200/2,CGFloat(156.5),
                                     frame.size.width*200/375.0,21)
            scrollView.addSubview(label)
        }
        for i in 0..<numOfPages{
            let imgfile = "guide\(Int(i+1)).png"
            let image = UIImage(named:"\(imgfile)")
            let imgView = UIImageView(image: image)
            imgView.frame = CGRectMake(frame.size.width*CGFloat(i),CGFloat(180.0),
                                       frame.size.width,frame.size.height * 500.0/812.0)
            scrollView.addSubview(imgView)
        }
        scrollView.contentOffset = CGPointZero
        let pageControl = UIPageControl(frame: CGRectMake(frame.midX - 75,frame.maxY - 107 - 20,
                                                          150,20))
        
        pageControl.numberOfPages = numOfPages
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor(hex:0x447AFEFF)
        pageControl.pageIndicatorTintColor = UIColor(hex:0xF0F0F0FF)
        pageControl.backgroundColor = UIColor.white
        pageControl.hidesForSinglePage = true
        self.view.addSubview(scrollView)
        self.view.addSubview(pageControl)
        self.pageControl = pageControl
        self.view.bringSubviewToFront(pageControl)
        self.okButton.frame = CGRectMake(frame.midX - 210/2,frame.maxY - 50 - 86,
                                         210.0,50)
        self.view.addSubview(self.okButton)
        self.view.bringSubviewToFront(self.okButton)
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension GuideViewController:UIScrollViewDelegate {
    //scrollview滚动的时候就会调用
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let twidth = CGFloat(numOfPages-1) * self.view.bounds.size.width
        //如果在最后一个页面继续滑动的话就会跳转到主页面
        // 计算当前页的索引
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)

        // 设置 UIPageControl 的当前页
        self.pageControl?.currentPage = pageIndex
        if pageIndex >= 2  {
            self.okButton.isHidden = false
        }else{
            self.okButton.isHidden = true

        }

    }
}

// MARK: - Request
private extension GuideViewController {
    
}

// MARK: - Action
@objc private extension GuideViewController {
    @objc func buttonTapped(_ sender:UIButton){
        let mainController:UIViewController
        if let _ = AccountManager.shared.phoneNum{
            let mainTabBarController = MainTabBarController()
            mainController = UINavigationController(rootViewController: mainTabBarController)
            mainController.modalPresentationStyle = .fullScreen

        }else{
            let loginVC = LoginPhoneViewController()
            let nav = UINavigationController(rootViewController: loginVC)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .coverVertical
            mainController = nav
            
        }
        self.present(mainController, animated: true)
    }
}

// MARK: - Private
private extension GuideViewController {
    
}
