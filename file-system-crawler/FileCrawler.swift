import Foundation
import Glibc

let fm = FileManager.default
var dirCnt = 0
var fileCnt = 0
/*
    check if the path exists or not
*/

func isPathExist(_ pathStr:String) -> Bool {
    let url = URL(string: pathStr)
    if let u = url {
        return fm.fileExists(atPath: u.path)
    } else {
        return false
    }
}

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


func fileCrawlerHelper(pathStr: String, indent: String) {

    if(!isPathExist(pathStr)) {
        print("The path doesn't exist.")
    }

    let fileURLs = getListOfFiles(pathStr)

    // recursive section
    // dirctory with files
    for i in 0..<fileURLs.count {
            let path = fileURLs[i].path
            if isDirectory(path) {
                if let dir = getFileName(path) {
                    dirCnt += 1
                    if i == fileURLs.count - 1 {
                        print(indent + "└─" + dir)
                        fileCrawlerHelper(pathStr: path, indent: "\(indent)    ")
                } else {
                        print(indent + "├─" + dir)
                        fileCrawlerHelper(pathStr: path, indent: "\(indent)│     ")
                }
            } 
        } else if let file = getFileName(path) {
            fileCnt += 1
            if i == fileURLs.count - 1 {
                print(indent + "└─" + file)
            } else {
                print(indent + "├─" + file)
            }
        }
    }
}
func fileCrawler(_ pathStr: String) {
    fileCrawlerHelper(pathStr: pathStr, indent: "")
    print("\(dirCnt) directories, \(fileCnt) files")
}

// File.swift
let path1 = "file:///home/shouhei/Documents/19-CICCC/swifty/DS-Algorithms-Assighment/file-system-crawler/File.swift"
// dir1
let path2 = "/home/shouhei/Documents/19-CICCC/swifty/DS-Algorithms-Assighment/file-system-crawler/dir1"
let path3 = "/home/shouhei/Documents/19-CICCC/swifty"

fileCrawler(path2)
