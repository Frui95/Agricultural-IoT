<%@ Page Language="C#" AutoEventWireup="true" CodeFile="金山温室图.aspx.cs" Inherits="金山温室图" %>

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
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.2&ak=57f74e00b43b8a89be4f88f761fe6262"></script>
	<title>金山温室微观图</title>
    <script src="js/jquery-1.10.1.min.js"></script>
    <script src="js/highcharts.js"></script>
    <script src="js/exporting.js"></script>
    
</head>
<body>
    <form id="form1" runat="server">
        <div id="allmap" ></div>
        <div id="r-result">
            <input type="button" onclick="add_control();" value="添加" />
            <input type="button" onclick="delete_control();" value="删除" />
        </div>
        <div style="height: 30px" id="gpsinfo0">
            <input id="gpsinfo" type="text" value="" />
        </div>

    </form>

</body>
</html>
<script type="text/javascript">
    myFunction();
    function myFunction() {
        $.ajax({
            type: "post",   //请求的方法 
            url: "ajax/get_MapWindowInformation.ashx",
            cache: false,
            //async: true,
            //dataType:'json',
            success: function (data) {
                var jsonD = eval("(" + data + ")");
                var i = jsonD.length;
                lasttemper = jsonD[0]['airtemper'];
                lastairhum = jsonD[0]['airhum'];
                lastlandhum = jsonD[0]['landhum'];
                lastlight = jsonD[0]['light'];
                lastconductance = jsonD[0]['conductance'];

                //var M = new String;
                //M = lasttemper + "," + lastairhum + "," + lastlandhum + "," + lastlight;
                //alert(M);
                // 百度地图API功能
                var map = new BMap.Map('allmap');//再id=allmap的元素中显示地图
               // map.addControl(new BMap.NavigationControl());//缩略图控件
                map.centerAndZoom(new BMap.Point(121.34179, 30.719804), 4);//初始化地图以创建的经纬度为中心初始化
                map.enableScrollWheelZoom();   //启用滚轮放大缩小，默认禁用
                map.enableContinuousZoom();    //启用地图惯性拖拽，默认禁用
                var tileLayer = new BMap.TileLayer({ isTransparentPng: true });//创建瓦片图图层对象
                tileLayer.getTilesUrl = function (tileCoord, zoom) {//导入图层
                    var x = tileCoord.x;
                    var y = tileCoord.y;
                    return 'tiles/' + zoom + '/tile' + x + '_' + y + '.png';  //根据当前坐标，选取合适的瓦片图
                }
                map.addTileLayer(tileLayer);
                var cr = new BMap.CopyrightControl({ anchor: BMAP_ANCHOR_BOTTOM_RIGHT });   //设置版权控件位置
                map.addControl(cr); //添加版权控件
              
                var bs = map.getBounds();   //返回地图可视区域
                cr.addCopyright({ id: 1, content: "<a href='#' style='font-size:20px'>SJTU 上海交通大学农业与生物学院 </a>", bounds: bs });
                //Copyright(id,content,bounds)类作为CopyrightControl.addCopyright()方法的参数

                function add_control() {
                    map.addTileLayer(tileLayer);
                }
                function delete_control() {
                    map.removeTileLayer(tileLayer);
                }
                add_control();
                //点击获取屏幕经纬度
                function getlocation() {
                    map.addEventListener("click", function (e) {
                        document.getElementById("gpsinfo").value = e.point.lng + "," + e.point.lat;
                        console.log(e.point.lng+','+e.point.lat);
                    });
                }
                getlocation();//鼠标点击获取经纬度
                



                var datainfo = [
                    [5.806760, -17.193672, "温室温度:" + lasttemper + "℃"],
                    [-1.110618, 66.459275, "空气湿度:" + lastairhum + "%"],
                    [169.616297, -36.106955, "土壤湿度:" + lastlandhum + "%"],
                    [269.697592, -11.746056, "光照强度:" + lastlight + "lux"],
                    [122.960752, 27.488905, "土壤电导率:" + lastconductance + "mS/cm"]
                    
                ];
                var pointArray = new Array();
                var opts = { width: 250, height: 80, title: "信息窗", enableMessage: true };
                for (var i = 0; i < datainfo.length; i++) {
                    var marker = new BMap.Marker(new BMap.Point(datainfo[i][0], datainfo[i][1]));
                    var content = datainfo[i][2];
                    map.addOverlay(marker);
                    pointArray[i] = new BMap.Point(datainfo[i][0], datainfo[i][1]);
                    marker.setAnimation(BMAP_ANIMATION_BOUNCE);
                    addClickHander(content, marker);
                    var label = new BMap.Label(datainfo[i][2], { offset: new BMap.Size(20, -10) });
                    marker.setLabel(label);
                    marker.addEventListener("click", attribute);
                }
                //获取覆盖物位置
                function attribute() {
                    
                    window.location.href = "查询历史数据.aspx";
                    
                }
                //让所有点在视野范围内
                map.setViewport(pointArray);
                function addClickHander(content, marker) {
                    marker.addEventListener("click", function (e) {
                        openInfo(content, e)
                    });
                }
                function openInfo(content, e) {
                    var p = e.target;
                    var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
                    var infoWindow = new BMap.InfoWindow(content, opts);
                    map.openInfoWindow(infoWindow, point);
                }

            }, error: function () { alert("AJAX请求服务器失败！"); }
        });
    }
    setInterval(myFunction(),50000);
                            
</script>
