var ucjsAgesageFlvDownloader = {
    download: function(title, xml){
        var req = new XMLHttpRequest();
        req.onreadystatechange = function() {
            if (req.readyState != 4) {
                return;
            }
            if (req.status != 200) {
                alert(req.status + " " + req.statusText);
                return;
            }
            var location = req.responseXML.getElementsByTagName('movieurl')[0].textContent;
            ucjsAgesageFlvDownloader.saveFLV(title, location);
        };
        req.open('GET', xml, true);
        req.send('');
    },

    saveFLV: function(aTitle, aFlvURLSpec){
        const FLV_EXTENSION = "flv";
        var FLV_CONTENT_TYPE = "video/flv";

        var flvName = aTitle + "." + FLV_EXTENSION;

        var flvURL = Components.classes["@mozilla.org/network/io-service;1"]
                               .getService(Components.interfaces.nsIIOService)
                               .newURI(aFlvURLSpec, null, null)
                               .QueryInterface(Components.interfaces.nsIURL);
        var fileInfo = new FileInfo(flvName, flvName, aTitle, FLV_EXTENSION, flvURL);

        var fpParams = {
            fpTitleKey: "",
            isDocument: false,
            fileInfo: fileInfo,
            contentType: FLV_CONTENT_TYPE,
            saveMode: GetSaveModeForContentType(FLV_CONTENT_TYPE),
            saveAsType: 0,
            file: null,
            fileURL: null
        };
        if(!getTargetFile(fpParams, true)){
            return;
        }

        var fileURL = fpParams.fileURL || makeFileURI(fpParams.file);

        var persist = makeWebBrowserPersist();
        persist.persistFlags = Components.interfaces.nsIWebBrowserPersist
                                         .PERSIST_FLAGS_REPLACE_EXISTING_FILES;
        var transfer = Components.classes["@mozilla.org/transfer;1"]
                                 .createInstance(Components.interfaces.nsITransfer);
        transfer.init(fileInfo.uri, fileURL, "", null, null, null, persist);
        persist.progressListener = transfer;
        persist.saveURI(fileInfo.uri, null, null, null, null, fileURL);
    }
};

(function(){
    var contentAreaContextMenu = document.getElementById("contentAreaContextMenu");
    var menuItem = document.createElement("menuitem");
    menuItem.setAttribute("label", "Download FLV");
    contentAreaContextMenu.appendChild(menuItem);
    contentAreaContextMenu.addEventListener
    ("popupshowing",
     function() {
         menuItem.hidden = true;
         if(gContextMenu.target.id != "bookmarktitle") return;
         var location = gContextMenu.target.ownerDocument.location;
         if(location.host.indexOf("agesage.jp") < 0) return;
         var xml = location.href.replace(/\.ht(?=ml\?)/, '.x');
         var title = gContextMenu.target.textContent;
         menuItem.setAttribute("oncommand", "ucjsAgesageFlvDownloader.download('"+ title +"','"+ xml +"')");
         menuItem.hidden = false;
     },
     false);
})();
