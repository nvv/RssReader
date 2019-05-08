//
//  RssParser.swift
//  RssReader
//
//  Created by Vlad Namashko on 4/20/19.
//  Copyright © 2019 Vlad Namashko. All rights reserved.
//

import Foundation

class XmlParser : NSObject, XMLParserDelegate {

    private var currentNode: XmlNode?

    private var rootNode: XmlNode?
    
    func parse(xml: String) -> XmlNode? {
        let parser = XMLParser(data: xml.data(using: .utf8)!)
        parser.delegate = self
        
        parser.parse()
        return rootNode
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        let node = XmlNode()
        node.name = elementName
        node.attributes = attributeDict
        
        currentNode?.addChild(node)
        currentNode = node
        
        if rootNode == nil {
            rootNode = node
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentNode = currentNode?.parentNode
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            currentNode?.value = string
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
    }
}

class XmlNode {
    
    //MARK: Properties
    var name : String = ""
    var value : String?
    var attributes: [String:String]?
    private var childrenMap: [String:[XmlNode]]?
    fileprivate var parentNode: XmlNode?
    
    //MARK: Methods
    fileprivate func addChild(_ node: XmlNode) {
        if childrenMap == nil {
            childrenMap = [:]
        }
        
        let childList = childrenMap?[node.name]
        if childList == nil {
            childrenMap?[node.name] = []
        }
        childrenMap?[node.name]?.append(node)
        
        node.parentNode = self
    }
    
    func getChild(_ name: String) -> XmlNode? {
        return childrenMap?[name]?.first
    }
    
    func getChildren(_ name: String) -> [XmlNode]? {
        return childrenMap?[name]
    }
}
