//
//  BaseVC.swift
//  tymex-test
//
//  Created by Hai Nguyen on 12/5/25.
//

import UIKit

class BaseVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configBackButton() {
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.setTitle("", for: .normal)
        backButton.tintColor = .label
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)

        let customBackItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = customBackItem
    }

    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}
