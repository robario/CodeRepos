function(prefix, channel, params) {
    log(prefix);
    log(channel);
    log(params);
    var uri = params[0];
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        log(req.readyState);
        if (req.readyState != 4) {
            return;
        }
        try {
            var data = eval('(' + req.responseText + ')');
            // send(channel, data.url);
            send(channel, data.title);
            for (var i = 0; i < data.summaries.length; ++i) {
                var text = data.summaries[i];
                if (154 < text.length) {
                    text = text.substr(0, 152) + "...";
                }
                send(channel, (i + 1) + ". " + text);
            }
        } catch (e) {
            log(e.message);
            send(channel, '要約不能です（＞＜）');
        }
    }
    req.open('GET', 'http://www.3lines.info/summary?url=' + encodeURIComponent(uri), true);
    req.send('');
}
