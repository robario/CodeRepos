//
// $Id$
//
// --- In your .netrc
// machine irc://%1/%2 login %3 password %4
//   %1: server "setting name" (*NOT* real name)
//   %2: channel name or nickname
//   %3: your nickname (*NOT* username)
//   %4: your password
// ex)
// machine irc://my_bitlbee_server/&bitlbee login foo password bar
// machine irc://freenode/NickServ login foo password bar


var autologin = {};
autologin.accounts = {};
autologin.netrc = ".netrc"; // !!!FIXME!!!

function event::onLoad() {
    var file = openFile(autologin.netrc);
    if (!file) {
        log("[ERROR] " + autologin.netrc);
        return;
    }
    var line;
    while (typeof (line = file.readLine()) != 'undefined') {
        if (line.match(/^machine\s+irc:\/\/([^\/]+)\/(\S+)\s+login\s+(\S+)\s+password\s+(\S+)/)) {
            var server = RegExp.$1;
            var channel = RegExp.$2;
            var login = RegExp.$3;
            var password = RegExp.$4;
            log(["[DEBUG]", server, channel, login].join(" "));
            autologin.accounts[server] = {"channel": channel,
                                          "login": login,
                                          "password": password};
        }
    }
    file.close();
}

function event::onConnect() {
    if ( !autologin.accounts[name] ) {
        return;
    }
    if ( autologin.accounts[name].login != myNick ) {
        return;
    }
    sendRaw( ["PRIVMSG",
              autologin.accounts[name].channel,
              "identify",
              autologin.accounts[name].password].join(" ") );
}
