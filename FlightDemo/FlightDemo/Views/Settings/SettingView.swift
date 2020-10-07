//
//  ChooseSettingView.swift
//  FlightDemo
//
//  Created by Gábor Vass on 06/10/2020.
//  Copyright © 2020 Gábor Vass. All rights reserved.
//

import Foundation
import UIKit

class ChooseSettingView: UIView {
    private let settingLabel = UILabel()
    private let segmentedControl = UISegmentedControl()
    private let options = [
        NSLocalizedString("miles_label", comment: "Imperial units"),
        NSLocalizedString("km_label", comment: "Metric units")]

    var onValueChanged: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)

        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateContent(currentValue: UnitsOfMeasure) {
        self.segmentedControl.selectedSegmentIndex = currentValue.rawValue
    }

    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupSettingLabel()
        self.setupSegmentedControl()
    }

    private func setupSettingLabel() {
        self.settingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.settingLabel.font = UIDesign.Fonts.label
        self.settingLabel.textColor = UIDesign.Colors.label
        self.settingLabel.text = NSLocalizedString("Units of measure", comment: "Units of measure")
        self.addSubview(self.settingLabel)
        NSLayoutConstraint.activate([
            self.settingLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.settingLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            self.settingLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.settingLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func setupSegmentedControl() {
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.segmentedControl.removeAllSegments()
        self.options.forEach {
            self.segmentedControl.insertSegment(withTitle: $0, at: 0, animated: false)
        }
        self.addSubview(self.segmentedControl)
        NSLayoutConstraint.activate([
            self.segmentedControl.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            self.segmentedControl.topAnchor.constraint(equalTo: self.settingLabel.bottomAnchor, constant: 8),
            self.segmentedControl.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            self.segmentedControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    @objc
    private func segmentedControlChanged(_ sender: UISegmentedControl) {
        self.onValueChanged?(sender.selectedSegmentIndex)
    }

}
