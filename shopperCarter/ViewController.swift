//
//  ViewController.swift
//  shopperCarter
//
//  Created by CARL SHOW on 10/26/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
        if shoppersCart.isEmpty
        {
            iHateTableViews.isHidden = true
        }
        else
        {
            iHateTableViews.isHidden = false
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
        shoppersCart.append(shoperCarter[r])
        iHateTableViews.reloadData()
        iHateTableViews.isHidden = false
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
    }
    @IBAction func addction(_ sender: Any)
    {
        shoperCarter.append(adder.text!)
        theNightmare.reloadData()
    }
}

