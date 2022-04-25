//
//  FileManager.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 21.11.2021.
//

import Foundation

class FileManagerInteractor{
    func readFile() -> UserModel? {
        var fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        fileURL = fileURL.appendingPathComponent("User.txt")
        print(fileURL)
        do {
            let savedData = try Data(contentsOf: fileURL)
            let jsonStr = try JSONDecoder().decode(UserModel.self, from: savedData)
            return jsonStr
        } catch {
            print("Unable to read the file")
        }
        return nil
    }

    func createAccount(login: String, password: String) {
        let user: [String: String] = [
            "login": login,
            "password": password
        ]
        let jsonData: Data
        do {
            jsonData = try JSONSerialization.data(withJSONObject: user, options: .withoutEscapingSlashes) as Data
            writeToFile(data: jsonData)
        } catch {
            assertionFailure("Unable to create json with error \(error.localizedDescription)")
        }
    }

    func writeToFile(data: Data) {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = URL(fileURLWithPath: "User", relativeTo: directoryURL).appendingPathExtension("txt")
        print(fileURL)
        do{
            try data.write(to: fileURL)
            print("Data written")
        } catch {
            assertionFailure("Error while writing to file \(error.localizedDescription)")
        }
    }
}
