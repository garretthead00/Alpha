//
//  HealthKitAPI.swift
//  Alpha
//
//  Created by Garrett Head on 12/2/20.
//  Copyright © 2020 Garrett Head. All rights reserved.
//

import Foundation
import HealthKit

let HKUNIT_IDENTIFIER_DICTIONARY : [String : HKUnit] = [
    "sleepMinutes": HKUnit.minute(),
    "mindfulMinutes": HKUnit.minute(),
    "energyBurned": HKUnit.kilocalorie(),
    "steps" : HKUnit.count()
]

let HKSAMPLETYPE_IDENTIFIER_DICTIONARY : [String : HKCategoryTypeIdentifier] = [
    "sleepMinutes": .sleepAnalysis,
    "mindfulMinutes": .mindfulSession
]

let HKQUANTITY_IDENTIFIER_DICTIONARY : [String : HKQuantityTypeIdentifier] = [
    "energyBurned": .activeEnergyBurned,
    "steps" : .stepCount
]

class HealthKitAPI {
    
    
    class func getSum(forIdentifier id: String, completion: @escaping (Double?, Error?) -> Void){

        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: [])
        let identifier = HKSAMPLETYPE_IDENTIFIER_DICTIONARY[id]!
        guard let hkType = HKObjectType.categoryType(forIdentifier: identifier) else {
            print("*** Unable to create a healthKit type ***")
            fatalError("*** Unable to create a healthKit type ***")
        }
        
        let query = HKSampleQuery(sampleType: hkType, predicate: predicate, limit: 0, sortDescriptors: [sortDescriptor]) { (query, result, error) in
            DispatchQueue.main.async {
                guard let result = result else {
                    completion(nil, error)
                    return
                }
                var sum = 0.0
                for item in result {
                    if let sample = item as? HKCategorySample {
                        //let value = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
                        let sleepMinutes = sample.endDate.timeIntervalSince(sample.startDate) / 60
                        sum += sleepMinutes
                    }
                }
                completion(sum, nil)
            }
        }
        HKHealthStore().execute(query)
    }
    
    class func getSumQuantity(forIdentifier id: String, completion: @escaping (Double?, Error?) -> Void){
        let identifier = HKQUANTITY_IDENTIFIER_DICTIONARY[id]!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        guard let hkType = HKSampleType.quantityType(forIdentifier: identifier) else {
            print("*** Unable to create a \(identifier) type ***")
            fatalError("*** Unable to create a \(identifier) type ***")
        }
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: [])
        let query = HKStatisticsQuery(quantityType: hkType, quantitySamplePredicate: predicate, options: .cumulativeSum) {
            (query, result, error) in
            DispatchQueue.main.async {
                guard let result = result, let sum = result.sumQuantity() else {
                    completion(nil, error)
                    return
                }
                completion(sum.doubleValue(for: HKUNIT_IDENTIFIER_DICTIONARY[id]!), nil)
            }
        }
        HKHealthStore().execute(query)
    }
}
