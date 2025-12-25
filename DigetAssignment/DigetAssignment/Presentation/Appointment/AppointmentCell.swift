//
//  AppointmentCell.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import UIKit

final class AppointmentCell: UITableViewCell {
    static let reuseIdentifier = "AppointmentCell"
    
    private lazy var cardiew: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondaryBackground
        view.layer.cornerRadius = AppLayout.cornerRadiusMedium
        return view
    }()
    
    private lazy var lbDoctor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppTypography.headline()
        label.textColor = .primaryText
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var lbSpecialty: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppTypography.subheadline()
        label.textColor = .secondaryText
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var lbDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppTypography.body()
        label.textColor = .primaryText
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var lbStatus: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppTypography.caption1(weight: .semibold)
        label.textAlignment = .center
        label.layer.cornerRadius = AppLayout.cornerRadiusSmall
        label.layer.masksToBounds = true
        return label
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
        
        contentView.addSubview(cardiew)
        cardiew.addSubviews(lbDoctor, lbSpecialty, lbDate, lbStatus)
  
        cardiew.place(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, topConstant: AppLayout.spacing8, bottomConstant: -AppLayout.spacing8)

        lbDoctor.place(top: cardiew.topAnchor, leading: cardiew.leadingAnchor, trailing: lbStatus.leadingAnchor, topConstant: AppLayout.spacing12, leadingConstant: AppLayout.spacing12, trailingConstant: -AppLayout.spacing8)

        lbStatus.place(trailing: cardiew.trailingAnchor, centerY: lbDoctor.centerYAnchor, trailingConstant: -AppLayout.spacing12, width: 80, height: 24)

        lbSpecialty.place(top: lbDoctor.bottomAnchor,leading: cardiew.leadingAnchor,trailing: cardiew.trailingAnchor,topConstant: AppLayout.spacing4,leadingConstant: AppLayout.spacing12,trailingConstant: -AppLayout.spacing12)

        lbDate.place(top: lbSpecialty.bottomAnchor, leading: cardiew.leadingAnchor, bottom: cardiew.bottomAnchor, trailing: cardiew.trailingAnchor, topConstant: AppLayout.spacing8, leadingConstant: AppLayout.spacing12, bottomConstant: -AppLayout.spacing12, trailingConstant: -AppLayout.spacing12)
        
    }
    
    func setup(with appointment: Appointment) {
        lbDoctor.text = appointment.doctorName
        lbSpecialty.text = appointment.specialty
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        lbDate.text = formatter.string(from: appointment.date)
        
        lbStatus.text = appointment.status.rawValue
        
        switch appointment.status {
        case .scheduled, .confirmed:
            lbStatus.backgroundColor = .primary.withAlphaComponent(0.2)
            lbStatus.textColor = .primary
        case .inProgress:
            lbStatus.backgroundColor = .warning.withAlphaComponent(0.2)
            lbStatus.textColor = .warning
        case .completed:
            lbStatus.backgroundColor = .success.withAlphaComponent(0.2)
            lbStatus.textColor = .success
        case .cancelled, .noShow:
            lbStatus.backgroundColor = .error.withAlphaComponent(0.2)
            lbStatus.textColor = .error
        }

    }
}
