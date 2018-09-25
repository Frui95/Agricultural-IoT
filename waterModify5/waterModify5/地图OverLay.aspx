<%@ Page Language="C#" AutoEventWireup="true" CodeFile="地图OverLay.aspx.cs" Inherits="地图OverLay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<style type="text/css">
		body, html {width: 100%;height: 100%;margin:0;font-family:"微软雅黑";}
		#allmap{width:100%;height:540px;}
		#r-result{width:100%;margin-top:5px;}
		p{margin:5px; font-size:14px;}
	    #Text1 {
            height: 29px;
            width: 186px;
        }
	    #gpsinfo {
            height: 24px;
            width: 183px;
        }
        .anchorBL{  
       display:none;  
   }  

	</style>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=57f74e00b43b8a89be4f88f761fe6262"></script>
	<title>地图覆盖物事件</title>
    <script src="js/jquery-1.10.1.min.js"></script>
    <script src="js/highcharts.js"></script>
    <script src="js/exporting.js"></script>
    
</head>
<body>
    <form id="form1" runat="server">
        <div id="allmap"></div>
    </form>

</body>
</html>
<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("allmap");
   
    var point = new BMap.Point(121.449853, 31.039382);
    map.centerAndZoom(point, 12);
    //map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
    map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
    map.centerAndZoom(point, 15);
    var marker = new BMap.Marker(point);  // 创建标注
    map.addOverlay(marker);               // 将标注添加到地图中
    marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
    marker.addEventListener("click", attribute);
    function attribute() {
        //var p = marker.getPosition();  //获取marker的位置
        //alert("marker的位置是" + p.lng + "," + p.lat);
        window.location.href = '金山温室图.aspx';
    }
    var opts = {
        position: point,    // 指定文本标注所在的地理位置
        offset: new BMap.Size(30, -10)    //设置文本偏移量
    }
    var label = new BMap.Label("国家科技部支撑计划项目示范基地", opts);  // 创建文本标注对象
    label.setStyle({
        color: "red",
        fontSize: "12px",
        height: "20px",
        lineHeight: "20px",
        fontFamily: "微软雅黑"
    });
    map.addOverlay(label);
</script>
