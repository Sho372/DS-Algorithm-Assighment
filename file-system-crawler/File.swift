import Foundation
import Glibc

let fm = FileManager.default

/*
    check whether the path exists or not
*/

func isPathExist(_ pathStr:String) -> Bool {
    let url = URL(string: pathStr)
    if let u = url {
        return fm.fileExists(atPath: u.path)
    } else {
        return false
    }
}

print("------------------")
print("isPathExist(pathStr)")
print("------------------")

let path1 = ""
print("'\(path1)': \(isPathExist(path1))") // false
let path2 = "/home/shouhei/Documents/19-CICCC/swifty/DS-Algorithms-Assighment/file-system-crawler/File.swift"
print("'\(path2)': \(isPathExist(path2))") // file  ->  true
let path3 = "/home/shouhei/Documents/19-CICCC/swifty/DS-Algorithms-Assighment/file-system-crawler"
print("'\(path3)': \(isPathExist(path3))") // directory(not empty)  ->  false
let path4 = "/home/shouhei/Documents/19-CICCC/swifty/DS-Algorithms-Assighment/file-system-crawler/empty"
print("'\(path4)': \(isPathExist(path4))") // directory(empty)  ->  false

let path5 = "file:///home/shouhei/Documents/19-CICCC/swifty/DS-Algorithms-Assighment/file-system-crawler/File.swift"
print("'\(path5)': \(isPathExist(path5))")
let path6 = "file:///home/shouhei/Documents/19-CICCC/swifty/DS-Algorithms-Assighment/file-system-crawler"
print("'\(path6)': \(isPathExist(path6))")
let path7 = "file:///home/shouhei/Documents/19-CICCC/swifty/DS-Algorithms-Assighment/file-system-crawler/empty"
print("'\(path7)': \(isPathExist(path7))")



print("")

/*
    check if the path is a file or a directory
*/

func isDirectory(_ pathStr: String) -> Bool {
    let url = URL(string: pathStr)
    guard let u = url else {
        return false
    }

    var isDir : ObjCBool = false
    if fm.fileExists(
        atPath: u.path,
        isDirectory: &isDir
    ) {// file or directory exist in this path
        if isDir.boolValue {
            // This path is directory
            return true
        } else {
            // This path is file
            return false
        }
    } else {
            // This path dosen't exist
            return false
    }
}

print("------------------")
print("isDirectory(pathStr)")
print("------------------")

print("'\(path1)': \(isDirectory(path1))") // false
print("'\(path2)': \(isDirectory(path2))") // file  ->  false
print("'\(path3)': \(isDirectory(path3))") // directory(not empty)  ->  true
print("'\(path4)': \(isDirectory(path4))") // directory(empty)  ->  true
print("")


/*
    get a file name
*/

func getFileName(_ pathStr: String) -> String? {
    let url = URL(string: pathStr)
    guard let u = url else {
        return nil
    }
    return u.lastPathComponent
}

print("------------------")
print("getFileName(pathStr)")
print("------------------")

print("'\(path2)': \(String(getFileName(path2)!))") // file  ->  false
print("'\(path3)': \(String(getFileName(path3)!))") // directory(not empty)  ->  true
print("'\(path4)': \(String(getFileName(path4)!))") // directory(empty)  ->  true
print("")


/*
    get a list of files in a specified direcotry
*/
func getListOfFiles(_ pathStr: String) -> [URL] {
    let url = URL(string: pathStr)
    guard let u = url else {
        return []
    }

    do {
        let fileUrls = try fm.contentsOfDirectory(at: u, includingPropertiesForKeys: [])
        return fileUrls
    } catch  {
        print("Error while enumerating files \(u.path): \(error.localizedDescription)")
    }
    return []
}

print("------------------")
print("getListOfFiles(pathStr)")
print("------------------")

print("'\(path2)': \(getListOfFiles(path2))") // file  -> []
print("'\(path3)': \(getListOfFiles(path3))") // directory(not empty)  ->  [file:///home/shouhei/Documents/19-CICCC/swifty/DS-Algorithms-Assighment/file-system-crawler/empty/, file:///home/shouhei/Documents/19-CICCC/swifty/DS-Algorithms-Assighment/file-system-crawler/File.swift]
print("'\(path4)': \(getListOfFiles(path4))") // directory(empty)  ->  []
print("")


