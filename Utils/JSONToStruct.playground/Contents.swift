import Cocoa
import PlaygroundSupport

typealias LocalizeSource = [String: [String:String]]

let structHeader = "class LocalizeHelper {\n\n\tstatic let shared = LocalizeHelper()\n\n\tlet strings = stringsStruct()\n\n\tstruct stringsStruct {\n"

let structFooter = "\t}\n}"

func createLocalizeStrElem(sourceKey: String) -> String {
    return "\t\tvar \(sourceKey): String {\n\t\t\treturn WeeLocalizeManager.shared.getString(fromIdentifier: \"\(sourceKey)\")\n\t\t}\n"
}

struct LocalizeSettings: Codable {
    var default_language: String
    var available_languages: [LocalizeAvailableLanguage]
}

struct LocalizeAvailableLanguage: Codable {
    var key: String
    var value: String
}

struct LocalizeJSONContent: Codable {
    let localize_settings: LocalizeSettings
    let localize_strings: LocalizeSource
}

let fileURL = Bundle.main.url(forResource: "localize", withExtension: "json")

let data = try Data(contentsOf: fileURL!)

let content = try! JSONDecoder().decode(LocalizeJSONContent.self, from: data)

let sources = content.localize_strings

var resultStr = structHeader
for elem in sources {
    resultStr.append(createLocalizeStrElem(sourceKey: elem.key))
}
resultStr.append(structFooter)

let saveUrl = playgroundSharedDataDirectory.appendingPathComponent("LocalizeHelper.swift")

try! resultStr.write(to: saveUrl, atomically: true, encoding: .utf8)
