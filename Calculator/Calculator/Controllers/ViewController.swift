//
//  ViewController.swift
//  Calculator
//
//  Created by Mac Mini 2021_1 on 06/04/2022.
//

import UIKit

class ViewController: UIViewController  {

    var subView:SubViews!
    var result:UILabel!
    
    var numbers:String = ""
    var lastNumber:String = ""
    var calculation:Calculation!
    var lastStateCalculate:String!
    
    var isEdit: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.isHidden = true
        self.notEditting()
        self.startApplication()
    }
    
    func startApplication() {
        self.calculation = Calculation()
        self.calculation.reset()
        self.setupResultArea()
        self.setupCollectionView()
    }
    
    func setupResultArea() {
        self.result = UILabel()
        self.view.addSubview(self.result)
        self.result.translatesAutoresizingMaskIntoConstraints = false
        self.result.textAlignment = .right
        self.result.backgroundColor = .black
        self.result.text = "0"
        self.result.textColor = .white
        self.result.font = .systemFont(ofSize: 90)
        
        let contraints = [
            self.result.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 230),
            self.result.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
            self.result.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.result.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(contraints)
    }
    
    func setupCollectionView() {
        self.subView = SubViews()
        self.view.addSubview(self.subView)
        self.subView.translatesAutoresizingMaskIntoConstraints = false
        self.subView.backgroundColor = .white

        let contraints = [
            self.subView.topAnchor.constraint(equalTo: self.result.bottomAnchor, constant: 20),
            self.subView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.subView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.subView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(contraints)
        
        self.subView.setupCollectionView(frame: self.view.frame)
        
        self.subView.collection.dataSource = self
        self.subView.collection.delegate = self
        
        self.subView.collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        self.subView.collection.reloadData()
        
    }
    
    func updateTextResult(_ text : String) {
        DispatchQueue.main.async {
            self.result.text = text
        }
    }
    
    func resetAllCaculator() {
        self.calculation.reset()
        self.resetNumbers()
        DispatchQueue.main.async {
            self.result.text = "0"
            self.result.font = .systemFont(ofSize: 80)
        }
    }
    
    func updateILOVEU() {
        DispatchQueue.main.async {
            self.result.text = "I LOVE YOU"
            self.result.font = .systemFont(ofSize: 30)
        }
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Model.numberOfRow
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.numberOfButtonOnRow
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CollectionViewCell
        
        if indexPath.section == 0 && indexPath.row == 0 && self.isEditting() {
            myCell.setItems("C", color: UIColor.lightGray, textColor: UIColor.black, textSize: 30)
            return myCell
        }
        
        if indexPath.section == 0 {
            if indexPath.row == Model.numberOfButtonOnRow - 1 {
                myCell.setItems(Model.yellowSymbol[indexPath.section], color: UIColor.systemOrange, textColor: UIColor.white, textSize: 40)
            } else {
                myCell.setItems(Model.graySymbol[indexPath.row], color: UIColor.lightGray, textColor: UIColor.black, textSize: 30)
            }
        } else if indexPath.row == Model.numberOfButtonOnRow - 1 {
            myCell.setItems(Model.yellowSymbol[indexPath.section], color: UIColor.systemOrange, textColor: UIColor.white,textSize: 45)
        } else {
            myCell.setItems(Model.NumSymbol[indexPath.section - 1][indexPath.row], color: UIColor.darkGray, textColor: UIColor.white,textSize: 40)
        }
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let myCell =  collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        let numbers = myCell.label.text
        if numbers == "C" {
            self.notEditting()
            self.subView.collection.reloadItems(at: [IndexPath(row: 0, section: 0)])
            self.resetAllCaculator()
        } else {
            if !self.isEditting() {
                self.editting()
                self.subView.collection.reloadItems(at: [IndexPath(row: 0, section: 0)])
            }
            self.handleCalculation(numbers!,indexPath: indexPath)
        }
    }
    
    func handleCalculation(_ symbol: String, indexPath: IndexPath) {
        if Model.yellowSymbol[indexPath.section].contains(symbol) || Model.graySymbol.contains(symbol) {
            var result:Float32?
            
            if self.isResetNumber() == true {
                self.numbers = "0"
            }
            let num = Float32(self.numbers)
            self.resetNumbers()
            
            if symbol == "÷" {
                calculation.divide(numFrist: num!)
                self.lastStateCalculate = symbol
            } else if symbol == "×" {
                calculation.multiplication(numFrist: num!)
                self.lastStateCalculate = symbol
            } else if symbol == "-" {
                calculation.subtraction(numFrist: num!)
                self.lastStateCalculate = symbol
            } else if symbol == "+" {
                calculation.addition(numFrist: num!)
                self.lastStateCalculate = symbol
            } else if symbol == "+/-" {
                calculation.toggle(numFrist: num!)
                self.lastStateCalculate = symbol
            } else if symbol == "%" {
                calculation.percent(numFrist: num!)
                self.lastStateCalculate = symbol
            } else if symbol == "=" {
                let numE = Float32(self.lastNumber)
                if self.lastStateCalculate == "÷" {
                    calculation.divide(numFrist: numE!)
                } else if self.lastStateCalculate == "×" {
                    calculation.multiplication(numFrist: numE!)
                } else if self.lastStateCalculate == "-" {
                    calculation.subtraction(numFrist: numE!)
                } else if self.lastStateCalculate == "+" {
                    calculation.addition(numFrist: numE!)
                } else if self.lastStateCalculate == "+/-" {
                    calculation.toggle(numFrist: num!)
                } else if self.lastStateCalculate == "%" {
                    calculation.percent(numFrist: num!)
                }
            }
            
            result = calculation.equal()
            if result == 123 {
                self.updateILOVEU()
            } else {
                result = self.calculation.setRound(result!)
                self.updateTextResult(String(result!))
            }
            
        } else if Model.NumSymbol[indexPath.section - 1].contains(symbol) {
            self.numbers = self.numbers + symbol
            if self.numbers == "0" {
                self.lastNumber = "0"
                self.numbers = ""
            } else {
                self.lastNumber = self.numbers
                self.updateTextResult(self.numbers)
            }
            
        }
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
            if indexPath.section == 0 {
                if indexPath.row == Model.numberOfButtonOnRow - 1 {
                    cell.label.backgroundColor = UIColor.systemYellow
                } else {
                    cell.label.backgroundColor = UIColor.lightText
                }
            } else if indexPath.row == Model.numberOfButtonOnRow - 1 {
                cell.label.backgroundColor = UIColor.systemYellow
            } else {
                cell.label.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
            if indexPath.section == 0 {
                if indexPath.row == Model.numberOfButtonOnRow - 1 {
                    cell.label.backgroundColor = UIColor.systemOrange
                } else {
                    cell.label.backgroundColor = UIColor.lightGray
                }
            } else if indexPath.row == Model.numberOfButtonOnRow - 1 {
                cell.label.backgroundColor = UIColor.systemOrange
            } else {
                cell.label.backgroundColor = UIColor.darkGray
            }
        }
    }
    
    func resetNumbers() {
        self.numbers = ""
    }
    
    func isResetNumber() -> Bool {
        return self.numbers == ""
    }
    
    func editting() {
        self.isEdit = true
    }
    
    func notEditting() {
        self.isEdit = false
    }
    
    func isEditting() -> Bool {
        return self.isEdit == true
    }
}
