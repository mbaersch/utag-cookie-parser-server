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
    "type": "TEXT",
    "name": "cookieValue",
    "displayName": "Cookie value to parse",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
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
        "value": "all",
        "displayValue": "All (Object)"
      }
    ],
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_SERVER___

const cVal = data.cookieValue;

var vals = cVal.split("$");
var isSessionStart = false;
var sessionNumber = 0;
var sessionId = "";
var clientId = "";

vals.forEach( x => {
  if (x.indexOf("_ss:") == 0) {
    isSessionStart = (x==="_ss:1"); 
  } 
  if (x.indexOf("_sn:") == 0) {
    sessionNumber = x.split(":")[1]; 
  } 
  if (x.indexOf("ses_id:") == 0) {
    sessionId = x.split(":")[1].split(";")[0]; 
  } 
  if (x.indexOf("v_id:") == 0) {
    clientId = x.split(":")[1]; 
  } 
});

if (data.returnValue === "all")
  return {"sessionId" : sessionId,
          "sesionStart": isSessionStart,
          "sesionNumber": sessionNumber,
          "clientId": clientId,
         };

if (data.returnValue === "sid") return sessionId;
if (data.returnValue === "sn") return sessionNumber;
if (data.returnValue === "ss") return isSessionStart;
if (data.returnValue === "cid") return clientId;


___TESTS___

scenarios: []


___NOTES___

Created on 8.2.2024, 16:11:49


