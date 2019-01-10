<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@ include file="/Master/header.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单选择</title>
<link type="text/css" rel="stylesheet" href="<%=path%>/Css/order.css" />
</head>
<body>
<form id="selectForm" action="/DoOrder/Order.jsp" method="post">
	  <div class="orderbox">
		<div class="mod-ct">
			<div class="order">
			
			</div>
			<div class="amount" ><span class="title">充值金额：</span><span id="price">20</span>元<div id="addgroups" class="btn-group">
                
                <div class="btn-group">
                  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" id="changebtn">
                    <span class="buttonText"><i id="dropdownMenu2" class="fa fa-eye"></i></span>
                    <span class="caret"></span>
                  </button>
                  <ul class="dropdown-menu" role="menu">
                    <li>
                      <a href="#" onclick="change(20)"><i class="fa fa-pencil">20元</i></a>
                    </li>
                    <li>
                      <a href="#" onclick="change(50)"><i class="fa fa-eye">50元</i></a>
                    </li>
                    <li>
                      <a href="#" onclick="change(100)"><i class="fa fa-eye-slash">100元</i></a>
                    </li>
                     <li>
                      <a href="#" onclick="change(200)"><i class="fa fa-eye-slash">200元</i></a>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
             <div class="amount" ><span class="title">充值点数：</span><span id="point">200</span><span id="plus"></span>
            </div>
            <div class="pic">
					<div id="wechat" class="ql-image picture selected" title="">
					   <img  src="/Images/logoes/wechat.png">
					   <span class="right"></span>
					</div>
					<div id="alipay" class="qr-image picture" title="">
					   <img  src="/Images/logoes/alipay.png">
					    <span class="right"></span>
					</div> 
			</div>
			<div id="orderDetail" class="detail detail-open">
				<input type="button" onclick="getOrder();" class="submit" id="save" value="生成订单">
			</div>
			<div class="tip">
			    
				<span class="dec dec-left"></span>
				<span class="dec dec-right"></span>
							
			</div>
			  <div class="tip-text">
                <h2>充值规则：</h2>
                <p>1.兑换规则为<b>1元=10下载点</b>;</p>
                <p>2.订单生成后须在5分钟内完成支付，否则在5分钟后订单页面将自动关闭;</p>
                <p>3.充值100元（含）以上赠送10%下载点;</p>
                <p>4.支付二维码为随机生成，实际支付金额可能会有5分以内误差;</p>
			</div>				
		</div>
          
		  </div>
		</div>
		</form>
<script>
        
        checklogin();

		function change(value) {
			if(value<100){
				 $("#price").html(value);
			     $("#point").html(value*10);
			     $("#plus").html("");
			}
			else if(value>=100){
				 $("#price").html(value);
			     $("#point").html(value*10);
			     $("#plus").html("+"+value);
			}
		      // $('.buttonText').text(a)
		    }
		$(".picture").click(function(){
			
			  $(this).siblings(".picture").removeClass("selected");
			  $(this).addClass("selected");
			});
		function getOrder(){
			var price=$("#price").html();
			var type=$(".selected").attr("id");
			var url="/DoOrder/Order.jsp";
			$.StandardPost(url,{'price':price,'type':type});
		}
			
		$.extend({
			StandardPost:function(url,args){
				var body = $(document.body),
					form = $("<form method='post'  target='_blank'></form>"),
					input;
				form.attr({"action":url});
				$.each(args,function(key,value){
				input = $("<input type='hidden'>");
				input.attr({"name":key});
				input.val(value);
				form.append(input);
			});
			form.appendTo(document.body);
			form.submit();
			document.body.removeChild(form[0]);
			}
		});

		</script>
</body>
</html>