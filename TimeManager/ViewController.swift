//
//  ViewController.swift
//  TimeMannager
//
//  Created by Sergey Borovkov on 22.10.2020.
//  Copyright © 2020 Sergey Borovkov. All rights reserved.
//

import UIKit
//class UIProgressBar: UIVi
class ViewController: UIViewController , UICollectionViewDataSource, AddTaskViewControllerDelegate {

    @objc let items = [ "Day", "Week", "Month" ]
    var theSegmentedControl: UISegmentedControl!
    
    func theSegmentedControlInit() -> Void {
        theSegmentedControl = UISegmentedControl(items: items)
        theSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        theSegmentedControl.addTarget(self, action: #selector(SCWatcher), for: .valueChanged)
    }
    
    @objc func SCWatcher() {
        let idx = theSegmentedControl.selectedSegmentIndex
        _ = (idx == UISegmentedControl.noSegment) ? "none" : items[idx]
    }
    
    var tasksStorage: TMTaskStorage = TMTaskStorage()
    
    let theCollectionView: UICollectionView = {
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentInsetAdjustmentBehavior = .always // ???
        return v
    }()

    let rowsLayout : UICollectionViewFlowLayout = {
        let v = UICollectionViewFlowLayout()
        v.minimumLineSpacing = 0
        return v
    }()
    
    // track collection view frame change
    var colViewWidth: CGFloat = 0.0

    // example data --- this will be filled with simple number strings
    var theData: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = self.traitCollection.userInterfaceStyle == .dark ? .systemFill : .systemGray6
        theCollectionView.backgroundColor = self.traitCollection.userInterfaceStyle == .dark ? .systemFill : .systemGray6
        theSegmentedControlInit()
        view.addSubview(theSegmentedControl)
        view.addSubview(theCollectionView)
        view.addSubview(createTaskButton)
        createTaskButton.addTarget(self, action: #selector(CreateTask(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            theSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            theSegmentedControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            createTaskButton.topAnchor.constraint(equalTo: theSegmentedControl.safeAreaLayoutGuide.bottomAnchor),
            createTaskButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            createTaskButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            theCollectionView.topAnchor.constraint(equalTo: createTaskButton.safeAreaLayoutGuide.bottomAnchor),
            theCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            theCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            theCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])

        // register the two cell classes for reuse
        theCollectionView.register(MyProgressView.self, forCellWithReuseIdentifier: "MyProgressView")
        theCollectionView.register(UICollectionViewAddItemButton.self, forCellWithReuseIdentifier: "UICollectionViewAddItemButton")
        // set collection view dataSource
        theCollectionView.dataSource = self
        // use custom flow layout
        theCollectionView.collectionViewLayout = rowsLayout
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rowsLayout.itemSize = CGSize(width: theCollectionView.frame.width, height: 40) // fixme 40
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return 1 more than our data array (the extra one will be the "add item" cell
        return theData.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // if item is less that data count, return a "Content" cell
        if indexPath.item < theData.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProgressView", for: indexPath) as! MyProgressView
            // todo add task reader
            return cell
        }

        // past the end of the data count, so return an "Add Item" cell
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "UICollectionViewAddItemButton", for: indexPath
            ) as! UICollectionViewAddItemButton

        // set the closure
        cell.tapCallback = {
            let storyBoard: UIStoryboard = UIStoryboard(name: "AddTask", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
            newViewController.modalPresentationStyle = .fullScreen
            newViewController.SetTaskStorage(self.tasksStorage)
            newViewController.delegate = self
            self.present(newViewController, animated: true, completion: nil)
        }
        return cell
    }
    
    let createTaskButton : UIButton = {
       let v = UIButton()
       v.translatesAutoresizingMaskIntoConstraints = false
       v.setTitle("New Task", for: .normal)
       v.setTitleColor(UIColor.white, for: .normal)
       return v
    }()
        
    @objc func CreateTask(_ : Any )
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "AddTask", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.SetTaskStorage(self.tasksStorage)
        newViewController.delegate = self
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func CreateNewTask() {
        // add item button was tapped, so append an item to the data array
        self.theData.append("\(self.theData.count + 1)")
        // reload the collection view
        self.theCollectionView.reloadData()
        self.theCollectionView.performBatchUpdates(nil, completion: {
            (result) in
            // scroll to make newly added row visible (if needed)
            let i = self.theCollectionView.numberOfItems(inSection: 0) - 1
            let idx = IndexPath(item: i, section: 0)
            self.theCollectionView.scrollToItem(at: idx, at: .bottom, animated: true)
        })
        dismiss(animated: true, completion: nil)
        // todo add checking that task was created
        if let cell = self.theCollectionView.cellForItem(at: IndexPath(row: self.tasksStorage.taskCount-1, section: 0)) as? MyProgressView
        {
            let newTaks = tasksStorage.GetNewestTask()
            cell.titleName = newTaks.name
            cell.maxValue = newTaks.maxValue
            cell.reachedValue = newTaks.minutesReached
         }
    }
}
