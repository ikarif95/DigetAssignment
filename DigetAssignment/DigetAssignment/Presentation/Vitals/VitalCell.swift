//
//  VitalCell.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import UIKit

final class VitalCell: UITableViewCell {
    static let reuseIdentifier = "VitalCell"
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondaryBackground
        view.layer.cornerRadius = AppLayout.cornerRadiusMedium
        return view
    }()
    
    private lazy var iconView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var iconLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .title3()
        label.textAlignment = .center
        return label
    }()
    
    //here i used font extension
    private lazy var lbType: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .headline()
        label.textColor = .primaryText
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var lbValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .title2(weight: .bold)
        label.textColor = .primaryText
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    //here i used AppTypography for font
    private lazy var lbDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppTypography.caption1()
        label.textColor = .secondaryText
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var statusBadge: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(cardView)
        iconView.addSubview(iconLabel)
        cardView.addSubviews(iconView, lbType, lbValue, lbDate, statusBadge)

        cardView.place(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, topConstant: 5, bottomConstant: -5)

        iconView.place(leading: cardView.leadingAnchor, centerY: cardView.centerYAnchor, leadingConstant: AppLayout.spacing12, width: 40, height: 40)

        iconLabel.place( centerX: iconView.centerXAnchor,centerY: iconView.centerYAnchor)

        lbType.place(top: cardView.topAnchor, leading: iconView.trailingAnchor, trailing: statusBadge.leadingAnchor, topConstant: AppLayout.spacing12, leadingConstant: AppLayout.spacing12, trailingConstant: -AppLayout.spacing8)

        statusBadge.place(trailing: cardView.trailingAnchor, centerY: lbType.centerYAnchor, trailingConstant: -AppLayout.spacing12, width: AppLayout.spacing12, height: 12)

        lbValue.place(top: lbType.bottomAnchor, leading: iconView.trailingAnchor, trailing: cardView.trailingAnchor, topConstant: AppLayout.spacing4, leadingConstant: AppLayout.spacing12, trailingConstant: -AppLayout.spacing12)

        lbDate.place(top: lbValue.bottomAnchor, leading: iconView.trailingAnchor, bottom: cardView.bottomAnchor, trailing: cardView.trailingAnchor, topConstant: AppLayout.spacing4, leadingConstant: AppLayout.spacing12, bottomConstant: -AppLayout.spacing12, trailingConstant: -AppLayout.spacing12)
    }
    
    func configure(with vital: Vital) {
        lbType.text = vital.type.rawValue
        lbValue.text = vital.displayValue
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        lbDate.text = "Measured: \(formatter.string(from: vital.measuredAt))"
        
        statusBadge.backgroundColor = vital.isNormal ? .success : .warning
        
        let (icon, color) = iconForVitalType(vital.type)
        iconLabel.text = icon
        iconView.backgroundColor = color.withAlphaComponent(0.2)
    }
    
    private func iconForVitalType(_ type: Vital.VitalType) -> (String, UIColor) {
        switch type {
        case .weight: return ("⚖️", .primary)
        case .height: return ("📏", .primary)
        case .heartRate: return ("❤️", .heartRate)
        case .temperature: return ("🌡️", .temperature)
        case .bloodGlucose: return ("🩸", .bloodPressure)
        case .respiratoryRate: return ("🫁", .oxygenSaturation)
        case .oxygenSaturation: return ("💨", .oxygenSaturation)
        case .bloodPressureSystolic, .bloodPressureDiastolic: return ("🩸", .bloodPressure)
        }
    }
}
