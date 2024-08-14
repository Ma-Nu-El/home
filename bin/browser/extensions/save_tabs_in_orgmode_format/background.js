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


browser.commands.onCommand.addListener((command) => {
  if (command === "save-tabs") {
    browser.tabs.query({ currentWindow: true }).then((tabs) => {
      var now = new Date();

      // Formatting the current date and time for the filename
      var year = now.getFullYear();
      var month = String(now.getMonth() + 1).padStart(2, '0');
      var day = String(now.getDate()).padStart(2, '0');
      var weekday = now.toLocaleString('en-US', { weekday: 'short' });
      var hours = String(now.getHours()).padStart(2, '0');
      var minutes = String(now.getMinutes()).padStart(2, '0');
      var seconds = String(now.getSeconds()).padStart(2, '0');

      // Org-mode timestamp format for the file content
      var timestamp = `[${year}-${month}-${day} ${weekday} ${hours}:${minutes}]`;

      // Filename format with underscores instead of spaces and hyphens instead of colons
      var filename = `${year}-${month}-${day}_${weekday}_${hours}_${minutes}_${seconds}_browser_session.org`;

      var orgLinks = tabs.map(tab => {
        var title = tab.title;
        var url = tab.url;
        return `- ${timestamp} [[${url}][${title}]]`;
      }).join('\n');

      var blob = new Blob([orgLinks], { type: 'text/plain' });
      var url = URL.createObjectURL(blob);

      browser.downloads.download({
        url: url,
        filename: filename,
        saveAs: false
      }).then(() => {
        console.log(`File successfully downloaded as: ${filename}`);
      }).catch((error) => {
        console.error(`Download failed: ${error}`);
      });
    });
  }
});
