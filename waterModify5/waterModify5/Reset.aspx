<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reset.aspx.cs" Inherits="Reset" %>

<!DOCTYPE html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="keywords" content="百度地图,百度地图API，百度地图自定义工具，百度地图所见即所得工具" />
<meta name="description" content="百度地图API自定义地图，帮助用户在可视化操作下生成百度地图" />
<title>根据传感器不同选择</title>
<!--引用百度地图API-->
<style type="text/css">
    html,body{margin:0;padding:0;}
    .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
    .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=57f74e00b43b8a89be4f88f761fe6262"></script>
</head>

<body>
    <form id="form1" runat="server">
  <!--百度地图容器-->
  <div style="width:1400px;height:600px;border:#ccc solid 1px;" id="dituContent"></div>

    <select  id="s2" name="oneclass" onchange="choose()">
    <option selected="selected" >按是否出现异常选择</option>
    <option >功能正常井盖模块</option>
    <option >出现异常井盖模块</option>
  </select>
    <img src="images/caricon.gif" />异常井盖
    <img src="images/液位2.png" />报警及液位功能井盖
    <img src="images/一般.png" />只有报警功能井盖
 
   <asp:Button ID="btn1" runat="server" Height="29px" OnClick="Button1_Click" style="margin-left: 10px" Text="所有模块故障已排除" Width="143px" />
 
    </form>
</body>
<script type="text/javascript">
    function Layer() //定义图层类，data存储图层数据，isShow是否显示图层
    {
        this.data = new Array();
        this.IsShow = true;
    }
   
    var warnLayer = new Layer();//报警图层
    var normalLayer = new Layer();//正常图层

    //根据井盖模块是否出现异常显示图层
    function showLayer1(warnLayer, normalLayer) {
        if (warnLayer.IsShow == true) {
            for (var i = 0; i < warnLayer.data.length ; i++) {
                warnLayer.data[i].hide();
            }
            warnLayer.IsShow = false
        }
        if (normalLayer.IsShow == false) {
            for (var i = 0; i < normalLayer.data.length ; i++) {
                normalLayer.data[i].show();
            }
            normalLayer.IsShow = true;
        }
    }

 
    //根据井盖是否出现异常显示图层
    function choose() {
        var index = document.getElementById('s2').selectedIndex;
        if (index == 1) {
            showLayer1(warnLayer, normalLayer);
        } else if (index == 2) {
            showLayer1(normalLayer, warnLayer);
        }
    }
    //创建和初始化地图函数：
    function initMap() {
        createMap();//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
        addMarker();//向地图中添加marker
    }

    //创建地图函数：
    function createMap() {
        var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
        var point = new BMap.Point(116.417851, 39.924619);//定义一个中心点坐标
        map.centerAndZoom(point, 12);//设定地图的中心点和坐标并将地图显示在地图容器中
        window.map = map;//将map变量存储在全局
    }

    //地图事件设置函数：
    function setMapEvent() {
        map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
        map.enableScrollWheelZoom();//启用地图滚轮放大缩小
        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard();//启用键盘上下左右键移动地图
    }

    //地图控件添加函数：
    function addMapControl() {
        //向地图中添加缩放控件
        var ctrl_nav = new BMap.NavigationControl({ anchor: BMAP_ANCHOR_TOP_LEFT, type: BMAP_NAVIGATION_CONTROL_LARGE });
        map.addControl(ctrl_nav);
        //向地图中添加缩略图控件
        var ctrl_ove = new BMap.OverviewMapControl({ anchor: BMAP_ANCHOR_BOTTOM_RIGHT, isOpen: 0 });
        map.addControl(ctrl_ove);
        //向地图中添加比例尺控件
        var ctrl_sca = new BMap.ScaleControl({ anchor: BMAP_ANCHOR_BOTTOM_LEFT });
        map.addControl(ctrl_sca);
    }
    //标注点数组
    var markerArr =<%getDataset();%>


    //创建marker
    function addMarker() {
        for (var i = 0; i < markerArr.length; i++) {
            var json = markerArr[i];
            var p0 = json.longitude;
            var p1 = json.latitude;
            var point = new BMap.Point(p0, p1);
            var iconImg = createIcon(json.icon);
            var status = json.well_Status;//获得井盖的状态是否正常
            var myicon = new BMap.Icon("images/caricon.gif", new BMap.Size(32, 70), {    //定义报警图标
                offset: new BMap.Size(0, -5),    //相当于CSS精灵
                imageOffset: new BMap.Size(0, 0)    //图片的偏移量。为了是图片底部中心对准坐标点。
            });


            json.content = "井盖编号:" + json.well_ID + "</br>" + "</br>" +
                "该位置井盖状况:" + status + "</br>" + "</br>" +
                "<img style='float:right;margin:4px' id='imgDemo'  src='http://cn.gcimg.net/gcproduct/mog_day_111021/111021105800c806c44c58d2df.jpg' width='100' height='80' title='井盖'/>";


            if (status == "异常") {
                var marker = new BMap.Marker(point, { icon: myicon });
                warnLayer.data.push(marker);
            }
            else {
                var marker = new BMap.Marker(point, { icon: iconImg });
                normalLayer.data.push(marker);
            }


            //var marker = new BMap.Marker(point, { icon: iconImg });
            var iw = createInfoWindow(i);
            var label = new BMap.Label(json.well_ID, { "offset": new BMap.Size(json.icon.lb - json.icon.x + 10, -20) });
            marker.setLabel(label);
            map.addOverlay(marker);
           
            (function () {
                var index = i;
                var _iw = createInfoWindow(i);
                var _marker = marker;
                _marker.addEventListener("click", function () {
                    this.openInfoWindow(_iw);
                });
                _iw.addEventListener("open", function () {
                    _marker.getLabel().hide();
                })
                _iw.addEventListener("close", function () {
                    _marker.getLabel().show();
                })
                label.addEventListener("click", function () {
                    _marker.openInfoWindow(_iw);
                })
                if (!!json.isOpen) {
                    label.hide();
                    _marker.openInfoWindow(_iw);
                }
                //添加鼠标经过监听
                _marker.addEventListener("mouseover", function () {
                    this.openInfoWindow(_iw);
                });

            })()
        }
    }
    //创建InfoWindow
    function createInfoWindow(i) {
        var json = markerArr[i];
        var p0 = json.longitude;//获得经度
        var p1 = json.latitude;//获得纬度
        var iw = new BMap.InfoWindow("<b class='iw_poi_title' title='" + json.well_ID + "'>" + json.well_ID + "</b><div class='iw_poi_content' style='color: #FF0000'>" + json.content + "</div>" + "</b><div class='iw_poi_content'>" + "井盖类型：" + json.well_Type + "</div>" + "</b><div class='iw_poi_content'>" + "</br>" + "经度：" + p0 + "</div>" + "</div>" + "</b><div class='iw_poi_content'>" + "</br>" + "纬度：" + p1 + "</div>" + "<input id='Button1' type='button' value='异常已排除' onclick=update()  /> ");
        return iw;
    }
    //创建一个Icon
    function createIcon(json) {
        var icon = new BMap.Icon("http://app.baidu.com/map/images/us_mk_icon.png", new BMap.Size(json.w, json.h), { imageOffset: new BMap.Size(-json.l, -json.t), infoWindowOffset: new BMap.Size(json.lb + 5, 1), offset: new BMap.Size(json.x, json.h) })
        return icon;
    }

    function update() {
        //alert("Bingo");
        document.getElementById("btn1").click();
        

    }


    initMap();//创建和初始化地图
</script>
</html>
