// SYNOPSIS
// javascript:(function(d,r){d.body.appendChild(d.createElement('script')).src='http://coderepos.org/share/export/'+r.replace(/\D/g,'')+'/lang/javascript/misc/password.js'})(document,'$Rev: 38444 $')
(function(d, p) {
     var data = p('Domain', d.domain.replace(/.*?([^.]+\.(?:(?:a[cd]|co|ed|g[or]|lg|ne|or)\.jp|[^.]*)$)/, '$1'));
     if (!data) {
         return;
     }
     var key = p('Secret Key', '');
     if (!key) {
         return;
     }
     /*
      * A JavaScript implementation of the Secure Hash Algorithm, SHA-1, as defined
      * in FIPS PUB 180-1
      * Version 2.1a Copyright Paul Johnston 2000 - 2002.
      * Other contributors: Greg Holt, Andrew Kepert, Ydnar, Lostinet
      * Distributed under the BSD License
      * See http://pajhome.org.uk/crypt/md5 for details.
      */
     var password = (function b64_hmac_sha1(){var o=0;var t="";var c=8;function j(u){return i(e(s(u),u.length*c))}function h(u){return m(e(s(u),u.length*c))}function d(u){return q(e(s(u),u.length*c))}function b(u,v){return i(f(u,v))}function g(u,v){return m(f(u,v))}function l(u,v){return q(f(u,v))}function a(){return j("abc")=="a9993e364706816aba3e25717850c26c9cd0d89d"}function e(J,D){J[D>>5]|=128<<(24-D%32);J[((D+64>>9)<<4)+15]=D;var K=Array(80);var I=1732584193;var H=-271733879;var G=-1732584194;var F=271733878;var E=-1009589776;for(var A=0;A<J.length;A+=16){var C=I;var B=H;var z=G;var y=F;var u=E;for(var v=0;v<80;v++){if(v<16){K[v]=J[A+v]}else{K[v]=n(K[v-3]^K[v-8]^K[v-14]^K[v-16],1)}var L=p(p(n(I,5),r(v,H,G,F)),p(p(E,K[v]),k(v)));E=F;F=G;G=n(H,30);H=I;I=L}I=p(I,C);H=p(H,B);G=p(G,z);F=p(F,y);E=p(E,u)}return Array(I,H,G,F,E)}function r(v,u,x,w){if(v<20){return(u&x)|((~u)&w)}if(v<40){return u^x^w}if(v<60){return(u&x)|(u&w)|(x&w)}return u^x^w}function k(u){return(u<20)?1518500249:(u<40)?1859775393:(u<60)?-1894007588:-899497514}function f(w,z){var y=s(w);if(y.length>16){y=e(y,w.length*c)}var u=Array(16),x=Array(16);for(var v=0;v<16;v++){u[v]=y[v]^909522486;x[v]=y[v]^1549556828}var A=e(u.concat(s(z)),512+z.length*c);return e(x.concat(A),512+160)}function p(u,z){var w=(u&65535)+(z&65535);var v=(u>>16)+(z>>16)+(w>>16);return(v<<16)|(w&65535)}function n(u,v){return(u<<v)|(u>>>(32-v))}function s(x){var w=Array();var u=(1<<c)-1;for(var v=0;v<x.length*c;v+=c){w[v>>5]|=(x.charCodeAt(v/c)&u)<<(32-c-v%32)}return w}function q(w){var x="";var u=(1<<c)-1;for(var v=0;v<w.length*32;v+=c){x+=String.fromCharCode((w[v>>5]>>>(32-c-v%32))&u)}return x}function i(w){var v=o?"0123456789ABCDEF":"0123456789abcdef";var x="";for(var u=0;u<w.length*4;u++){x+=v.charAt((w[u>>2]>>((3-u%4)*8+4))&15)+v.charAt((w[u>>2]>>((3-u%4)*8))&15)}return x}function m(x){var w="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";var z="";for(var v=0;v<x.length*4;v+=3){var y=(((x[v>>2]>>8*(3-v%4))&255)<<16)|(((x[v+1>>2]>>8*(3-(v+1)%4))&255)<<8)|((x[v+2>>2]>>8*(3-(v+2)%4))&255);for(var u=0;u<4;u++){if(v*8+u*6>x.length*32){z+=t}else{z+=w.charAt((y>>6*(3-u))&63)}}}return z}return g(key,data)})();
     var pw = password.replace(/[+\/]+/g, '').substr(0, 8);
     var inputs = d.getElementsByTagName('input');
     var shown = false;
     var onblur = function() {
         this.removeEventListener('blur', arguments.callee, false);
         this.setAttribute('type', 'password');
     };
     for (var i = inputs.length; i --> 0;) {
         if (inputs[i].getAttribute('type') !== 'password') {
             continue;
         }
         inputs[i].value = pw;
         try {
             inputs[i].setAttribute('type', 'text');
             inputs[i].addEventListener('blur', onblur, false);
             inputs[i].focus();
             shown = true;
         } catch(exception) {
             // TODO: IE doesn't permit the type modification.
         }
     }
     if (!shown) {
         p(password, pw);
     }
 })(window.document, window.prompt);
