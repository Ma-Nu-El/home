// # - [2024-08-13 Tue 16:33]
//
// Running this code in the Firefox Browser Console
// will download a file named in the format
// YYYY-MM-DD_Day_HH:MM:SS_browser_session.org
// , and it will log a success message in the console
// that confirms the download.
//
// The content of the downloaded file is a list
// in orgmode format of the currently open tabs,
// with timestamp.
//
// Tested on Firefox 128.0.3 (64-bit) and macOS 14.5


(function() {
    var tabs = Array.from(gBrowser.tabs);
    var now = new Date();

    // Formatting the current date and time
    var year = now.getFullYear();
    var month = String(now.getMonth() + 1).padStart(2, '0');
    var day = String(now.getDate()).padStart(2, '0');
    var weekday = now.toLocaleString('en-US', { weekday: 'short' });
    var hours = String(now.getHours()).padStart(2, '0');
    var minutes = String(now.getMinutes()).padStart(2, '0');
    var seconds = String(now.getSeconds()).padStart(2, '0');

    var timestamp = `[${year}-${month}-${day} ${weekday} ${hours}:${minutes}:${seconds}]`;

    var orgLinks = tabs.map(tab => {
        var title = tab.linkedBrowser.contentTitle;
        var url = tab.linkedBrowser.currentURI.spec;
        return `- ${timestamp} [[${url}][${title}]]`;
    }).join('\n');

    // Create the file name with seconds included
    var filename = `${year}-${month}-${day}_${weekday}_${hours}:${minutes}:${seconds}_browser_session.org`;

    // Create a Blob with the content
    var blob = new Blob([orgLinks], { type: 'text/plain' });

    // Create a link element to download the Blob
    var a = document.createElement('a');
    a.href = URL.createObjectURL(blob);
    a.download = filename;

    // Programmatically click the link to trigger the download
    a.click();

    // Revoke the object URL to free up memory
    URL.revokeObjectURL(a.href);

    // Log a success message to the console
    console.log(`File successfully downloaded as: ${filename}`);
})();
