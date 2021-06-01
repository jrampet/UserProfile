//
//  userResponse.swift
//  Users
//
//  Created by jeyaram-pt4154 on 01/06/21.
//

import Foundation

struct userData:Codable{
    var id,lastName,firstName,email,title,picture : String
}
struct usersData:Codable{
    var data = [userData]()
}

/*{
      "id": "0F8JIqi4zwvb77FGz6Wt",
      "lastName": "Fiedler",
      "firstName": "Heinz-Georg",
      "email": "heinz-georg.fiedler@example.com",
      "title": "mr",
      "picture": "https://randomuser.me/api/portraits/men/81.jpg"
    },
*/
struct UserProfile:Codable{
    let id,phone,lastName,firstName,email,gender,title,picture,dateOfBirth : String
    let location : userlocation
}
struct userlocation:Codable{
    let state,street,city,country:String
}


/*
{
  "id": "0F8JIqi4zwvb77FGz6Wt",
  "phone": "0700-3090279",
  "lastName": "Fiedler",
  "firstName": "Heinz-Georg",
  "location": {
    "state": "Rheinland-Pfalz",
    "street": "4118, Schulstraße",
    "city": "Fellbach",
    "timezone": "-7:00",
    "country": "Germany"
  },
  "email": "heinz-georg.fiedler@example.com",
  "gender": "male",
  "title": "mr",
  "registerDate": "2020-03-07T00:42:32.221Z",
  "picture": "https://randomuser.me/api/portraits/men/81.jpg",
  "dateOfBirth": "1974-03-12T21:15:08.878Z"
}*/
