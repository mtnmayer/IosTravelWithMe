//
//  ModelSql.swift
//  TravelMe
//
//  Created by admin on 13/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class ModelSql{
    
    var database: OpaquePointer? = nil
    
    init(){
        
        let dbFileName = "database2.db"
        if let dir = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask).first{
            let path = dir.appendingPathComponent(dbFileName)
            print(path.absoluteString)
            print(path)
            if sqlite3_open(path.absoluteString, &database) != SQLITE_OK {
                print("Failed to open db file: \(path.absoluteString)")
                return
            }
        }
        create()
        
    }
    
    func create(){
        
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        
        var res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS POSTS (POSTID TEXT PRIMARY KEY, TITLE TEXT,PLACE TEXT, DESCRIPTION TEXT, AVATAR TEXT, EMAIL TEXT)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
        
        
           res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS LAST_UPADATE_DATE (NAME TEXT PRIMARY KEY, DATE DOUBLE)", nil, nil, &errormsg);
          if(res != 0){
              print("error creating table");
              return
          }
    }
    
    func addPost(post:Post){
        
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO POSTS(POSTID, TITLE, PLACE, DESCRIPTION, AVATAR, EMAIL) VALUES (?,?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            let postId = post.postId!.cString(using: .utf8)
            let title = post.title.cString(using: .utf8)
            let place = post.place.cString(using: .utf8)
            let description = post.description.cString(using: .utf8)
            let avatar = post.avatar.cString(using: .utf8)
            let email = post.email.cString(using: .utf8)
            
            sqlite3_bind_text(sqlite3_stmt, 1, postId,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, title,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, place,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, description,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 5, avatar,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 6, email,-1,nil);
            
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
            }
        }
    }
    
    func getAllPosts()->[Post]{
        
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [Post]()
        if (sqlite3_prepare_v2(database,"SELECT * from POSTS;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                 let postId = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                let title = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                let place = String(cString:sqlite3_column_text(sqlite3_stmt,2)!)
                let description = String(cString:sqlite3_column_text(sqlite3_stmt,3)!)
                let avatar = String(cString:sqlite3_column_text(sqlite3_stmt,4)!)
                 let email = String(cString:sqlite3_column_text(sqlite3_stmt,5)!)
                
                data.append(Post(title: title, place: place, description: description, avatar: avatar, email: email))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
    
    func setLastUpdate(name:String, lastUpdated:Int64){
           var sqlite3_stmt: OpaquePointer? = nil
           if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO LAST_UPADATE_DATE( NAME, DATE) VALUES (?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){

               sqlite3_bind_text(sqlite3_stmt, 1, name,-1,nil);
               sqlite3_bind_int64(sqlite3_stmt, 2, lastUpdated);
               if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                   print("new row added succefully")
               }
           }
           sqlite3_finalize(sqlite3_stmt)
       }
    
    func getLastUpdateDate(name:String)->Int64{
        var date:Int64 = 0;
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"SELECT * from LAST_UPADATE_DATE where NAME like ?;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            sqlite3_bind_text(sqlite3_stmt, 1, name,-1,nil);

            if(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                date = Int64(sqlite3_column_int64(sqlite3_stmt,1))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return date
    }
    
    func delete(postId:String){
        let deleteStatementString = "DELETE FROM POSTS where PRIMARY KEY = \(postId);"
        print(deleteStatementString)
        print("DELETE FROM POSTS where POSTID = " + postId + ";")
        var sqlite3_stmt: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(database,"DELETE FROM POSTS where POSTID = \(postId);", -1, &sqlite3_stmt, nil) == SQLITE_OK) {
            sqlite3_bind_text(sqlite3_stmt, 1, postId, -1, nil)
          if sqlite3_step(sqlite3_stmt) == SQLITE_DONE {
            print("\nSuccessfully deleted row.")
          } else {
            print("\nCould not delete row.")
          }
        } else {
          print("\nDELETE statement could not be prepared")
        }
        
        sqlite3_finalize(sqlite3_stmt)
    }
}

