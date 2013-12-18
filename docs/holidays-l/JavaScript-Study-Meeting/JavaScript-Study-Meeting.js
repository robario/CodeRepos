var scripts = document.getElementsByTagName('script');
for (var i = 0; i < scripts.length; ++i) {
    if (scripts[i].src) {
        continue;
    }
    var textarea = document.createElement('textarea');
    textarea.rows = 18;
    textarea.cols = 80;
    textarea.style.cssText = 'display:none';
    textarea.appendChild( document.createTextNode(scripts[i].innerHTML) );

    var p = document.createElement('p');
    p.appendChild( document.createTextNode('Source') );
    p.style.cssText = 'color:blue;text-decoration: underline';
    with({textarea:textarea})
    p.onclick = function() {
        textarea.style.display = textarea.style.display == 'none' ? 'block' : 'none';
    };
    document.body.insertBefore(textarea, scripts[i]);
    document.body.insertBefore(p, textarea);
}
