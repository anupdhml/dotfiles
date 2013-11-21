commands.addUserCommand(['sbcap'],"capture with scrapbook",
    function(){
   //sbBrowserOverlay.execCapture(0, null, false, 'urn:scrapbook:root');
   ScrapBookBrowserOverlay.execCapture(0, null, false, 'urn:scrapbook:root');
    },
    {
    }
);

commands.addUserCommand(['sbbmark'],"bookmark with scrapbook",
    function(){
    //sbBrowserOverlay.bookmark();
    ScrapBookBrowserOverlay.bookmark();
    },
    {
    }
);

