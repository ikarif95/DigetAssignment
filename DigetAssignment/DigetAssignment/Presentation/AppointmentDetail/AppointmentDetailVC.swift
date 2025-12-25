//
//  AppointmentDetailVC.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import UIKit
import Combine

final class AppointmentDetailViewController: UIViewController {
    private let viewModel: AppointmentDetailViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = AppLayout.spacing16
        return stack
    }()
    
    init(viewModel: AppointmentDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure(with: viewModel.appointment)
    }
    
    private func setupUI() {
        title = "Appointment Details"
        view.backgroundColor = .background
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(infoStackView)
        
        scrollView.place(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)

        contentView.place(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, equalWidthTo: scrollView.widthAnchor)

        infoStackView.place(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, topConstant: AppLayout.spacing20, leadingConstant: AppLayout.spacing16, bottomConstant: -AppLayout.spacing20, trailingConstant: -AppLayout.spacing16)
    }
    
    private func configure(with appointment: Appointment) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        infoStackView.addArrangedSubview(createInfoCard(
            title: "Doctor Information",
            items: [
                ("Name", appointment.doctorName),
                ("Specialty", appointment.specialty)
            ]
        ))
        
        infoStackView.addArrangedSubview(createInfoCard(
            title: "Appointment Details",
            items: [
                ("Date & Time", dateFormatter.string(from: appointment.date)),
                ("Duration", "\(Int(appointment.duration / 60)) minutes"),
                ("Type", appointment.type.rawValue),
                ("Status", appointment.status.rawValue)
            ]
        ))
        
        infoStackView.addArrangedSubview(createInfoCard(
            title: "Location",
            items: [
                ("Facility", appointment.location)
            ]
        ))
        
        if let notes = appointment.notes {
            infoStackView.addArrangedSubview(createInfoCard(
                title: "Notes",
                items: [
                    ("", notes)
                ]
            ))
        }
    }
    
    private func createInfoCard(title: String, items: [(String, String)]) -> UIView {
        let card = UIView()
        card.backgroundColor = .secondaryBackground
        card.layer.cornerRadius = AppLayout.cardCornerRadius
        card.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = AppTypography.headline()
        titleLabel.textColor = .primaryText
        titleLabel.text = title
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.accessibilityTraits = .header
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = AppLayout.spacing12
        
        card.addSubviews(titleLabel, stackView)
        
        titleLabel.place(top: card.topAnchor, leading: card.leadingAnchor, trailing: card.trailingAnchor, topConstant: AppLayout.cardPadding, leadingConstant: AppLayout.cardPadding, trailingConstant: -AppLayout.cardPadding)

        stackView.place(top: titleLabel.bottomAnchor, leading: card.leadingAnchor, bottom: card.bottomAnchor, trailing: card.trailingAnchor, topConstant: AppLayout.spacing12, leadingConstant: AppLayout.cardPadding, bottomConstant: -AppLayout.cardPadding, trailingConstant: -AppLayout.cardPadding)
        
        items.forEach { key, value in
            let itemView = createInfoRow(key: key, value: value)
            stackView.addArrangedSubview(itemView)
        }
        
        return card
    }
    
    private func createInfoRow(key: String, value: String) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        if !key.isEmpty {
            let lbKey = UILabel()
            lbKey.translatesAutoresizingMaskIntoConstraints = false
            lbKey.font = AppTypography.subheadline()
            lbKey.textColor = .secondaryText
            lbKey.text = key
            lbKey.adjustsFontForContentSizeCategory = true
            container.addSubview(lbKey)
            
            lbKey.place(top: container.topAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor)
        }
        
        let lbValue = UILabel()
        lbValue.translatesAutoresizingMaskIntoConstraints = false
        lbValue.font = AppTypography.body()
        lbValue.textColor = .primaryText
        lbValue.text = value
        lbValue.numberOfLines = 0
        lbValue.adjustsFontForContentSizeCategory = true
        
        container.addSubview(lbValue)
        
        if !key.isEmpty, let lbKey = container.subviews.first as? UILabel {
            lbValue.place(top: lbKey.bottomAnchor, leading: container.leadingAnchor, bottom: container.bottomAnchor, trailing: container.trailingAnchor, topConstant: AppLayout.spacing4)
        } else {
            lbValue.pinToSuperview()
        }
        
        return container
    }
}
