//
//  Coordinator.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import UIKit
import Combine

final class AppointmentsViewController: UIViewController {
    private let viewModel: AppointmentsViewModel
    private var cancellables = Set<AnyCancellable>()
    
    
    private lazy var segment: UISegmentedControl = {
        let seg = UISegmentedControl(items: ["All", "Upcoming", "Past"])
        seg.selectedSegmentIndex = 0
        seg.selectedSegmentTintColor = .primary
        seg.addTarget(self, action: #selector(handleSegmentTap), for: .valueChanged)
        return seg
    }()
    
    private lazy var tableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .insetGrouped)
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.register(AppointmentCell.self, forCellReuseIdentifier: AppointmentCell.reuseIdentifier)
        tb.backgroundColor = .background
        return tb
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private var appointments: [Appointment] = []
    private var filterAppointments: [Appointment] = []
    
    init(viewModel: AppointmentsViewModel) {
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
        viewModel.loadAppointments()
    }
    
    private func setupUI() {
        title = "Appointments"
        view.backgroundColor = .background
        
        view.addSubviews(segment, tableView, loadingView)
      
        segment.place(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, topConstant: AppLayout.spacing12, leadingConstant: AppLayout.spacing16, trailingConstant: -AppLayout.spacing16, height: 40)
        tableView.place(top: segment.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, topConstant: AppLayout.spacing12)
        loadingView.place(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
    }
    
    private func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleState(state)
            }
            .store(in: &cancellables)
    }
    
    @objc private func handleSegmentTap(seg: UISegmentedControl) {
        switch seg.selectedSegmentIndex {
        case 0: filterAppointments = appointments
        case 1: filterAppointments = appointments.filter({ $0.isUpcoming })
        case 2: filterAppointments = appointments.filter({ !$0.isUpcoming })
        default: break
        }
        tableView.reloadData()
    }
    private func handleState(_ state: AppointmentsViewModel.State) {
        switch state {
        case .idle:
            loadingView.stopAnimating()
        case .loading:
            loadingView.startAnimating()
            tableView.isHidden = true
        case .loaded(let appointments):
            loadingView.stopAnimating()
            tableView.isHidden = false
            self.appointments = appointments.sorted { $0.date < $1.date }
            self.filterAppointments = self.appointments
            tableView.reloadData()
        case .error(let error):
            loadingView.stopAnimating()
            alert(title: "Error", message: error?.localizedDescription ?? "Failed to load appointments. Please try again.", btn1Text: "Retry", btn1Handler: { [weak self] in
                self?.viewModel.loadAppointments()
            }, btn2Text: "Cancel") {
                
            }
            
        }
    }
    
}

extension AppointmentsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentCell.reuseIdentifier,for: indexPath) as? AppointmentCell else { return UITableViewCell() }
        cell.setup(with: filterAppointments[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectAppointment(filterAppointments[indexPath.row])
    }
}
