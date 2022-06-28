import Foundation

public enum UnitType: String {
    case imperial = "Imperial"
    case metric   = "Metric"
    
    var dateFormat: DateFormatter.Format {
        switch self {
        case .imperial:
            return .imperial
        case .metric:
            return .metric
        }
    }
}

public class UnitManager {

    ///default unit system used by the user's phone
    private static var defaultUnitSystem: UnitType {
        let locale = NSLocale.current
        if locale.usesMetricSystem {
            return .metric
        }

        return .imperial
    }

    //changing this property will affect the entire application.
    ///current unit system used by the app
    public static var currentUnitType: UnitType? {
        get {
            guard let unitString = UserDefaults.standard.string(forKey:UserDefaultsKeys.currentUnitSystem) else {
                return UnitManager.defaultUnitSystem
            }
            
            return UnitType(rawValue: unitString) ?? UnitManager.defaultUnitSystem
        }
        set {
            guard let newValue = newValue else { return }
            
            UserDefaults.standard.set(newValue.rawValue, forKey: UserDefaultsKeys.currentUnitSystem)
        }
    }

    public static func convertNewtonToString(value: Double, to unit: UnitType = UnitManager.currentUnitType ?? .imperial) -> String {
        switch unit {
        case .imperial:
            return "\(self.convertNewtonToPounds(value: value)) \("lb".localized)"
            
        case .metric:
            return "\(convertNewtonToKg(value: value)) \("kg".localized)"
        }
    }
    
    public static func convertNewton(value: Double, to unit: UnitType = UnitManager.currentUnitType ?? .imperial) -> Double {
        switch unit {
        case .imperial:
            return self.convertNewtonToPounds(value: value)
            
        case .metric:
            return self.convertNewtonToKg(value: value)
            
        }
    }

    public static func convertNewtonToPounds(value: Int) -> Int {
        return Int((Double(value) * 0.22481).rounded())
    }
    
    public static func convertNewtonToKg(value: Int) -> Int {
        return Int((Double(value) * 0.10197162).rounded())
    }
    
    public static func convertNewtonToPounds(value: Double) -> Double {
        return value * 0.22481
    }
    
    public static func convertNewtonToKg(value: Double) -> Double {
        return value * 0.10197162
    }

    public static func convertCmToInches(value: Int) -> Double {
        let unit = Measurement(value: Double(value), unit: UnitLength.centimeters)
        return unit.converted(to: .inches).value
    }

    public static func convertInchesToCm(value: Int) -> Double {
        let unit = Measurement(value: Double(value), unit: UnitLength.inches)
        return unit.converted(to: .centimeters).value
    }

    public static func convertLbsToKg(value: Int) -> Double {
        let unit = Measurement(value: Double(value), unit: UnitMass.pounds)
        return unit.converted(to: .kilograms).value

    }

    public static func convertKgToLbs(value: Int) -> Double {
        let unit = Measurement(value: Double(value), unit: UnitMass.kilograms)
        return unit.converted(to: .pounds).value
    }
    
    public static func convertKgToNewtons(value: Double) -> Double {
        return value/0.10197162
    }
    
    public static func convertLbsToNewtons(value: Double) -> Double {
        return value/0.22481
    }

    public static func convertDate(date: String, to unit: UnitType = UnitManager.currentUnitType ?? .imperial) -> String {
        
        if let date = Date(iso: date) {
            return date.string(format: unit.dateFormat)
        }

        return ""
    }

    public static func dateToDBString(_ date: Date) -> String {
        date.isoString
    }

    public static func convertLbs(value: Int, to unit: UnitType) -> String {
        switch unit {
        case .imperial:
            return "\(value) \("lbs".localized)"

        case .metric:
            let kilos = Int(self.convertLbsToKg(value: value))
            return "\(kilos) \("kg".localized)"

        }
    }

    ///Parses value from the server to a string ex 71 inches the output will be  5' 11
    public static func convertInches(value: Int, to unit: UnitType = UnitManager.currentUnitType ?? .imperial) -> String {
        let inches = Measurement(value: Double(value), unit: UnitLength.inches)

        switch unit {
        case .imperial:
            let ft = value / 12
            let inches = value % 12

            return "\(ft)’\(inches)” \("ft".localized)"

        case .metric:
            return "\(Int(inches.converted(to: .centimeters).value)) \("cm".localized)"
        }
    }

    ///Converts current value in grams to current unit system
    public static func convertGrams(with value: Double, unitSystem: UnitType = UnitManager.currentUnitType ?? .imperial) -> Double {
        switch unitSystem {

        case .imperial:
            return (value / 454).rounded()

        case .metric:
            return (value / 1000).rounded()
        }
    }

    ///converts current value to grams
    public static func convertToGrams(value: Double, unitSystem: UnitType = UnitManager.currentUnitType ?? .imperial) -> Double {
        switch unitSystem {

        case .imperial:
            return (value * 454).rounded()

        case .metric:
            return (value * 1000).rounded()
        }
    }

    ///Converts millimeters to the current unit system.
    public static func convertMillimeters(with value: Double, unitSystem: UnitType = UnitManager.currentUnitType ?? .imperial) -> Double {
        switch unitSystem {

        case .imperial:
            return (value / 25.4).rounded()

        case .metric:
            return (value / 10).rounded()
        }
    }

     ///converts current value to millimeters
    public static func convertToMillimeters(value: Double, unitSystem: UnitType = UnitManager.currentUnitType ?? .imperial) -> Double {
        switch unitSystem {
        case .imperial:
            return (value * 25.4).rounded()

        case .metric:
            return (value * 10).rounded()
        }
    }

    public static func convertSecondsToMinutes(_ seconds: Int) -> String {
        let secondsValue = String((seconds % 3600) % 60)
        let minutesValue = String((seconds % 3600) / 60)

        return "\((minutesValue == "0") ? "00" : minutesValue):\((secondsValue == "0") ? "00" : secondsValue)"
    }
}

extension UnitManager {
    enum UserDefaultsKeys {
        static let currentUnitSystem = "CurrentUnitSystem"
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
