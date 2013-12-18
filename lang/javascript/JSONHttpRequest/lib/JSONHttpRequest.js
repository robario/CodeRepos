try {
    if (typeof JSONScriptRequest == 'undefined') {
        if (typeof JSAN != 'undefined') {
            JSAN.use('JSONScriptRequest');
        } else {
            // load JSONScriptRequest
            throw 'JSONScriptRequest loader is not implemented';
        }
    }
} catch (e) {
    throw 'JSONScriptRequest is required';
}

JSONHttpRequest = JSONScriptRequest._extends
(JSONScriptRequest,
 function(args) {
     this.base(args);
 },
 {
     open: function(method, url, async, user, password) {
         var request_method = method;

         method = 'GET';
         this.base.prototype.open.apply(this, arguments);

         // method rewrite
         if (request_method.toUpperCase() != 'GET') {
             this.setRequestHeader('X-REQUEST-METHOD', request_method);
         }
     },

     send: function(data) {
         var headers = JSONScriptRequest._toSource(this._requestHeaders).replace(/^\(|\)$/g, '');
         this._url += (this._url.indexOf('?') == -1 ? '?' : '&')
             + 'JSONHttpRequest=' + encodeURIComponent(headers);
         this.base.prototype.send.apply(this, arguments);
     },

     _dispatcher: function(json) {
         this.status = json.status.code;
         this.statusText = json.status.phrase;
         this.responseText = '';
         this._responseHeaders = json.header;
         this._readystatechange(3);

         if (this._method == 'HEAD') {
             this._readystatechange(4);
         } else {
             this.responseText = JSONScriptRequest._toSource(json.body).replace(/^\(|\)$/g, '');
             this._readystatechange(3);

             this.responseJSON = json.body;
             this._readystatechange(4);
         }

         return;
     }
 });

JSONHttpRequest.VERSION = 0.01;

/*

=head1 NAME

JSONHttpRequest - Extend JSONScriptRequest to look like XMLHttpRequest more.

=head1 SYNOPSIS

  var req = new JSONHttpRequest();
  req.open('GET', 'http://www.example.com/jsonp');
  req.onreadystatechange = function() {
      if (req.readyState == 4 && req.readyState == 201) {
          alert(req.responseJSON);
      }
  };
  req.send(null);

=head1 DESCRIPTION

JSONHttpRequest is more similar to XMLHttpRequest than JSONScriptRequest.
It can treat the request headers, the response status, and the response headers.
However, you have to enhance the server side to follow to it.

=head2 Constructor

=head3 JSONHttpRequest({...})

The same argument as JSONScriptRequest can be specified.

=head1 TODO

=over

=item Implement the features that is not implemented yet.

=back

=head1 SEE ALSO

L<JSONScriptRequest>

=head1 AUTHOR

Hironori Yoshida <yoshida@cpan.org>

=head1 COPYRIGHT

  Copyright (c) 2006, Hironori Yoshida <yoshida@cpan.org>. All rights reserved.
  This module is free software; you can redistribute it and/or modify it
  under the terms of the Artistic license. Or whatever license I choose,
  which I will do instead of keeping this documentation like it is.

=cut

*/
