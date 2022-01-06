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
    @IBOutlet weak var interestClcVw: UICollectionView!
    @IBOutlet weak var interestVwHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lbluserName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var vwBgSwipe: UIView!
    @IBOutlet weak var vwBgInterest: UIView!
    @IBOutlet weak var vwBgUseDetail: UIView!
    @IBOutlet weak var vwEmpty: UIView!
    
    
    
    let cardImages = [
          UIImage(named: "Rectangle 27"),
          UIImage(named: "Rectangle 28"),
          UIImage(named: "Rectangle 27"),
          UIImage(named: "Rectangle 28")
      ]
    
    var cardIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        vwCard.dataSource = self
        vwCard.delegate = self
        getNearBy()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    @IBAction func btnDislikeAction(_ sender: Any) {
       // vwCard.swipe(.left, animated: true)
        userDislike(likeUserId: HomeVM.shared.getUserNameAge(indexPath: cardIndex).id)
    }
    
    @IBAction func btnLikeAction(_ sender: Any) {
        print("userlikeId;-",HomeVM.shared.getUserNameAge(indexPath: cardIndex).id)
        
        userLike(likeUserId: HomeVM.shared.getUserNameAge(indexPath: cardIndex).id)

    }
    
    @IBAction func btnAddAction(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = true
        let vc = SubscriptionTypeVC.getVC(.Home)
        vc.delegate = self
        
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        nav.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        nav.setNavigationBarHidden(true, animated: false)
        self.present(nav, animated: true, completion: nil)
    }

    
}


//MARK: Protocol Controller delegate
extension HomeVC : ControllerDeleagte,didUpdateDelegate{
    
    func didUpdateHome() {
        getNearBy()
    }
    
    func didCloseDelegate() {
        self.viewWillAppear(true)
    }
    
    
    
}

//MARK: CollectionView Datasource + Delegate
extension HomeVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeVM.shared.getUserInterestCount(index: cardIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestCell", for: indexPath) as! InterestClcCell
        
        cell.lblHomeInterest.text = HomeVM.shared.getUserInterestDetail(index: cardIndex, indexPath: indexPath)
        interestVwHeightConstraint.constant = interestClcVw.contentSize.height
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Craft hkh"
        label.sizeToFit()
        // return CGSize(width: (label.frame.width + 44), height: 48)
        return CGSize(width: ((interestClcVw.frame.size.width) / 3) - 10, height: 40)
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
    
      let url = URL(string: HomeVM.shared.getImageUrl(indexPath: index))
      lbluserName.text = "\(HomeVM.shared.getUserNameAge(indexPath: index).name), \(HomeVM.shared.getUserNameAge(indexPath: index).age)"
      
      lblDistance.text = "\((Double(HomeVM.shared.getUserDistance(index: index)) ?? 1.0).roundToDecimal(2)) Km"
     // lblDistance.text = "\((Double(HomeVM.shared.getUserDistance(index: index)) ?? 1.0).roundToDecimal(2)) Km"
     // print("distance","\(Double(HomeVM.shared.getUserDistance(index: index)))")
      
      
      cardIndex = index
    //  print("cardindex:-",cardIndex)
      
      if (HomeVM.shared.nearByCount() - 1) == index{
          self.interestClcVw.reloadData()
      }
      
      DispatchQueue.global().async {
          let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
          DispatchQueue.main.async {
              //imageView.image = UIImage(data: data!)
              card.content = TinderCardContentView(withImage: UIImage(data: data ?? Data()))
          }
      }

      
     // card.content = TinderCardContentView(withImage: cardImages[index])
      return card
  }

  func numberOfCards(in cardStack: SwipeCardStack) -> Int {
      return HomeVM.shared.nearByCount()
     // return cardImages.count
  }

  func didSwipeAllCards(_ cardStack: SwipeCardStack) {
    print("Swiped all cards!")
      vwBgSwipe.isHidden = true
      vwBgInterest.isHidden = true
      vwBgUseDetail.isHidden = true
      vwEmpty.isHidden = false
  }

  func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
    //print("Undo \(direction) swipe on \(cardModels[index].name)")
     print("Undo \(direction)")
  }

    func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
        //print("Swiped \(direction) on \(cardModels[index].name)")
        //      print("card index",index)
        //      print("Swiped \(direction)")
        
        
        if direction.rawValue == 1{
            userLike(likeUserId: HomeVM.shared.getUserNameAge(indexPath: index).id)
        }else  if direction.rawValue == 0{
            userDislike(likeUserId: HomeVM.shared.getUserNameAge(indexPath: index).id)
        }
        
        if HomeVM.shared.nearByCount() > index{
            let indexx = (HomeVM.shared.nearByCount() - 1) - (index + 1)
            if indexx >= 0{
                print("bjj",cardIndex)
                cardIndex = indexx
                lbluserName.text = "\(HomeVM.shared.getUserNameAge(indexPath: indexx).name), \(HomeVM.shared.getUserNameAge(indexPath: indexx).age)"
                lblDistance.text = "\((Double(HomeVM.shared.getUserDistance(index: indexx)) ?? 0.0).roundToDecimal(2)) Km"
                self.interestClcVw.reloadData()
            }
            
        }else{
            print("all swiped")
        }
        
    }

    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
       
        if HomeVM.shared.nearByCount() > index{
            let indexx = (HomeVM.shared.nearByCount() - 1) - index
            if indexx >= 0{
                let vc = OtherProfileVC.getVC(.Home)
                vc.userId = HomeVM.shared.getUserNameAge(indexPath: indexx).id
                vc.delegate = self
                self.push(vc)
            }
        }
        
        
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

//MARK: API
extension HomeVC{
    
    func getNearBy(){
        HomeVM.shared.getNearBy(userId: UtilityManager.shared.userDecodedDetail().id, page: "0", pageSize: "100") { [weak self] (success, msg) in
            if success{
                self?.vwCard.reloadData()
                
                if HomeVM.shared.nearByCount() != 0{
                    self?.vwBgInterest.isHidden = false
                    self?.vwBgUseDetail.isHidden = false
                    self?.vwBgSwipe.isHidden = false
                    self?.vwEmpty.isHidden = true
                }else{
                    self?.vwBgInterest.isHidden = true
                    self?.vwBgUseDetail.isHidden = true
                    self?.vwBgSwipe.isHidden = true
                    self?.vwEmpty.isHidden = false
                    
                }
                
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    
    func userLike(likeUserId:String){
        LikesVM.shared.likeUser(likeUserId: likeUserId) { [weak self] (success,msg) in
            if success{
                self?.vwCard.swipe(.right, animated: true)
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
    func userDislike(likeUserId:String){
        LikesVM.shared.disLikeUser(likeUserId: likeUserId) { [weak self] (success,msg) in
            if success{
                self?.vwCard.swipe(.left, animated: true)
            }else{
                UtilityManager.shared.displayAlert(title: AppConstant.KOops, message: msg, control: ["OK"], topController: self ?? UIViewController())
            }
        }
    }
    
}
