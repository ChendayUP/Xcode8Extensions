//
//  SourceEditorCommand.swift
//  DuplicateLine
//
//  Created by Krzysztof Romanowski on 18.06.2016.
//  Copyright © 2016 Krzysztof Romanowski. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    /** Perform the action associated with the command using the information in \a invocation. Xcode will pass the code a completion handler that it must invoke to finish performing the command, passing nil on success or an error on failure.
     
     A canceled command must still call the completion handler, passing nil.
     
     \note Make no assumptions about the thread or queue on which this method will be invoked.
     */
    
    public func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
        
        let buffer = invocation.buffer
        
        guard let selection = buffer.selections.firstObject as? XCSourceTextRange else {
            completionHandler(NSError(domain: "DuplicateLine", code: -1, userInfo: [NSLocalizedDescriptionKey: "No selection"]))
            return
        }
        
        // TODO:判断是不是选择了多行
        
        // TODO:1 多行就是复制选择的行
        // 2 单行判断选没有选中文字 YES 复制选中的文字 NO 复制当前行
        
        var padding = 0
        for index in selection.start.line...selection.end.line {
            buffer.lines.insert(buffer.lines[index + padding], at: selection.start.line)
            padding = padding + 1
        }
        for index in selection.start.line...selection.end.line {
            buffer.lines.insert(buffer.lines[index + padding], at: selection.start.line)
            padding = padding + 1
        }
        
        completionHandler(nil)
    }
    
}
