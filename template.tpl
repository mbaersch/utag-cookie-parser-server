___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "UTAG Cookie Parser",
  "categories": [
    "UTILITY"
  ],
  "description": "Parses the utag_main cookie from Tealium and returns single values from session info, all session info or all data with raw key names.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "returnValue",
    "displayName": "Value to return",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "sid",
        "displayValue": "Session ID"
      },
      {
        "value": "ss",
        "displayValue": "Session Start Marker"
      },
      {
        "value": "sn",
        "displayValue": "Session Number"
      },
      {
        "value": "cid",
        "displayValue": "Client ID"
      },
      {
        "value": "se",
        "displayValue": "Session Event Count"
      },
      {
        "value": "st",
        "displayValue": "Session Start Timestamp"
      },
      {
        "value": "all",
        "displayValue": "All Session Data"
      },
      {
        "value": "raw",
        "displayValue": "Raw (All Keys and values)"
      }
    ],
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_SERVER___

const cVal = data.cookieValue;

let vals = (require('getCookieValues')('utag_main')[0]||"").split("$");
let isSessionStart = false;
let sessionNumber = 0;
let sessionId = "";
let clientId = "";
let sessionEvents = "";
let sessionTs = "";

if (data.returnValue === "raw") {

  let res = {};
  vals.forEach( x => {
    let parts = x.split(":"); 
    res[parts[0]] = parts[1];
  });
  
  return res;

} else {

  vals.forEach( x => {
    if (x.indexOf("_ss:") == 0) {
      isSessionStart = (x==="_ss:1"); 
    } else if (x.indexOf("_sn:") == 0) {
      sessionNumber = x.split(":")[1]; 
    } else if (x.indexOf("_se:") == 0) {
      sessionEvents = x.split(":")[1]; 
    } else if (x.indexOf("_st:") == 0) {
      sessionTs = x.split(":")[1]; 
    } else if (x.indexOf("ses_id:") == 0) {
      sessionId = x.split(":")[1].split(";")[0]; 
    } else if (x.indexOf("v_id:") == 0) {
      clientId = x.split(":")[1]; 
    } 
  });

  if (data.returnValue === "all")
    return {"sessionId" : sessionId,
            "sesionStart": isSessionStart,
            "sesionNumber": sessionNumber,
            "sesionEvents": sessionEvents,
            "sesionStartTimestamp": sessionTs,
            "clientId": clientId,
           };

  else if (data.returnValue === "sid") return sessionId;
  else if (data.returnValue === "sn") return sessionNumber;
  else if (data.returnValue === "ss") return isSessionStart;
  else if (data.returnValue === "cid") return clientId;
}


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "utag_main"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 8.2.2024, 16:11:49


