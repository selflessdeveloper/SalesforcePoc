({  init : function(component, event, helper) {
    //first get the configuration. throw error if the records are not found.
    //second get the files associated to the records.
    component.set("v.loadStatus","loading");
    component.set("v.errorMessage", undefined);
    if(component.get("v.attachmentList") == undefined || component.get("v.attachmentList").length == 0) {
        component.set('v.errorMessage','No files selected');
    }
    component.set("v.loadStatus","done");
    
    
    
},
  
  handleFilesChange : function(component, event, helper) {
      
      
      var fileInput = component.find("fileId").getElement();
      console.log('file', fileInput.files[0]); // this return file object
      var fileData = fileInput.files[0]; 
      console.log(fileData.name);
      const boundary = '-------314159265358979323846';
  const delimiter = "\r\n--" + boundary + "\r\n";
  const close_delim = "\r\n--" + boundary + "--";

  var reader = new FileReader();
  reader.readAsBinaryString(fileData);
  reader.onload = function(e) {
    var contentType = fileData.type || 'application/octet-stream';
    var metadata = {
      'title': fileData.name,
      'mimeType': contentType
    };

    var base64Data = btoa(reader.result);
    var multipartRequestBody =
        delimiter +
        'Content-Type: application/json\r\n\r\n' +
        JSON.stringify(metadata) +
        delimiter +
        'Content-Type: ' + contentType + '\r\n' +
        'Content-Transfer-Encoding: base64\r\n' +
        '\r\n' +
        base64Data +
        close_delim;

    var request = gapi.client.request({
        'path': '/upload/drive/v2/files',
        'method': 'POST',
        'params': {'uploadType': 'multipart'},
        'headers': {
          'Content-Type': 'multipart/mixed; boundary="' + boundary + '"'
        },
        'body': multipartRequestBody}).then(function(response){console.log(response);},function(reason){console.log(reason);});;
  
    
  }
      
      
      
      
       
  },
  handleClientLoad : function(cmp, event, helper)
  {         
      var YOUR_CLIENT_ID = '212567187918-v6l0mf8cm9ari9364ta69lioqetjvg68.apps.googleusercontent.com';
      var YOUR_REDIRECT_URI = 'https://jarvisitis-dev-ed.lightning.force.com/c/TestApp.app';
      var SCOPES = 'https://www.googleapis.com/auth/drive.file';
      var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/drive/v3/rest"];
      var API_KEY = 'AIzaSyDxn6XzokOoes4F8BNhXbJPsGuUyUkLY5E';
      console.log("Now at gapi.load");
      gapi.load('client:auth2', initClient);
      function initClient() {
          gapi.client.init({
              clientId:YOUR_CLIENT_ID,
              apiKey: API_KEY,
              discoveryDocs: DISCOVERY_DOCS,
              scope: 'profile'
          }).then(function(resolve){
              var YOUR_CLIENT_ID = '212567187918-v6l0mf8cm9ari9364ta69lioqetjvg68.apps.googleusercontent.com';
  var YOUR_REDIRECT_URI = 'https://jarvisitis-dev-ed.lightning.force.com/c/TestApp.app';
  var fragmentString = location.hash.substring(1);
              console.log(fragmentString);

  // Parse query string to see if page request is coming from OAuth 2.0 server.
  var params = {};
  var regex = /([^&=]+)=([^&]*)/g, m;
  while (m = regex.exec(fragmentString)) {
      console.log(decodeURIComponent(m[1]) +'and'+decodeURIComponent(m[2]));
    params[decodeURIComponent(m[1])] = decodeURIComponent(m[2]);
  }
  if (Object.keys(params).length > 0) {
    localStorage.setItem('oauth2-test-params', JSON.stringify(params) );
    if (params['state'] && params['state'] == 'try_sample_request') {
      trySampleRequest();
    }
      else{
           var params = JSON.parse(localStorage.getItem('oauth2-test-params'));
    if (params && params['access_token']) {
      var xhr = new XMLHttpRequest();
      xhr.open('GET',
          'https://www.googleapis.com/drive/v3/about?fields=user&' +
          'access_token=' + params['access_token']);
      xhr.onreadystatechange = function (e) {
        if (xhr.readyState === 4 && xhr.status === 200) {
          console.log(xhr.response);
        } else if (xhr.readyState === 4 && xhr.status === 401) {
          // Token invalid, so prompt for user permission.
          oauth2SignIn();
        }
      };
      xhr.send(null);
    } else {
      oauth2SignIn();
    }
      }
  } function oauth2SignIn() {
    // Google's OAuth 2.0 endpoint for requesting an access token
    var oauth2Endpoint = 'https://accounts.google.com/o/oauth2/v2/auth';

    // Create element to open OAuth 2.0 endpoint in new window.
    var form = document.createElement('form');
    form.setAttribute('method', 'GET'); // Send as a GET request.
    form.setAttribute('action', oauth2Endpoint);

    // Parameters to pass to OAuth 2.0 endpoint.
    var params = {'client_id': YOUR_CLIENT_ID,
                  'redirect_uri': YOUR_REDIRECT_URI,
                  'scope': 'https://www.googleapis.com/auth/drive.file',
                  'state': 'try_sample_request',
                  'include_granted_scopes': 'true',
                  'response_type': 'token'};

    // Add form parameters as hidden input values.
    for (var p in params) {
      var input = document.createElement('input');
      input.setAttribute('type', 'hidden');
      input.setAttribute('name', p);
      input.setAttribute('value', params[p]);
      form.appendChild(input);
    }

    // Add form to page and submit it to open the OAuth 2.0 endpoint.
    document.body.appendChild(form);
    form.submit();
  }
          }).catch(function(reject){console.log(reject);});
      }  
      
  }
 })