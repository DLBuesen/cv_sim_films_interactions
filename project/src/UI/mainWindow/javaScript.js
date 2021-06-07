

filePathButton.onclick = function filePathButtonCallback() {
  console.log("File Path Button Pushed")
  filePathWindow = window.open("/UI/filePath/index.html", "Set File Path","top=0,left=1000,width=800,height=500");
    // Declaration of variable without "var" makes it global
}

closeAppButton.onclick = function closeAppButtonCallback() {
  console.log("Close App Button Pushed")
  // window.close() doesn't work for a main window, only for secondary windows.
}

