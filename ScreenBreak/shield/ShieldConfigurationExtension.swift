//
//  ShieldConfigurationExtension.swift
//  shield
//
//  Created by Christian Pichardo on 4/8/23.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit

// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    
    let title = "ScreenBreak"
    let body = "You have restricted usage of this application. Wait for the time limit to end."
    
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        // Customize the shield as needed for applications.
        return ShieldConfiguration(
            backgroundBlurStyle: UIBlurEffect.Style.light,
            backgroundColor: UIColor.gray,
            icon: UIImage(named: "sblogosmall.png"),
            title: ShieldConfiguration.Label(text: title, color: .white),
            subtitle: ShieldConfiguration.Label(text: body, color: .white),
            primaryButtonLabel: ShieldConfiguration.Label(text: "Close", color: UIColor.black),
            primaryButtonBackgroundColor: .white,
            secondaryButtonLabel: nil)
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for applications shielded because of their category.
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        ShieldConfiguration()
    }
}
