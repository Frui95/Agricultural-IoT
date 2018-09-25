<%@ Page Language="C#" AutoEventWireup="true" CodeFile="videocam.aspx.cs" Inherits="videocam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width:auto; height:auto">
    <video id="video1" src="http://acfun.tudou.com/v/ab1470399_11" width="640" height="480" controls="controls" ></video>
    <video id="video2" src="ac2612764" width="640" height="480" controls="controls"></video>

    </div>
        <%--<div style="text-align: center;">
            <button onclick="playPause()">播放/暂停</button>
            <button onclick="makeBig()">大</button>
            <button onclick="makeNormal()">中</button>
            <button onclick="makeSmall()">小</button>
            <br />
            <video id="video1" width="420" style="margin-top: 15px;">
                <source src="/example/html5/mov_bbb.mp4" type="video/mp4" />
                <source src="/example/html5/mov_bbb.ogg" type="video/ogg" />
                Your browser does not support HTML5 video.
            </video>
        </div> --%>

    </form>
    <%--<script type="text/javascript">
        var myVideo = document.getElementById("video1");

        function playPause() {
            if (myVideo.paused)
                myVideo.play();
            else
                myVideo.pause();
        }

        function makeBig() {
            myVideo.width = 560;
        }

        function makeSmall() {
            myVideo.width = 320;
        }

        function makeNormal() {
            myVideo.width = 420;
        }
</script> --%>
</body>
</html>

