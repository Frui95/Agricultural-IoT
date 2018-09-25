<%@ Page Language="C#" AutoEventWireup="true" CodeFile="important.aspx.cs" Inherits="important" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <!--Add jquery library-->
    <script src="js/jquery-1.10.1.min.js"></script>
    <script src="js/jquery.mousewheel-3.0.6.pack.js"></script>
    <script src="js/jquery.fancybox.js"></script>
    <link href="style/jquery.fancybox.css" rel="stylesheet" />
    <script src="js/jquery.fancybox-buttons.js"></script>
    <link href="style/jquery.fancybox-thumbs.css" rel="stylesheet" />
    <script src="source/helpers/jquery.fancybox-media.js"></script>
     <%--<meta http-equiv="refresh" content="100"/>刷新--%>    
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="keywords" content="百度地图,百度地图API，百度地图自定义工具，百度地图所见即所得工具" />
<meta name="description" content="百度地图API自定义地图，帮助用户在可视化操作下生成百度地图" />
    <script src="js/jquery.easyui.min.js"></script>
    <script src="js/jquery-ui-1.10.2.custom.min.js"></script>
    <script type="text/javascript">

    </script>
    <style type="text/css">
		.fancybox-custom .fancybox-skin {
			box-shadow: 0 0 50px #222;
		}

		body {
			max-width: 700px;
			margin: 0 auto;
		}
	</style>
<style type="text/css">.fancybox-margin{margin-right:17px;}</style>

    <title>城市排水管理系统—首页</title>
<!--引用百度地图API-->
<style type="text/css">
    body{margin:0;padding:0;}
    .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
    .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=57f74e00b43b8a89be4f88f761fe6262"></script>
</head>
<body>
    
  <!--百度地图容器-->
   <div style="width:1300px;height:600px;border:#ccc solid 1px;" id="dituContent"></div>
    <input id="Button1" type="button" value="查看井盖信息" />
    <input id="Button2" type="button" value="查看液位信息" />
   <img src="images/caricon.gif" />异常井盖报警
    <img src="images/水位.png" />检测功能和液位
    <img src="images/一般.png" />只有检测功能
   
</body>
</html>

<script type="text/javascript">
    var jsonData;
    //var preMarker;


    //初始化地图
    function initMap() {
        createMap();//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
        addMarker();//向地图中添加marker
        setInterval("addMarker();", 10000);   //刷新
        //setInterval("refreshIcon();", 10000);
    }

    //创建地图函数
    function createMap() {
        var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
        var point = new BMap.Point(116.394388, 39.951807);//定义一个中心点坐标
        map.centerAndZoom(point, 15);//设定地图的中心点和坐标并将地图显示在地图容器中
        window.map = map;//将map变量存储在全局
    }

    //地图事件设置函数
    function setMapEvent() {
        map.enableDragging();//启用地图拖拽事件，默认启用（可不写）
        map.enableScrollWheelZoom();//启用地图滚轮放大缩小
        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard();//启用键盘上下左右键移动地图
    }

    //地图控件添加函数
    function addMapControl() {
        //向地图中添加缩放控件
        var ctrl_nav = new BMap.NavigationControl({ anchor: BMAP_ANCHOR_TOP_LEFT, type: BMAP_NAVIGATION_CONTROL_LARGE });
        map.addControl(ctrl_nav);
        //向地图中添加缩略图控件
        var ctrl_ove = new BMap.OverviewMapControl({ anchor: BMAP_ANCHOR_BOTTOM_RIGHT, isOpen: 1 });
        map.addControl(ctrl_ove);
        //向地图中添加比例尺控件
        var ctrl_sca = new BMap.ScaleControl({ anchor: BMAP_ANCHOR_BOTTOM_LEFT });
        map.addControl(ctrl_sca);
    }




    //创建marker
    function addMarker() {

        //var jsonData;
        $.ajax({
            type: "post",   //请求的方法 
            url: "ajax/point.aspx", //要传递参数使用Ajax进行处理的类名称 
            dataType: "text",   //返回的数据类型 
            global: false,  //Ajax的范围 
            async: false,   //异步执行 
            //成功情况下的处理 
            success: function (strReult) {

                jsonData = eval("(" + strReult + ")");

            }, //失败情况下的处理 
            error: function () {
                alert("Ajax请求数据失败!");
            }
        });
        map.clearOverlays();//清除标记点

        //循环添加标记点
        for (var i = 0; i < jsonData.data.length; i++) {
            var json = jsonData.data[i];
            var p0 = json.longitude;//获得经度
            var p1 = json.latitude;//获得纬度

            var status = json.well_Status;//获得井盖的状态是否正常
            var point = new BMap.Point(p0, p1);//定义点的坐标

            var iconImg = createIcon(json.icon);//获得标注图标
            //var levelTime = json.level_time;//获得井盖的状态更新时间
            var myDate = new Date();
            var levelTime = myDate.toLocaleString();

            var myicon = new BMap.Icon("images/caricon.gif", new BMap.Size(30, 60), {    //定义报警图标
                offset: new BMap.Size(0, -5),
                imageOffset: new BMap.Size(0, 0)    //图片的偏移量。为了是图片底部中心对准坐标点。
            });

            //定义窗口的内容
            json.content = "井盖编号:" + json.well_ID + "</br>" + "</br>" +
                "该位置井盖状况:" + status + "</br>" + "</br>" +
                "该位置井盖更新时间:" + levelTime + "</br>" + "</br>" +
                "<img style='float:right;margin:4px' id='imgDemo'  src='http://cn.gcimg.net/gcproduct/mog_day_111021/111021105800c806c44c58d2df.jpg' width='100' height='80' title='井盖'/>";;


            //根据井盖状态的不同绘制不同的图标
            if (status == "异常") {
                var marker = new BMap.Marker(point, { icon: myicon });

            }
            else {
                var marker = new BMap.Marker(point, { icon: iconImg });

            }
            //var marker = new BMap.Marker(point, { icon: iconImg });

            //创建显示信息的窗口
            var iw = createInfoWindow(i);
            var label = new BMap.Label(json.well_ID, { "offset": new BMap.Size(json.icon.lb - json.icon.x + 10, -20) });

            marker.setLabel(label);//添加标签

            map.addOverlay(marker);
            var preMarker = marker;
            //map.removeOverlay(preMarker);



            label.setStyle({
                borderColor: "#808080",
                color: "#333",
                cursor: "pointer"
            });

            //( function refresh() { marker.setLabel(label);//添加标签
            //    map.addOverlay(marker);
            //})()//添加标记点}


            // setInterval("refresh();", 10000);
            //setInterval("refreshIcon("+marker+");", 10000);

            (function () {
                var index = i;
                var _iw = createInfoWindow(i);
                var _marker = marker;

                //添加鼠标经过监听
                _marker.addEventListener("mouseover", function () {
                    this.openInfoWindow(_iw);
                });
                //添加点击的监听事件
                _marker.addEventListener("click", function () {
                    this.openInfoWindow(_iw);
                });
                //添加窗口打开监听
                _iw.addEventListener("open", function () {
                    _marker.getLabel().hide();
                })
                //添加窗口关闭监听
                _iw.addEventListener("close", function () {
                    _marker.getLabel().show();
                })
                //添加窗口点击监听
                label.addEventListener("click", function () {
                    _marker.openInfoWindow(_iw);
                })
                //根据是否打开函数显示或者隐藏窗口
                if (!!json.isOpen) {
                    label.hide();
                    _marker.openInfoWindow(_iw);
                }
            })()
        }
    }
    //创建InfoWindow
    function createInfoWindow(i) {
        var json = jsonData.data[i];
        var p0 = json.longitude;//获得经度
        var p1 = json.latitude;//获得纬度
        var iw = new BMap.InfoWindow("<b class='iw_poi_title' title='" + json.well_ID + "'>" + json.well_ID + "</b><div class='iw_poi_content' style='color: #FF0000'>" + json.content + "</div>" + "</b><div class='iw_poi_content'>" + "井盖类型：" + json.well_Type + "</div>" + "</b><div class='iw_poi_content'>" + "</br>" + "经度：" + p0 + "</div>" + "</div>" + "</b><div class='iw_poi_content'>" + "</br>" + "纬度：" + p1 + "</div>");
        return iw;
    }
    //创建一个Icon
    function createIcon(json) {
        var icon = new BMap.Icon("http://app.baidu.com/map/images/us_mk_icon.png", new BMap.Size(json.w, json.h), { imageOffset: new BMap.Size(-json.l, -json.t), infoWindowOffset: new BMap.Size(json.lb + 5, 1), offset: new BMap.Size(json.x, json.h) })
        return icon;
    }

 



    initMap();//创建和初始化地图




    $(document).ready(function () {
       

      
        $("#Button1").click(function () {
            $.fancybox.open({
                href: 'wellsearch.aspx',
                type: 'iframe',
                padding: 5
            });
        });

        $("#Button2").click(function () {
            $.fancybox.open({
                href: 'levelsearch.aspx',
                type: 'iframe',
                padding: 5
            });
        });
       

      

    });



</script>
