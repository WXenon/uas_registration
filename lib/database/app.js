var logging = require('adal-node').Logging;
var express = require('express');
var crypto = require('crypto');
var AuthenticationContext = require('adal-node').AuthenticationContext;

var clientId = '11bad5e4-db65-4a2f-b8e5-24e93e232ff5';
var clientSecret = 'hAGbZX/urBGDVoCaE?Ja--Rht9l81QX8'
var authorityHostUrl = 'https://login.microsoftonline.com/organizations';
var tenant = 'fc418f16-5c93-437d-b743-05e9e2a04d93';
var authorityUrl = authorityHostUrl + '/' + tenant;
var redirectUri = 'http://localhost:3000/token'; // TODO: 1) Change this with the actual production URL
var resource = '00000002-0000-0000-c000-000000000000';
var templateAuthzUrl = 'https://login.windows.net/' +
  tenant +
  '/oauth2/authorize?response_type=code&client_id=' +
  clientId +
  '&redirect_uri=' +
  redirectUri +
  '&scope=api://70ae9620-bbbf-4a83-92cd-198eb3ed3d29/signin' +
  '&state=<state>' + '&grant_type=authorization_code';


//PII or OII logging disabled. Default Logger does not capture any PII or OII.
logging.setLoggingOptions({
  log: function (level, message, error) {
    // provide your own implementation of the log function
    console.log(message);
    console.log(error);
  },
  level: logging.LOGGING_LEVEL.VERBOSE, // provide the logging level
  loggingWithPII: false  // Determine if you want to log personal identification information. The default value is false.
});

//PII or OII logging enabled.
logging.setLoggingOptions({
  log: function (level, message, error) {
    // provide your own implementation of the log function
    console.log(message);
    console.log(error);
  },
  level: logging.LOGGING_LEVEL.VERBOSE,
  loggingWithPII: true
});

var app = express();

function createAuthorizationUrl(state) {
  return templateAuthzUrl.replace('<state>', state);
}

// Clients get redirected here in order to create an OAuth authorize url and redirect them to AAD.
// There they will authenticate and give their consent to allow this app access to
// some resource they own.
app.get('/auth', function (req, res) {
  crypto.randomBytes(48, function (ex, buf) {
    var token = buf.toString('base64').replace(/\//g, '_').replace(/\+/g, '-');

    res.cookie('authstate', token);
    var authorizationUrl = createAuthorizationUrl(token);

    res.redirect(authorizationUrl);
  });
});

// After consent is granted AAD redirects here.  The ADAL library is invoked via the
// AuthenticationContext and retrieves an access token that can be used to access the
// user owned resource.
app.get('/token', function (req, res) {
  if (req.cookies.authstate !== req.query.state) {
    res.send('error: state does not match');
  }

  var authenticationContext = new AuthenticationContext(authorityUrl);

  authenticationContext.acquireTokenWithAuthorizationCode(
    req.query.code,
    redirectUri,
    resource,
    clientId,
    clientSecret,
    function (err, response) {
      var errorMessage = '';
      if (err) {
        errorMessage = 'error: ' + err.message + '\n';
      }
      errorMessage += 'response: ' + JSON.stringify(response);
      res.send(errorMessage);
    }
  );
});

app.listen(3000);