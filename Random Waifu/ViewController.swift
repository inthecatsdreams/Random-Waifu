//
//  ViewController.swift
//  Random Waifu
//
//  Created by Ilya on 19/07/2020.
//  Copyright © 2020 Ilya. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        explicitToggle.isOn = false
        let fileUrl = URL(string: "https://cdn.discordapp.com/avatars/405667245415727104/278961f682ba296ad99c494562e86114.png?size=512")!
        waifuView.load(url: fileUrl)
        waifuInput.text = "cirno"
    }
    func generateWaifu(waifu : String, rating : String) -> String
    {
        
        let url = "https://danbooru.donmai.us/posts.json?random=true&tags=\(waifu)&rating=\(rating)&limit=1"
        //let decoder = JSONDecoder()
        var res = ""
        
    if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                //let decoder = JSONDecoder()
                print(data)
                let img: [Image] = try! JSONDecoder().decode([Image].self, from: data)
                res = String(img.first?.url ?? "String")

                
            }
        }
        return res
    }
    
        
    @IBOutlet weak var waifuLink: UILabel!
    
    @IBAction func WaifuButton(_ sender: Any) {
        if waifuInput.text == nil || waifuInput.text == ""
        {
            let alert = UIAlertController(title: "Empty", message: "The text field can't be empty", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok, sorry.", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        else{
            if (explicitToggle.isOn){
                let waifu = generateWaifu(waifu: waifuInput.text!, rating: "explicit")
                
                    let fileUrl = URL(string: waifu)!
                    waifuView.load(url: fileUrl)
            }
            else{
                let waifu = generateWaifu(waifu: waifuInput.text!, rating: "safe")
                
                    let fileUrl = URL(string: waifu)!
                    waifuView.load(url: fileUrl)
            }
            

        }
    }
    
    @IBOutlet weak var waifuInput: UITextField!
    @IBOutlet weak var waifuView: UIImageView!
    
    @IBOutlet weak var explicitToggle: UISwitch!
}

