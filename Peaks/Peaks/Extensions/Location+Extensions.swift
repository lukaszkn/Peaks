//
//  Location+Extensions.swift
//  WalkStreets
//
//  Created by Lukasz on 02/04/2024.
//

import Foundation
import CoreLocation

#if DEBUG || RELEASE_RECORDING
extension CLLocation {
    static let przeworsk_maja3 = CLLocation(latitude: 50.062705, longitude: 22.495579)
    static let przeworsk_kollatajaNotValid = CLLocation(latitude: 50.061976, longitude: 22.494228)
    static let przeworsk_kollataja = CLLocation(latitude: 50.062716, longitude: 22.497908)
    static let przeworsk_krolowejJadwigi = CLLocation(latitude: 50.062623, longitude: 22.500447)
    static let przeworsk_krasickiego = CLLocation(latitude: 50.061628, longitude: 22.499850)
    static let przeworsk_staszica = CLLocation(latitude: 50.062981, longitude: 22.496033)
    
    static let notts1 = CLLocation(latitude: 52.947713, longitude: -1.145114) // station street
    static let notts2 = CLLocation(latitude: 52.949631, longitude: -1.145887) // sussex street
    static let notts3 = CLLocation(latitude: 52.949060, longitude: -1.145088) // trent street
    static let notts4 = CLLocation(latitude: 52.950491, longitude: -1.1464) // middle hill
    
    static let oakland1 = CLLocation(latitude: 37.8053, longitude: -122.2623) // lakeside drive
    static let oakland2 = CLLocation(latitude: 37.805259, longitude: -122.262580) //  19th str
    static let oakland3 = CLLocation(latitude: 37.800904, longitude: -122.262554) // lake merritt

    static let krakow1 = CLLocation(latitude: 50.055349, longitude: 19.934806) // podzamcze
    static let krakow2 = CLLocation(latitude: 50.056156, longitude: 19.933439) // plac na groblach
    static let krakow3 = CLLocation(latitude: 50.056703, longitude: 19.932439) // tarlowska
    static let krakow4 = CLLocation(latitude: 50.057178, longitude: 19.931678) // teńczyńska
}
#endif
