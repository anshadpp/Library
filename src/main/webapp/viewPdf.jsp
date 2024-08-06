<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.UnsupportedEncodingException" %>
<%
    // Get the bookId and page number from the request parameters
    String bookId = request.getParameter("id");
    String pageStr = request.getParameter("page");
    String userId = request.getParameter("userId");
    int pageNum = 1;

    if (pageStr != null && !pageStr.isEmpty()) {
        try {
            pageNum = Integer.parseInt(pageStr);
        } catch (NumberFormatException e) {
            // Handle the case where the page parameter is not a valid integer
            pageNum = 1;
        }
    }

    if (userId == null) {
        // Handle the error (e.g., redirect to login page)
        response.sendRedirect("login.jsp"); // Redirect to login page
        return; // Stop further processing of the page
    }

    // Encode userId and bookId for safe usage in the URL
    String encodedUserId = "";
    String encodedBookId = "";

    try {
        encodedUserId = URLEncoder.encode(userId, "UTF-8");
        encodedBookId = URLEncoder.encode(bookId, "UTF-8");
    } catch (UnsupportedEncodingException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PDF Viewer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            box-sizing: border-box;
            overflow-y: auto; /* Enable vertical scrolling */
        }
        .controls {
            margin: 10px 0;
            text-align: center;
        }
        .controls button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            margin: 5px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .controls button:hover {
            background-color: #45a049;
        }
        .controls span {
            font-size: 18px;
            margin: 0 10px;
        }
        #the-canvas {
            display: block;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: white;
            width: 100%;
            height: auto;
            max-width: 800px; /* Set maximum width to a typical PDF width */
            box-sizing: border-box;
        }
        /* Notification styling */
        #bookmark-notification {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #4CAF50;
            color: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: none; /* Hidden by default */
            font-size: 16px;
            z-index: 1000; /* Ensure it is above other elements */
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.11.338/pdf.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var bookId = '<%= encodedBookId %>'; // Use the bookId from the JSP scriptlet
            var userId = '<%= encodedUserId %>'; // Use the userId from the JSP scriptlet
            var pageNum = 1; // Default page number

            // Load last read page
            fetch('LastReadPageServlet?userId=' + encodeURIComponent(userId) + '&bookId=' + encodeURIComponent(bookId))
                .then(response => response.text())
                .then(page => {
                    pageNum = parseInt(page) || 1;
                    loadPdf();
                });

            var pdfDoc = null,
                pageRendering = false,
                pageNumPending = null,
                scale = 1.0,
                canvas = document.getElementById('the-canvas'),
                ctx = canvas.getContext('2d');

            function renderPage(num) {
                pageRendering = true;
                pdfDoc.getPage(num).then(function (page) {
                    var viewport = page.getViewport({ scale: scale });
                    canvas.height = viewport.height;
                    canvas.width = viewport.width;

                    var renderContext = {
                        canvasContext: ctx,
                        viewport: viewport
                    };

                    var renderTask = page.render(renderContext);
                    renderTask.promise.then(function () {
                        pageRendering = false;
                        if (pageNumPending !== null) {
                            renderPage(pageNumPending);
                            pageNumPending = null;
                        }
                        document.querySelectorAll('.page_num').forEach(span => span.textContent = pageNum);
                    });
                }).catch(function (error) {
                    console.error('Error rendering page:', error);
                });

                saveLastReadPage(bookId, num); // Save last read page
            }

            function queueRenderPage(num) {
                if (pageRendering) {
                    pageNumPending = num;
                } else {
                    renderPage(num);
                }
            }

            function onPrevPage() {
                if (pageNum <= 1) {
                    return;
                }
                pageNum--;
                queueRenderPage(pageNum);
            }

            function onNextPage() {
                if (pageNum >= pdfDoc.numPages) {
                    return;
                }
                pageNum++;
                queueRenderPage(pageNum);
            }

            document.querySelectorAll('.prev').forEach(btn => btn.addEventListener('click', onPrevPage));
            document.querySelectorAll('.next').forEach(btn => btn.addEventListener('click', onNextPage));

            document.querySelectorAll('.bookmark').forEach(btn => btn.addEventListener('click', function () {
                saveLastReadPage(bookId, pageNum);
                showBookmarkNotification(); // Show the custom bookmark notification
            }));

            function loadPdf() {
                pdfjsLib.getDocument('pdfu?id=' + encodeURIComponent(bookId)).promise.then(function (pdfDoc_) {
                    pdfDoc = pdfDoc_;
                    document.querySelectorAll('.page_count').forEach(span => span.textContent = pdfDoc.numPages);
                    renderPage(pageNum);
                }).catch(function (error) {
                    console.error('Error loading PDF:', error);
                });
            }

            function saveLastReadPage(bookId, pageNum) {
                fetch('LastReadPageServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'userId=' + encodeURIComponent(userId) + '&bookId=' + encodeURIComponent(bookId) + '&lastPage=' + encodeURIComponent(pageNum)
                }).then(response => response.text())
                .then(result => {
                    console.log('Last read page saved:', result);
                }).catch(error => {
                    console.error('Error saving last read page:', error);
                });
            }

            function showBookmarkNotification() {
                var notification = document.getElementById('bookmark-notification');
                notification.style.display = 'block';
                setTimeout(function() {
                    notification.style.display = 'none';
                }, 3000); // Hide after 3 seconds
            }

            window.addEventListener('resize', function () {
                if (pdfDoc) {
                    renderPage(pageNum);
                }
            });
        });
    </script>
</head>
<body>
    <div class="controls">
        <button class="prev">Previous</button>
        <button class="next">Next</button>
        <button class="bookmark">Bookmark</button>
        <span>Page: <span class="page_num">1</span> / <span class="page_count"></span></span>
    </div>

    <canvas id="the-canvas"></canvas>

    <div class="controls">
        <button class="prev">Previous</button>
        <button class="next">Next</button>
        <button class="bookmark">Bookmark</button>
        <span>Page: <span class="page_num">1</span> / <span class="page_count"></span></span>
    </div>

    <!-- Custom bookmark notification -->
    <div id="bookmark-notification">Bookmark saved successfully!</div>
</body>
</html>
