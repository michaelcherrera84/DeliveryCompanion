//
//  Address.swift
//  DeliveryCompanion
//
//  Created by Michael C. Herrera on 7/7/25.
//

import Foundation
import SwiftData

@Model
class Address: Identifiable {
    var deliveries: [Delivery]? = [Delivery]()
    var neighborhood: String = ""
    var num: String = ""
    var street1: String = ""
    var street2: String = ""
    var city: String = ""
    var state: String = ""
    var zip: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0

    init(
        deliveries: [Delivery]? = nil,
        neighborhood: String,
        num: String,
        street1: String,
        street2: String,
        city: String,
        state: String,
        zip: String,
        latitude: Double,
        longitude: Double
    ) {
        self.deliveries = deliveries
        self.neighborhood = neighborhood
        self.num = num
        self.street1 = street1
        self.street2 = street2
        self.city = city
        self.state = state
        self.zip = zip
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Address {
    var fullAddress: String {
        [
            num,
            street1,
            street2,
            city,
            state,
            zip,
        ]
        .compactMap { $0 }
        .joined(separator: " ")
    }
}

extension Address {

    /// Attempts to find an existing `Address` in the given `ModelContext` that exactly matches
    /// the provided address fields.
    ///
    /// This is used to prevent duplicate address entries by comparing street number,
    /// street name(s), city, state, and ZIP code.
    ///
    /// - Parameters:
    ///   - num: The street number (e.g., "123").
    ///   - street1: The primary street name (e.g., "Main St").
    ///   - street2: Secondary street info like apartment or suite (e.g., "Apt 4B").
    ///   - city: The city name.
    ///   - state: The two-letter state abbreviation (or full name).
    ///   - zip: The ZIP or postal code.
    ///   - context: The current `ModelContext` used to query the SwiftData model.
    /// - Returns: The first matching `Address` found, or `nil` if no match exists.
    static func findExistingAddress(
        num: String,
        street1: String,
        street2: String,
        city: String,
        state: String,
        zip: String,
        in context: ModelContext
    ) -> Address? {
        
        // Build a SwiftData predicate to match an existing address
        let predicate = #Predicate<Address> {
            $0.num == num && $0.street1 == street1 && $0.street2 == street2
                && $0.city == city && $0.state == state && $0.zip == zip
        }
        
        // Wrap the predicate in a FetchDescriptor to perform the query
        let fetchDescriptor = FetchDescriptor<Address>(predicate: predicate)

        do {
            // Attempt to fetch matching addresses from the context
            let addresses = try context.fetch(fetchDescriptor)
            return addresses.first
        } catch {
            // If an error occurs, log it and return nil
            print("Error fetching address: \(error)")
            return nil
        }
    }
}
