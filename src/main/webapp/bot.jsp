<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Library Bot</title>
    <style>
        .chatbot {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #2874f0;
            color: white;
            border-radius: 50%;
            width: 60px;
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            font-size: 24px;
            z-index: 1000;
        }
        .chat-window {
            position: fixed;
            bottom: 90px;
            right: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            width: 300px;
            display: none;
            flex-direction: column;
        }
        .chat-header {
            background-color: #2874f0;
            color: white;
            padding: 10px;
            border-radius: 8px 8px 0 0;
        }
        .chat-body {
            padding: 10px;
        }
        .chat-body button {
            display: block;
            width: 100%;
            padding: 10px;
            margin-bottom: 5px;
            background-color: #f0f0f0;
            border: none;
            cursor: pointer;
            text-align: left;
            border-radius: 4px;
        }
        .chat-body button:hover {
            background-color: #e0e0e0;
        }
        .chat-footer {
            background-color: #f0f0f0;
            padding: 10px;
            text-align: center;
            border-radius: 0 0 8px 8px;
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.chatbot').click(function() {
                $('.chat-window').toggle();
            });

            $('.chat-body button').click(function() {
                var question = $(this).text();
                $.post('BotServlet', { question: question }, function(data) {
                    alert('Bot: ' + data);
                });
            });
        });
    </script>
</head>
<body>
    <div class="chatbot">
        <i class="fas fa-comments"></i>
    </div>
    <div class="chat-window">
        <div class="chat-header">
            Ask a Question
        </div>
        <div class="chat-body">
            <button>What is your return policy?</button>
            <button>How to renew a book?</button>
            <button>How to upload a book?</button>
            <button>How to contact support?</button>
        </div>
        <div class="chat-footer">
            <button onclick="$('.chat-window').hide();">Close</button>
        </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>
