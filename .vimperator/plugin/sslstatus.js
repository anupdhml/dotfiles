"use strict";

Cu.import("resource://gre/modules/XPCOMUtils.jsm", modules);

const progressListener = {
    QueryInterface: XPCOMUtils.generateQI([Ci.nsISupportsWeakReference, Ci.nsIWebProgressListener]),

    onSecurityChange: function onSecurityChange(webProgress, request, state) {
        //var sl_css = 'background: #333; font-family: Inconsolata; font-size: 14px; margin-top: 1px; ';
        var sl_css = 'background: transparent; ';
        if (state & Ci.nsIWebProgressListener.STATE_IS_INSECURE)
            //highlight.set("StatusLine", "");
            //sl_css += "color: #ddc;";
            sl_css += "color: gray;";
        else if (state & Ci.nsIWebProgressListener.STATE_IS_BROKEN)
            //highlight.set("StatusLine", "color: white; background: darkred");
            sl_css += "color: red; font-weight: bold;";
        else if (state & Ci.nsIWebProgressListener.STATE_IDENTITY_EV_TOPLEVEL)
            //highlight.set("StatusLine", "color: white; background: darkgreen");
            sl_css += "color: #87A96B;";
        else if (state & Ci.nsIWebProgressListener.STATE_SECURE_HIGH)
            //highlight.set("StatusLine", "color: white; background: darkblue");
            sl_css += "color: #89CFF0;";
        highlight.set("StatusLine", sl_css);
    }
};

config.browser.addProgressListener(progressListener, Ci.nsIWebProgress.NOTIFY_SECURITY);

