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
     <%--<meta http-equiv="refresh" content="100"/>ˢ��--%>    
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="keywords" content="�ٶȵ�ͼ,�ٶȵ�ͼAPI���ٶȵ�ͼ�Զ��幤�ߣ��ٶȵ�ͼ���������ù���" />
<meta name="description" content="�ٶȵ�ͼAPI�Զ����ͼ�������û��ڿ��ӻ����������ɰٶȵ�ͼ" />
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

    <title>������ˮ����ϵͳ����ҳ</title>
<!--���ðٶȵ�ͼAPI-->
<style type="text/css">
    body{margin:0;padding:0;}
    .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
    .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
</style>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=57f74e00b43b8a89be4f88f761fe6262"></script>
</head>
<body>
    
  <!--�ٶȵ�ͼ����-->
   <div style="width:1300px;height:600px;border:#ccc solid 1px;" id="dituContent"></div>
    <input id="Button1" type="button" value="�鿴������Ϣ" />
    <input id="Button2" type="button" value="�鿴Һλ��Ϣ" />
   <img src="images/caricon.gif" />�쳣���Ǳ���
    <img src="images/ˮλ.png" />��⹦�ܺ�Һλ
    <img src="images/һ��.png" />ֻ�м�⹦��
   
</body>
</html>

<script type="text/javascript">
    var jsonData;
    //var preMarker;


    //��ʼ����ͼ
    function initMap() {
        createMap();//������ͼ
        setMapEvent();//���õ�ͼ�¼�
        addMapControl();//���ͼ��ӿؼ�
        addMarker();//���ͼ�����marker
        setInterval("addMarker();", 10000);   //ˢ��
        //setInterval("refreshIcon();", 10000);
    }

    //������ͼ����
    function createMap() {
        var map = new BMap.Map("dituContent");//�ڰٶȵ�ͼ�����д���һ����ͼ
        var point = new BMap.Point(116.394388, 39.951807);//����һ�����ĵ�����
        map.centerAndZoom(point, 15);//�趨��ͼ�����ĵ�����겢����ͼ��ʾ�ڵ�ͼ������
        window.map = map;//��map�����洢��ȫ��
    }

    //��ͼ�¼����ú���
    function setMapEvent() {
        map.enableDragging();//���õ�ͼ��ק�¼���Ĭ�����ã��ɲ�д��
        map.enableScrollWheelZoom();//���õ�ͼ���ַŴ���С
        map.enableDoubleClickZoom();//�������˫���Ŵ�Ĭ������(�ɲ�д)
        map.enableKeyboard();//���ü����������Ҽ��ƶ���ͼ
    }

    //��ͼ�ؼ���Ӻ���
    function addMapControl() {
        //���ͼ��������ſؼ�
        var ctrl_nav = new BMap.NavigationControl({ anchor: BMAP_ANCHOR_TOP_LEFT, type: BMAP_NAVIGATION_CONTROL_LARGE });
        map.addControl(ctrl_nav);
        //���ͼ���������ͼ�ؼ�
        var ctrl_ove = new BMap.OverviewMapControl({ anchor: BMAP_ANCHOR_BOTTOM_RIGHT, isOpen: 1 });
        map.addControl(ctrl_ove);
        //���ͼ����ӱ����߿ؼ�
        var ctrl_sca = new BMap.ScaleControl({ anchor: BMAP_ANCHOR_BOTTOM_LEFT });
        map.addControl(ctrl_sca);
    }




    //����marker
    function addMarker() {

        //var jsonData;
        $.ajax({
            type: "post",   //����ķ��� 
            url: "ajax/point.aspx", //Ҫ���ݲ���ʹ��Ajax���д���������� 
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

        //ѭ����ӱ�ǵ�
        for (var i = 0; i < jsonData.data.length; i++) {
            var json = jsonData.data[i];
            var p0 = json.longitude;//��þ���
            var p1 = json.latitude;//���γ��

            var status = json.well_Status;//��þ��ǵ�״̬�Ƿ�����
            var point = new BMap.Point(p0, p1);//����������

            var iconImg = createIcon(json.icon);//��ñ�עͼ��
            //var levelTime = json.level_time;//��þ��ǵ�״̬����ʱ��
            var myDate = new Date();
            var levelTime = myDate.toLocaleString();

            var myicon = new BMap.Icon("images/caricon.gif", new BMap.Size(30, 60), {    //���屨��ͼ��
                offset: new BMap.Size(0, -5),
                imageOffset: new BMap.Size(0, 0)    //ͼƬ��ƫ������Ϊ����ͼƬ�ײ����Ķ�׼����㡣
            });

            //���崰�ڵ�����
            json.content = "���Ǳ��:" + json.well_ID + "</br>" + "</br>" +
                "��λ�þ���״��:" + status + "</br>" + "</br>" +
                "��λ�þ��Ǹ���ʱ��:" + levelTime + "</br>" + "</br>" +
                "<img style='float:right;margin:4px' id='imgDemo'  src='http://cn.gcimg.net/gcproduct/mog_day_111021/111021105800c806c44c58d2df.jpg' width='100' height='80' title='����'/>";;


            //���ݾ���״̬�Ĳ�ͬ���Ʋ�ͬ��ͼ��
            if (status == "�쳣") {
                var marker = new BMap.Marker(point, { icon: myicon });

            }
            else {
                var marker = new BMap.Marker(point, { icon: iconImg });

            }
            //var marker = new BMap.Marker(point, { icon: iconImg });

            //������ʾ��Ϣ�Ĵ���
            var iw = createInfoWindow(i);
            var label = new BMap.Label(json.well_ID, { "offset": new BMap.Size(json.icon.lb - json.icon.x + 10, -20) });

            marker.setLabel(label);//��ӱ�ǩ

            map.addOverlay(marker);
            var preMarker = marker;
            //map.removeOverlay(preMarker);



            label.setStyle({
                borderColor: "#808080",
                color: "#333",
                cursor: "pointer"
            });

            //( function refresh() { marker.setLabel(label);//��ӱ�ǩ
            //    map.addOverlay(marker);
            //})()//��ӱ�ǵ�}


            // setInterval("refresh();", 10000);
            //setInterval("refreshIcon("+marker+");", 10000);

            (function () {
                var index = i;
                var _iw = createInfoWindow(i);
                var _marker = marker;

                //�����꾭������
                _marker.addEventListener("mouseover", function () {
                    this.openInfoWindow(_iw);
                });
                //��ӵ���ļ����¼�
                _marker.addEventListener("click", function () {
                    this.openInfoWindow(_iw);
                });
                //��Ӵ��ڴ򿪼���
                _iw.addEventListener("open", function () {
                    _marker.getLabel().hide();
                })
                //��Ӵ��ڹرռ���
                _iw.addEventListener("close", function () {
                    _marker.getLabel().show();
                })
                //��Ӵ��ڵ������
                label.addEventListener("click", function () {
                    _marker.openInfoWindow(_iw);
                })
                //�����Ƿ�򿪺�����ʾ�������ش���
                if (!!json.isOpen) {
                    label.hide();
                    _marker.openInfoWindow(_iw);
                }
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
