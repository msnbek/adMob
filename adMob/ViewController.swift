//
//  ViewController.swift
//  adMob
//
//  Created by Mahmut Senbek on 11.10.2023.
//

import UIKit
import GoogleMobileAds
import SnapKit

class ViewController: UIViewController {
    
    let bannerView : GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.load(GADRequest())
        banner.backgroundColor = .secondarySystemBackground
        return banner
        
    }()
    let button = UIButton()
    
    var interstitial : GADInterstitialAd?
    var rewardedAd: GADRewardedAd?
    override func viewDidLoad() {
        super.viewDidLoad()
        openingAd()
        configureUI()
    }
    func configureUI() {
        view.backgroundColor = .red.withAlphaComponent(0.1)
        view.addSubview(bannerView)
        bannerView.rootViewController = self
        bannerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(100)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.leading.equalTo(view.snp.leading).offset(0)
        }
        bannerViewDidReceiveAd(bannerView)
        
        view.addSubview(button)
        button.setTitle("Get Your Reward", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.tintColor = .white
        button.backgroundColor = .blue.withAlphaComponent(0.8)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(180)
            make.height.equalTo(120)
        }
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
    
    func openingAd() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/4411468910",
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
            interstitial?.present(fromRootViewController: self)
        }
        )
    }
    
    @objc func buttonTapped() {
        let request = GADRequest()
        GADRewardedAd.load(withAdUnitID:"ca-app-pub-3940256099942544/1712485313",
                           request: request,
                           completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load rewarded ad with error: \(error.localizedDescription)")
                return
            }
            rewardedAd = ad
            print("Rewarded ad loaded.")
            if let ad = rewardedAd {
                ad.present(fromRootViewController: self) { [self] in
                    let reward = ad.adReward
                    print("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
                    DispatchQueue.main.async {
                        let vc = SecondViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        })
    }
    
    
    
}
