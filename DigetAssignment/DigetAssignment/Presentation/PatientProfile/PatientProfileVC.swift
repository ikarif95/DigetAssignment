//
//  PatientProfileVC.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import UIKit
import Combine

// MARK: - IBOutlet Properties
// MARK: - Custom Variable Properties
// MARK: - Default View Controller Methods
// MARK: - IBAction Methods
// MARK: - View Properties
// MARK: - Custom Methods
// MARK: - TableView Delegate DataSource extension

final class PatientProfileViewController: UIViewController {
   
    // MARK: - View Properties
    private lazy var btnAppearance: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.image = UserDefaults.standard.isDarkMode ? UIImage.SFSymbol.sunMaxFill : UIImage.SFSymbol.moonFill
        btn.style = .plain
        btn.target = self
        btn.action = #selector(toggleAppearance)
        return btn
    }()
    
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
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondaryBackground
        return view
    }()
    
    private lazy var lbName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppTypography.largeTitle()
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityTraits = .header
        return label
    }()
    
    private lazy var lbAge: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppTypography.title3()
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = AppLayout.spacing16
        return stack
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - Custom Methods
    private let viewModel: PatientProfileViewModel
    private var cancellables = Set<AnyCancellable>()
    
    
    
    // MARK: - Default View Controller Methods
    init(viewModel: PatientProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.loadPatient()
    }
    
    // MARK: - Custom Methods
    private func setupUI() {
        title = "Profile"
        view.backgroundColor = .background
        navigationItem.rightBarButtonItem = btnAppearance
        
        view.addSubviews(scrollView, loadingView)
        scrollView.addSubview(contentView)
        headerView.addSubviews(lbName, lbAge)
        contentView.addSubviews(headerView, infoStackView)
        
        scrollView.place(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        
        contentView.place(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, equalWidthTo: scrollView.widthAnchor)
        
        headerView.place(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, height: 100)

        lbName.place(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: lbAge.topAnchor, trailing: headerView.trailingAnchor, topConstant: AppLayout.spacing8, leadingConstant: AppLayout.spacing20, bottomConstant: -AppLayout.spacing8, trailingConstant: -AppLayout.spacing20)

        lbAge.place(top: lbName.bottomAnchor, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: headerView.trailingAnchor, leadingConstant: AppLayout.spacing20, bottomConstant: -AppLayout.spacing20, trailingConstant: -AppLayout.spacing20)

        infoStackView.place(top: headerView.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, topConstant: AppLayout.spacing24, leadingConstant: AppLayout.spacing16, bottomConstant: -AppLayout.spacing24, trailingConstant: -AppLayout.spacing16)

        loadingView.place(centerX: view.centerXAnchor,centerY: view.centerYAnchor)
    }
    
    @objc private func toggleAppearance() {
        guard let window = view.window ?? UIApplication.shared.firstWindow else { return }
        let currentStyle = window.overrideUserInterfaceStyle
        let newStyle: UIUserInterfaceStyle = currentStyle == .dark ? .light : .dark
        window.overrideUserInterfaceStyle = newStyle
        navigationItem.rightBarButtonItem?.image = (newStyle == .dark) ? UIImage.SFSymbol.sunMaxFill : UIImage.SFSymbol.moonFill
        UserDefaults.standard.isDarkMode = newStyle == .dark
    }
    
    private func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleState(state)
            }
            .store(in: &cancellables)
    }
    
    private func handleState(_ state: PatientProfileViewModel.State) {
        switch state {
        case .idle:
            loadingView.stopAnimating()
        case .loading:
            loadingView.startAnimating()
            infoStackView.isHidden = true
        case .loaded(let patient):
            loadingView.stopAnimating()
            infoStackView.isHidden = false
            configure(with: patient)
        case .error(let error):
            loadingView.stopAnimating()
            alert(title: "Error", message: error?.localizedDescription ?? "Failed to load patient profile. Please try again.", btn1Text: "Retry", btn1Handler: { [weak self] in
                self?.viewModel.loadPatient()
            }, btn2Text: "Cancel") {
                
            }
        }
    }
    
    private func configure(with patient: Patient) {
        print("patient.fullName \(patient.fullName)")
        lbName.text = patient.fullName
        lbAge.text = "\(patient.age) years old • \(patient.gender.rawValue)"
        
        infoStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        infoStackView.addArrangedSubview(createInfoCard(
            title: "Contact Information",
            items: [
                ("Phone", patient.phoneNumber),
                ("Email", patient.email)
            ]
        ))
        
        infoStackView.addArrangedSubview(createInfoCard(
            title: "Medical Information",
            items: [
                ("Blood Type", patient.bloodType.rawValue),
                ("Date of Birth", patient.dateOfBirth.inDateTime)
            ]
        ))
        
        infoStackView.addArrangedSubview(createInfoCard(
            title: "Address",
            items: [
                ("Street", patient.address.street),
                ("City", "\(patient.address.city), \(patient.address.state) \(patient.address.zipCode)")
            ]
        ))
        
        infoStackView.addArrangedSubview(createInfoCard(
            title: "Emergency Contact",
            items: [
                ("Name", patient.emergencyContact.name),
                ("Relationship", patient.emergencyContact.relationship),
                ("Phone", patient.emergencyContact.phoneNumber)
            ]
        ))
        
//        let buttonStack = UIStackView(arrangedSubviews: [appointmentsButton, vitalsButton])
//        buttonStack.axis = .vertical
//        buttonStack.spacing = AppLayout.spacing12
//        infoStackView.addArrangedSubview(buttonStack)
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
        
        let keyLabel = UILabel()
        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        keyLabel.font = AppTypography.subheadline()
        keyLabel.textColor = .secondaryText
        keyLabel.text = key
        keyLabel.adjustsFontForContentSizeCategory = true
        keyLabel.accessibilityLabel = key
        
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.font = AppTypography.body()
        valueLabel.textColor = .primaryText
        valueLabel.text = value
        valueLabel.numberOfLines = 0
        valueLabel.adjustsFontForContentSizeCategory = true
        valueLabel.accessibilityLabel = value
        
        container.addSubviews(keyLabel, valueLabel)
        
        keyLabel.place(top: container.topAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor)

        valueLabel.place(top: keyLabel.bottomAnchor,leading: container.leadingAnchor,bottom: container.bottomAnchor, trailing: container.trailingAnchor,topConstant: AppLayout.spacing4)
        
        return container
    }
    
    @objc private func appointmentsTapped() {
        viewModel.didTapAppointments()
    }
    
    @objc private func vitalsTapped() {
        viewModel.didTapVitals()
    }

    
   
}
