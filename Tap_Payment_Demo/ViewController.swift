//
//  ViewController.swift
//  Tap_Payment_Demo
//
//  Created by ahmed on 11/04/2022.
//

import UIKit
import goSellSDK

class ViewController: UIViewController {
    var productsNum:Int? = 0
    var ticketssNum:Int? = 0
    var totalNum = 30
    let email = "Devahmedemad1@gmail.com"
    var phone = "26941519"
    let firstName = "Ahmed"
    let lastName = "Emad"
    
    @IBOutlet weak var payButton: PayButton!
    
    internal var selectedPaymentItem: PaymentItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        payButton.dataSource = self
        payButton.delegate = self
        payButton.appearance = self
        GoSellSDK.language = "ar"
        GoSellSDK.mode = .sandbox
        self.payButton?.updateDisplayedState()
        self.title = "Tap Payment"
    }
    
}

extension ViewController: SessionDataSource,SessionDelegate,SessionAppearance {
    var currency: Currency? {
        
        return .with(isoCode: "AED")
    }
    var amount: Decimal {
        let amount = self.totalNum
        return Decimal(amount)
    }
    
    var mode: TransactionMode {
        return .purchase
    }
    
    var customer: Customer? {
        return self.newCustomer
    }
    

    
    /// Creating a customer with raw information.
    var newCustomer: Customer? {
        let emailAddress = try! EmailAddress(emailAddressString: self.email)
        let myPhone = self.phone
        let phoneNumber = try! PhoneNumber(isdNumber: "971", phoneNumber: myPhone)
        return try! Customer(emailAddress: emailAddress, phoneNumber: phoneNumber, firstName: self.firstName, middleName: "", lastName: self.lastName)
    }
    
    
    var postURL: URL? {
        return URL(string: "https://tap.company/post")
    }
    
    
    
    var paymentDescription: String? {
        return "Awesome payment description will be here.";
    }
    
    var buttonTitle: String? {
        return "PAY";
    }
    
    func paymentSucceed(_ charge: Charge, on session: SessionProtocol){
        if (charge.receiptSettings?.identifier) != nil {
//            print(charge.transactionDetails.authorizationID!)
//            print(charge.receiptSettings!.identifier!)
        }
        print("payment succesful done")
    }
    
    func paymentFailed(with charge: Charge?, error: TapSDKError?, on session: SessionProtocol){
        print("Error :: ",error?.localizedDescription ?? "")
        print(error?.localizedDescription ?? "")
    }
    
    func authorizationSucceed(_ authorize: Authorize, on session: SessionProtocol) {
        
        // authorization succeed, saving the customer for reuse.
        if let customerID = authorize.customer.identifier {
            print(customerID)
        }
    }
    
    
    func authorizationFailed(with authorize: Authorize?, error: TapSDKError?, on session: SessionProtocol)
    
    {
        print("Error authorizationFailed:: ",error?.localizedDescription ?? "")
    }
    
    
    func sessionIsStarting(_ session: SessionProtocol)
    {
        print("sessionIsStarting")
    }
    
    func sessionHasStarted(_ session: SessionProtocol)
    {
        print("sessionHasStarted")
        
    }
    
    func sessionHasFailedToStart(_ session: SessionProtocol)
    {
        print("sessionHasFailedToStart")
    }
    
    func sessionCancelled(_ session: SessionProtocol)
    {
        print("sessionCancelled")
    }
    
    
    
}
