var _SCRIPTS = {};
var XMLHttpRequest = (function() {
    for (var ax in {'Msxml2.XMLHTTP':1, 'Microsoft.XMLHTTP':1}) {
        log(ax);
        try {
            new ActiveXObject(ax);
            return function() {
                return new ActiveXObject(ax);
            };
        } catch (e) {
        }
    }
})();

function event::onLoad() {
    var fso = new ActiveXObject('Scripting.FileSystemObject');
    var dir = fso.GetFolder(userScriptFilePath);
    var e = new Enumerator(dir.Files);
    log('Loading sub scripts');
    // TODO: reload script feature
    while (!e.atEnd()) {
        var filename = e.item().Name;
        if (/\.lc\.js$/.test(filename.toLowerCase())) {
            var file = openFile(filename, true);
            var script = file.readAll();
            file.close();
            var key = filename.toLowerCase().replace(/\.lc\.js$/, '');
            _SCRIPTS[key] = (new Function('return ' + script))();
            log('[' + key + ']');
        }
        e.moveNext();
    }
}
function event::onChannelText(prefix, channel, text) {
    // TODO: matching with _SCRIPTS.keys
    if (!/^([\w-]+)> *(.*)$/.test(text)) {
        return;
    }
    var key = RegExp.$1.toLowerCase();
    if (!_SCRIPTS.hasOwnProperty(key)) {
        return;
    }
    var params = RegExp.$2.split(/[>\s]/);
    _SCRIPTS[key].apply(null, [prefix, channel, params]);
}
