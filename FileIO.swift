import Foundation

// Constant for the input file name
let inputFile = "./input.txt"

// Constant for the output file name
let outputFile = "./output.txt"

// Error cases for invalid data
enum DataError: Error {
    case invalidNumber
    case fileError
}

// Function to process a line of text and return either sum or error message
func processLine(_ line: String) -> String {
    let splitData = line.split(separator: " ")
    var lineSum = 0
    
    for token in splitData {
        if let number = Int(token) {
            lineSum += number
        } else {
            return "Error: line contains string"
        }
    }
    return String(lineSum)
}

// Main program function
func main() {
    // Get input file
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        print("Error: Cannot open input file.")
        exit(1)
    }

    // Create or overwrite output file
    FileManager.default.createFile(atPath: outputFile, contents: nil, attributes: nil)
    guard let output = FileHandle(forWritingAtPath: outputFile) else {
        print("Error: Cannot open output file.")
        exit(1)
    }

    // Read entire contents of input file
    let inputData = input.readDataToEndOfFile()
    
    // Convert data to string
    guard let _ = String(data: inputData, encoding: .utf8) else {
        print("Error: Cannot convert to string.")
        exit(1)
    }
    
    // Process contents of input file (split by newline ASCII 10)
    var result = ""
    for line in inputData.split(separator: 10) {
        if let lineString = String(data: line, encoding: .utf8) {
            result += "\(processLine(lineString))\n"
        }
    }

    // Write results to output
    if let data = result.data(using: .utf8) {
        output.write(data)
    }
    
    // Close files
    input.closeFile()
    output.closeFile()
}

// Run program
main()
