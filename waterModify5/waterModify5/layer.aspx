<%@ Page Language="C#" AutoEventWireup="true" CodeFile="layer.aspx.cs" Inherits="testmap" %>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<%--<meta http-equiv="refresh" content="100"/>--%>
<meta name="keywords" content="�ٶȵ�ͼ,�ٶȵ�ͼAPI���ٶȵ�ͼ�Զ��幤�ߣ��ٶȵ�ͼ���������ù���" />
<meta name="description" content="�ٶȵ�ͼAPI�Զ����ͼ�������û��ڿ��ӻ����������ɰٶȵ�ͼ" />
    <script src="js/jquery-1.10.1.min.js"></script>
<title>���ݴ�������ͬѡ��</title>
<!--���ðٶȵ�ͼAPI-->
<style type="text/css">
    html,body{margin:0;padding:0;}
    .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
    .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=57f74e00b43b8a89be4f88f761fe6262"></script>
</head>

<body>
  <!--�ٶȵ�ͼ����-->
  <div style="width:1400px;height:600px;border:#ccc solid 1px;" id="dituContent"></div>
  <select  id="s1" name="oneclass" onchange="chooseLayer()">
    <option selected="selected" >������ģ������ѡ��</option>
    <option >ֻ�б�������</option>
    <option >������Һλ</option>
  </select>
    <select  id="s2" name="oneclass" onchange="choose()">
    <option selected="selected" >���Ƿ�����쳣ѡ��</option>
    <option >������������ģ��</option>
    <option >�����쳣����ģ��</option>
  </select>
    <img src="images/caricon.gif" />�쳣����
    <img src="images/Һλ2.png" />������Һλ���ܾ���
    <img src="images/һ��.png" />ֻ�б������ܾ���
</body>
<script type="text/javascript">

    var jsonData;

    function Layer() //����ͼ���࣬data�洢ͼ�����ݣ�isShow�Ƿ���ʾͼ��
    {
        this.data = new Array();
        this.IsShow = true;
    }
    var wellLayer = new Layer();//����ͼ������
    var levelLayer = new Layer();//Һλͼ��
    var warnLayer = new Layer();//����ͼ��
    var normalLayer = new Layer();//����ͼ��
    //���ݾ���ģ��������ʾͼ�� 
    function showLayer(levelLayer, wellLayer) {
        if (levelLayer.IsShow == true) {
            for (var i = 0; i < levelLayer.data.length ; i++) {
                levelLayer.data[i].hide();
            }
            levelLayer.IsShow = false
        }
        if (wellLayer.IsShow == false) {
            for (var i = 0; i < wellLayer.data.length ; i++) {
                wellLayer.data[i].show();
            }
            wellLayer.IsShow = true;
        }
    }
    //���ݾ���ģ���Ƿ�����쳣��ʾͼ��
    function showLayer1(warnLayer,normalLayer) {
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

    //���ݾ���ģ������ѡ��ͼ��
    function chooseLayer() {
        var index = document.getElementById('s1').selectedIndex;
        if (index == 1) {
            showLayer(levelLayer,wellLayer);
        } else if (index == 2) {
            showLayer(wellLayer,levelLayer);
        }
    }
    //���ݾ����Ƿ�����쳣��ʾͼ��
    function choose() {
        var index = document.getElementById('s2').selectedIndex;
        if (index == 1) {
            showLayer1(warnLayer, normalLayer);
        } else if (index == 2) {
            showLayer1(normalLayer, warnLayer);
        }
    }
    //�����ͳ�ʼ����ͼ������
    function initMap() {
        createMap();//������ͼ
        setMapEvent();//���õ�ͼ�¼�
        addMapControl();//���ͼ���ӿؼ�
        addMarker();//���ͼ������marker
        setInterval("addMarker();", 10000);
    }

    //������ͼ������
    function createMap() {
        var map = new BMap.Map("dituContent");//�ڰٶȵ�ͼ�����д���һ����ͼ
        var point = new BMap.Point(116.417851, 39.924619);//����һ�����ĵ�����
        map.centerAndZoom(point, 14);//�趨��ͼ�����ĵ�����겢����ͼ��ʾ�ڵ�ͼ������
        window.map = map;//��map�����洢��ȫ��
    }

    //��ͼ�¼����ú�����
    function setMapEvent() {
        map.enableDragging();//���õ�ͼ��ק�¼���Ĭ������(�ɲ�д)
        map.enableScrollWheelZoom();//���õ�ͼ���ַŴ���С
        map.enableDoubleClickZoom();//�������˫���Ŵ�Ĭ������(�ɲ�д)
        map.enableKeyboard();//���ü����������Ҽ��ƶ���ͼ
    }

    //��ͼ�ؼ����Ӻ�����
    function addMapControl() {
        //���ͼ���������ſؼ�
        var ctrl_nav = new BMap.NavigationControl({ anchor: BMAP_ANCHOR_TOP_LEFT, type: BMAP_NAVIGATION_CONTROL_LARGE });
        map.addControl(ctrl_nav);
        //���ͼ����������ͼ�ؼ�
        var ctrl_ove = new BMap.OverviewMapControl({ anchor: BMAP_ANCHOR_BOTTOM_RIGHT, isOpen: 0 });
        map.addControl(ctrl_ove);
        //���ͼ�����ӱ����߿ؼ�
        var ctrl_sca = new BMap.ScaleControl({ anchor: BMAP_ANCHOR_BOTTOM_LEFT });
        map.addControl(ctrl_sca);
    }
    //��ע������
    
   

    //����marker
    function addMarker() {


        $.ajax({
            type: "post",   //����ķ��� 
            url: "ajax/point.aspx", //Ҫ���ݲ���ʹ��Ajax���д����������� 
            dataType: "text",   //���ص��������� 
            global: false,  //Ajax�ķ�Χ 
            async: false,   //�첽ִ�� 
            //�ɹ�����µĴ��� 
            success: function (strReult) {

                jsonData = eval("(" + strReult + ")");

            }, //ʧ������µĴ��� 
            error: function () {
                alert("Ajax��������ʧ��!");
            }
        });

        map.clearOverlays();//�����ǵ�

        for (var i = 0; i < jsonData.data.length; i++) {
            var json = jsonData.data[i];
            var p0 = json.longitude;
            var p1 = json.latitude;
            var point = new BMap.Point(p0, p1);
            var iconImg = createIcon(json.icon);
            var status = json.well_Status;//��þ��ǵ�״̬�Ƿ�����
            var myicon = new BMap.Icon("images/caricon.gif", new BMap.Size(32, 70), {    //���屨��ͼ��
                offset: new BMap.Size(0, -5),    //�൱��CSS����
                imageOffset: new BMap.Size(0, 0)    //ͼƬ��ƫ������Ϊ����ͼƬ�ײ����Ķ�׼����㡣
            });


            json.content = "���Ǳ��:" + json.well_ID + "</br>" + "</br>" +        
                "��λ�þ���״��:" + status + "</br>" + "</br>" +
                "<img style='float:right;margin:4px' id='imgDemo'  src='http://cn.gcimg.net/gcproduct/mog_day_111021/111021105800c806c44c58d2df.jpg' width='100' height='80' title='����'/>";


            if (status == "�쳣") {
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
            if (json.well_Type == "ֻ����") {
                wellLayer.data.push(marker);
            }
            else if (json.well_Type == "������Һλ") {
               levelLayer.data.push(marker);
            }
            label.setStyle({
                borderColor: "#808080",
                color: "#333",
                cursor: "pointer"
            });

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
                //������꾭������
                _marker.addEventListener("mouseover", function () {
                    this.openInfoWindow(_iw);
                });

            })()
        }
    }
    //����InfoWindow
    function createInfoWindow(i) {
        var json = jsonData.data[i];
        var p0 = json.longitude;//��þ���
        var p1 = json.latitude;//���γ��
        var iw = new BMap.InfoWindow("<b class='iw_poi_title' title='" + json.well_ID + "'>" + json.well_ID + "</b><div class='iw_poi_content' style='color: #FF0000'>" + json.content + "</div>" + "</b><div class='iw_poi_content'>" + "�������ͣ�" + json.well_Type + "</div>" + "</b><div class='iw_poi_content'>" + "</br>" + "���ȣ�" + p0 + "</div>" + "</div>" + "</b><div class='iw_poi_content'>" + "</br>" + "γ�ȣ�" + p1 + "</div>");
        return iw;
    }
    //����һ��Icon
    function createIcon(json) {
        var icon = new BMap.Icon("http://app.baidu.com/map/images/us_mk_icon.png", new BMap.Size(json.w, json.h), { imageOffset: new BMap.Size(-json.l, -json.t), infoWindowOffset: new BMap.Size(json.lb + 5, 1), offset: new BMap.Size(json.x, json.h) })
        return icon;
    }

    initMap();//�����ͳ�ʼ����ͼ
</script>
</html>