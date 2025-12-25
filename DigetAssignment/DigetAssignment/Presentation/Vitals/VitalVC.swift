//
//  VitalVC.swift
//  DigetAssignment
//
//  Created by Iftikhar Arif on 12/24/25.
//

import UIKit
import Combine

final class VitalsVC: UIViewController {
    
    // MARK: - View Properties
    private lazy var tableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .insetGrouped)
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.register(VitalCell.self, forCellReuseIdentifier: VitalCell.reuseIdentifier)
        tb.backgroundColor = .background
        return tb
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()

    
    // MARK: - Custom Variable Properties
    private let viewModel: VitalsViewModel
    private var cancellables = Set<AnyCancellable>()
    private var vitals: [Vital] = []
    
    
    // MARK: - Default View Controller Methods
    init(viewModel: VitalsViewModel) {
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
        viewModel.loadVitals()
    }
    
    // MARK: - Custom Methods
    private func setupUI() {
        title = "Vitals"
        view.backgroundColor = .background
        view.addSubviews(tableView, loadingView)
        loadingView.place(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        tableView.place(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
    private func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.handleState(state)
            }
            .store(in: &cancellables)
    }
    
    private func handleState(_ state: VitalsViewModel.State) {
        switch state {
        case .idle:
            loadingView.stopAnimating()
        case .loading:
            loadingView.startAnimating()
            tableView.isHidden = true
        case .loaded(let vitals):
            loadingView.stopAnimating()
            tableView.isHidden = false
            self.vitals = vitals.sorted { $0.measuredAt > $1.measuredAt }
            tableView.reloadData()
        case .error(let error):
            loadingView.stopAnimating()
            alert(title: "Error", message: error?.localizedDescription ?? "Failed to load vitals. Please try again.", btn1Text: "Retry", btn1Handler: { [weak self] in
                self?.viewModel.loadVitals()
            }, btn2Text: "Cancel") {
                
            }
        }
    }
    
    
}


// MARK: - TableView Delegate DataSource extension
extension VitalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vitals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VitalCell.reuseIdentifier, for: indexPath) as? VitalCell else { return UITableViewCell() }
        cell.configure(with: vitals[indexPath.row])
        return cell
    }
}
