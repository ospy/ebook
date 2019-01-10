<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/Master/header.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>生成订单</title>
<link type="text/css" rel="stylesheet" href="<%=path%>/Css/order.css" />
</head>
<%  
      String price = request.getParameter("price");
      String type = request.getParameter("type"); 
     
      %>  
<body>
       
      <h1 class="mod-title">
		<span id="paylogo" class="ico-wechat"></span><span class="text">微信支付</span>
	  </h1>
	  <div class="orderbox">
		<div class="mod-ct">
			<div class="order">
			      
			</div>
			<div class="order-amount"><span id="pricetip">充值金额：￥</span><span id="orderprice">20</span></div>
			<div id="qrcode"  title="">
	          <img style="display: initial;" src="" width="160px" height="160px">
	          <div class="countdown">订单关闭倒计时：<span id="minute_show"></span>分<span id="second_show"></span>秒</div>
	         </div>
			<div class="tip">
				<span class="dec dec-left"></span>
				<span class="dec dec-right"></span>
				<div class="ico-scan"></div>
				<div class="tip-text">
				<p>请使用手机<span class="payname"></span>扫一扫</p>
				<p>扫描二维码完成支付</p>
				</div>
			
			</div> 
			<div id="orderDetail" class="detail detail-open">
				<dl style="display: block;" class="detail-ct">
					<dt>商家：</dt>
					<dd id="storeName">imed120.com</dd>
					<dt>购买物品：</dt>
					<dd id="productName"></dd>
					<dt>商户订单号：</dt>
					<dd id="billId"></dd>
					<dt>创建时间：</dt>
					<dd id="createTime"></dd>
				</dl>
				<span class="arrow" href="javascript:void(0)"><i class="ico-arrow"></i></span>
			</div>

			<div class="tip-text">
			</div>
		  </div>
		</div>
		
	<div id="myModal" class="modal  fade"  tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"  aria-hidden="true">×</button>
                    <h2 class="modal-title">充值成功 <span id="currdate" class="currdate"></span></h2>
                </div>
                <div id="mymodal-body" class="modal-body">
                   <h2 class="booktitle"><span class="succ"></span>恭喜你！充值成功。订单页将被关闭。</h2>
                </div>
                <div class="modal-footer">
                    
                    <button type="button" id="downsubmit" class="btn btn-primary" onclick="shutdown()">确定</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
<script>
       
        checklogin();
		var type="<%=type%>";
		var price="<%=price%>";
		
		var lefttime=300;
		var orderid=0;
		$("#orderprice").html(price);
		var fromurl="<%= request.getRequestURL().toString()%>";
		//alert(fromurl);
		$(function() {           
              if(type=="wechat"){           	 
            	  $("#paylogo").removeClass().addClass("ico-wechat");
            	  $(".mod-title .text").html("微信支付");
            	  $(".payname").html("微信");
              }
              if(type=="alipay"){           	 
            	  $("#paylogo").removeClass().addClass("ico-alipay");
            	  $(".mod-title .text").html("支付宝支付");
            	  $(".payname").html("支付宝");
              }
              checkOrder();
	    }); 
		
		function checkOrder(){			
			$.ajax({
	            url: "<%=path%>/CheckOrder",
	            type: 'POST',
	            async: true,
	            timeout: 30000, //超时时间设置，单位毫秒
	            dataType: 'json',
	            data: {type:type,price:price },
	            success: function (result) {
	                if (result !=null&&result !="") {
	                	for(var i=0;i < result.length;i++ ){
	                		var src='/Images/'+type+'/'+price+'/'+result[i].real_price+".png";
	                		$("#qrcode img").attr('src',src);
	                		$("#qrcode img").attr('title',result[i].real_price);
	                		$("#productName").html("账户充值"+price*10+"下载点");
	                		var time = result[i].generate_time.replace(new RegExp(/[^0-9]/g),"");
	                		orderid=result[i].order_id;
	                		$("#billId").html(time+"00"+result[i].order_id);
	                		$("#createTime").html(result[i].generate_time);
	                		lefttime=result[i].left_time;
	                	}
	                	timer(lefttime,orderid); 
	                } else {
	                	GeneOrder();
	                }
	            },
	            error: function () {
	                alert("获取有效订单错误，请发送邮件至：imed120@163.com！");
	                return;
	            }
	        });	
			return false;
		}
	function GeneOrder(){	
		$.ajax({
            url: "<%=path%>/GeneOrder",
            type: 'POST',
            async: true,
            timeout: 30000, //超时时间设置，单位毫秒
            dataType: 'json',
            data: { type: type, price: price},
            success: function (result) {
                if (result !=null&&result !="") {
                   if(result=="-1"){
                	   alert("超出价格范围，请5分钟后重新生成！"); 
                   }else{
                	   for(var i=0;i < result.length;i++ ){
                   		var src='/Images/'+type+'/'+price+'/'+result[i].real_price+".png";
                   		$("#qrcode img").attr('src',src);
                   		$("#qrcode img").attr('title',result[i].real_price);
                   		$("#productName").html("账户充值"+price*10+"下载点");
                   		var time = result[i].generate_time.replace(new RegExp(/[^0-9]/g),"");
                   		orderid=result[i].order_id;
                   		$("#billId").html(time+"00"+result[i].order_id);
                   		$("#createTime").html(result[i].generate_time);
                   		lefttime=result[i].left_time;
                   	}
                	   timer(lefttime,orderid);
                   }               	
                } 
                else {
                	 alert("生成订单失败，请发送邮件至：imed120@163.com！");
                }
            },
            error: function (data,error) {
                alert("生成订单错误，请重新生成订单页。");
                
            }
        });
		return false;
	}	
		
	function timer(intDiff,orderid) {
		    window.setInterval(function () {
		        var minute = 0,
		            second = 0; //时间默认值
		        if (intDiff > 0) {		          
		            minute = Math.floor(intDiff / 60)
		            second = Math.floor(intDiff) - (minute * 60);
		        }
		        if (minute <= 9) minute = '0' + minute;
		        if (second <= 9) second = '0' + second;

		        $('#minute_show').text(minute);
		        $('#second_show').text(second );
		        if(minute==0&&second==0){
		            alert("订单已超时关闭！");
		            shutdown();
		        } 
		        intDiff--;
		       checksucc(orderid);
		    }, 1000);
		}
	function checksucc(orderid){
		$.ajax({
            url: "<%=path%>/CheckSucc",
            type: 'POST',
            async: false,
            dataType: 'json',
            data: {orderid:orderid},
            success: function (result) {
            	if(result==0){
            		alert("获取订单ID失败，请发送邮件至：imed120@163.com！");
            	}
            	else if(result[0].pay_state==2){
            		alert("订单已超时关闭！");
            		shutdown();
            	}
            	else if (result[0].pay_state==3&&result[0].pay_time!="") {
            		$("#myModal").modal("show");
                	} 
            },
            error: function () {
                alert("获取有效订单错误，请发送邮件至：imed120@163.com！");
                return;
            }
        });	 	
	}
	function shutdown() {     
		//判断是否为ie
        if (navigator.userAgent.indexOf("MSIE") > 0) {
            //判断是否为ie6
            if (navigator.userAgent.indexOf("MSIE 6.0") > 0) {
                window.opener = null; window.close();
            }
            else {
                window.open('', '_top');
                window.top.close();
            }
        }
        //判断是否为firefox
        else if (navigator.userAgent.indexOf("Firefox") > 0) {
        	window.close();
        }
        //其他非firefox等主流浏览器如chrome,safari
        else {
            window.opener = null; 
            window.open('', '_self', '');
            window.close();
        }
	}
	$('#myModal').on("hidden.bs.modal", function () {
		//关闭模态框后清除模态框数据
		shutdown();
		});
		</script>
</body>
</html>