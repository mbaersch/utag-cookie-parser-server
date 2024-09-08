# UTAG Cookie Parser

**Custom Variable Template for server-side Google Tag Manager**

Gets the (Tealium) `utag_main` cookie value from incoming requests and returns single values from session info, all session info or all data with raw key names.

![Template Status](https://img.shields.io/badge/Community%20Template%20Gallery%20Status-submitted-orange) ![Repo Size](https://img.shields.io/github/repo-size/mbaersch/utag-cookie-parser-server) ![License](https://img.shields.io/github/license/mbaersch/utag-cookie-parser-server)

## Usage 
Add this template to your container and create a new variable with it.

Select what data to return as a variable value. 

### Single values
The template extracts the following session information from the cookie value. Select one to get a single string value: 

- `sessionId`
- `sesionStart`
- `sesionNumber`
- `sesionEvents`
- `sesionStartTimestamp`
- `clientId`

### Multiple values
Select **All Session Data** to get all of the above as an object. Example:

```
{
  sessionId: "1725753409086",
  sesionStart: false,
  sesionNumber: "1",
  sesionEvents: "3",
  sesionStartTimestamp: "1725753591209",
  clientId: "0191ceeb3e3d00016226de321c900506f001406700bd0"
}
```

If you need any other value (from custom dimensions), select **Raw (All Keys and values)** to get an object with all dats from the cookie. Session data will not have the key names from the example above, but their original identifiers. Example: 

```
{
  v_id: "0191ceeb3e3d00016226de321c900506f001406700bd0",
  _sn: "1",
  _se: "3",
  _ss: "0",
  _st: "1725753591209",
  ses_id: "1725753409086;exp-session",
  _pn: "1;exp-session",
  iframes_loaded: "true;exp-1725767810341",
  _ga: "0191ceeb3e3d00016226de321c900506f001406700bd0",
  dc_visit: "1",
  dc_event: "1;exp-session",
  dc_region: "eu-central-1;exp-session"
}
```

Tip: To extract a single value from the result, use a ["Ectract From JSON"](https://github.com/mbaersch/extract-json) variable. 