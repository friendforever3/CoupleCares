//
//  HomeVC.swift
//  CoupleCares
//
//  Created by Surinder kumar on 26/09/21.
//

import UIKit
import Shuffle_iOS




class HomeVC: UIViewController {

    @IBOutlet weak var vwCard: SwipeCardStack!
    
    let cardImages = [
          UIImage(named: "Rectangle 27"),
          UIImage(named: "Rectangle 28"),
          UIImage(named: "Rectangle 27"),
          UIImage(named: "Rectangle 28")
      ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        vwCard.dataSource = self
        vwCard.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func btnLikeAction(_ sender: Any) {
        let vc = MatchVC.getVC(.Home)
        self.push(vc)
    }
    
    @IBAction func btnAddAction(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = true
        let vc = SubscriptionTypeVC.getVC(.Home)
        vc.delegate = self
        
        vc.view.backgroundColor = .black.withAlphaComponent(0.5)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        nav.view.backgroundColor = .black.withAlphaComponent(0.5)
        nav.setNavigationBarHidden(true, animated: false)
        self.present(nav, animated: true, completion: nil)
    }
    
}


//MARK: Protocol Controller delegate
extension HomeVC : ControllerDeleagte{
    func didCloseDelegate() {
        self.viewWillAppear(true)
    }
    
}

// MARK: Data Source + Delegates

extension HomeVC: SwipeCardStackDataSource, SwipeCardStackDelegate {

  func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
    let card = SwipeCard()
    card.footerHeight = 80
    card.swipeDirections = [.left, .up, .right]
    for direction in card.swipeDirections {
      //card.setOverlay(TinderCardOverlay(direction: direction), forDirection: direction)
    }

//    let model = cardModels[index]
//    card.content = TinderCardContentView(withImage: model.image)
//    card.footer = TinderCardFooterView(withTitle: "\(model.name), \(model.age)", subtitle: model.occupation)

      card.content = TinderCardContentView(withImage: cardImages[index])
      
      return card
  }

  func numberOfCards(in cardStack: SwipeCardStack) -> Int {
      return cardImages.count
  }

  func didSwipeAllCards(_ cardStack: SwipeCardStack) {
    print("Swiped all cards!")
      
  }

  func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
    //print("Undo \(direction) swipe on \(cardModels[index].name)")
     print("Undo \(direction)")
  }

  func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
    //print("Swiped \(direction) on \(cardModels[index].name)")
      print("Swiped \(direction)")
  }

  func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
    print("Card tapped")
      let vc = OtherProfileVC.getVC(.Home)
      self.push(vc)
  }

//  func didTapButton(button: TinderButton) {
//    switch button.tag {
//    case 1:
//      cardStack.undoLastSwipe(animated: true)
//    case 2:
//      cardStack.swipe(.left, animated: true)
//    case 3:
//      cardStack.swipe(.up, animated: true)
//    case 4:
//      cardStack.swipe(.right, animated: true)
//    case 5:
//      cardStack.reloadData()
//    default:
//      break
//    }
//  }
}
