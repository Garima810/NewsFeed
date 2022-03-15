//
//  NewsViewController.swift
//  NewsItem
//
//  Created by Garima Ashish Bisht on 13/03/22.
//

import UIKit

class NewsViewController: UIViewController {

    private var viewModel = NewsViewModel()
    private var tableView: UITableView = UITableView()
    private let refreshControl = UIRefreshControl()

    lazy var indicatorView: UIActivityIndicatorView = {
      let view = UIActivityIndicatorView(style: .large)
      view.contentMode = .scaleToFill
      view.color = .white
      view.translatesAutoresizingMaskIntoConstraints = false
      view.hidesWhenStopped = true
      return view
    }()
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        fetchNewsDataforToday()
        configureNavigationBar()
        configureTableView()
        configureRefreshControl()
        setupViews()
        //setupDatePicker()
        // Do any additional setup after loading the view.
    }
    
    private func configureNavBar() {
        title = viewModel.screenTitle
    }
    
    private func setupViews() {
        self.view.addSubview(indicatorView)
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
          ])
    }
    
    private func configureNavigationBar() {
        // Create the navigation bar
        navigationItem.title = viewModel.screenTitle

    }
    
    private func fetchNewsDataforToday() {

        self.indicatorView.startAnimating()
        viewModel.fetchNewsDetailsforSelectedDate { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success( _):
                DispatchQueue.main.async { [self] in
                self.indicatorView.stopAnimating()
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
                }
            default:
                break
                
            }
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 20.0),
        ])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    private func configureRefreshControl() {
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching News ...")
        refreshControl.addTarget(self, action: #selector(refreshNewsData(_:)), for: .valueChanged)

    }
    
    @objc private func refreshNewsData(_ sender: Any) {
        // Fetch News
        fetchNewsDataforToday()
    }
    
}

extension NewsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell: NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)  as? NewsTableViewCell {
            cell.configure(with: viewModel.newsItemAtIndex(index: indexPath.row))
            return cell
        }
        return UITableViewCell()
    }
    
}

extension NewsViewController: UITableViewDelegate {
    
}

