//
//  SpinnerView.swift
//  InvoltaTest
//
//  Created by Vitaly Khomatov on 15.02.2021.
//

import UIKit

class SpinnerView: UIView {

        lazy var messageLabel: UILabel = {
            let label = UILabel(frame: CGRect.zero)
            label.text = "Loading"
            label.font = UIFont.systemFont(ofSize: 17.0)
            label.textColor = .white
            label.sizeToFit()

            return label
        }()

        private lazy var spinner: UIActivityIndicatorView = {
            let spinner = UIActivityIndicatorView(style: .medium)
            return spinner
        }()

        var frameWidthCalculated: CGFloat {
            return spinner.frame.size.width + messageLabel.frame.size.width
        }

        override init(frame: CGRect) {

            super.init(frame: frame)

            self.backgroundColor = UIColor(white: 0, alpha: 0.7)
            self.layer.cornerRadius = 15.0

            self.setupSubviews()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func layoutSubviews() {
            super.layoutSubviews()

        }

        func calculatedSize() -> CGSize {
            let width = messageLabel.frame.maxX + 10.0
            let height = spinner.frame.maxY
            return CGSize(width: width, height: height)
        }

        private func setupSubviews() {
            self.addSubview(spinner)
            self.addSubview(messageLabel)
        }

        func start() {
            spinner.startAnimating()
        }

        func stop() {
            spinner.stopAnimating()
        }
}
