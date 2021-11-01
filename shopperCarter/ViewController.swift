//
//  ViewController.swift
//  shopperCarter
//
//  Created by CARL SHOW on 10/26/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    var shoperCarter : [String] = ["Orange", "Oragne", "Owrang", "Banana"]
    var shoppersCart : [String] = [""]
    var r = 0
    @IBOutlet weak var theNightmare: UITableView!
    @IBOutlet weak var iHateTableViews: UITableView!
    @IBOutlet weak var adder: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        theNightmare.delegate = self
        theNightmare.dataSource = self
        iHateTableViews.delegate = self
        iHateTableViews.dataSource = self
        adder.delegate = self
        theNightmare.backgroundColor = UIColor.darkGray
        iHateTableViews.backgroundColor = UIColor.darkGray
        if shoppersCart.isEmpty
        {
            iHateTableViews.isHidden = true
        }
        else
        {
            iHateTableViews.isHidden = false
        }
        if let items = UserDefaults.standard.data(forKey: "UsrCrt") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([String].self, from: items)
            {
                shoppersCart = decoded
            }
        }
        if let items = UserDefaults.standard.data(forKey: "GlblCrt") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([String].self, from: items)
            {
                shoperCarter = decoded
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == theNightmare
        {
            return shoperCarter.count
        }
        else
        {
            return shoppersCart.count
        }
    }
        func tableView(_ tableView: UITableView, cellForRowAt t: IndexPath) -> UITableViewCell
    {
        let c = tableView.dequeueReusableCell(withIdentifier: "celSel", for: t)
        c.backgroundColor = UIColor.black
        c.textLabel?.textColor = UIColor.white
        if tableView == theNightmare
        {
            c.textLabel?.text = "\(shoperCarter[t.row])"
        }
        else
        {
            c.textLabel?.text = "\(shoppersCart[t.row])"
        }
        return c
    }
    func tableView(_ g: UITableView, didSelectRowAt p: IndexPath)
    {
        r = p.row
        print(r)
        var dodge = false
        for i in shoppersCart
        {
            if i == shoperCarter[r]
            {
                dodge = true
                let err = UIAlertController(title: "Error", message: "This item is already present in your cart.", preferredStyle: .alert)
                err.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                present(err, animated: true, completion: nil)
            }
        }
        if dodge == false
        {
            shoppersCart.append(shoperCarter[r])
            iHateTableViews.deselectRow(at: p, animated: true)
            iHateTableViews.reloadData()
            iHateTableViews.isHidden = false
            pushToRepository()
        }
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            if tableView == theNightmare
            {
                shoperCarter.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            else
            {
                shoppersCart.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        pushToRepository()
    }
    @IBAction func Empty(_ sender: Any)
    {
        shoperCarter.removeAll()
        shoppersCart.removeAll()
        theNightmare.reloadData()
        iHateTableViews.reloadData()
        pushToRepository()
    }
    @IBAction func addction(_ sender: Any)
    {
        var dodge = false
        for i in shoperCarter
        {
            if i.lowercased() == adder.text?.lowercased()
            {
                dodge = true
                let err = UIAlertController(title: "Error", message: "This item is already present in the store.", preferredStyle: .alert)
                err.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                present(err, animated: true, completion: nil)
            }
        }
        if dodge == false
        {
            shoperCarter.append(adder.text!)
            theNightmare.reloadData()
            pushToRepository()
        }
    }
    func pushToRepository()
    {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(shoppersCart)
        {
            UserDefaults.standard.set(encoded, forKey: "UsrCrt")
        }
        if let encoded = try? encoder.encode(shoperCarter)
        {
            UserDefaults.standard.set(encoded, forKey: "GlblCrt")
        }
    }
    
}

