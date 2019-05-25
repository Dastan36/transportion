package com.hrbu.controller;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.request.AlipayTradeRefundRequest;
import com.alipay.api.response.AlipayTradeRefundResponse;
import com.hrbu.domain.Order;
import com.hrbu.service.order.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/ali")
public class Alipay {

    @Autowired
    private OrderService orderService;

    //第一次下单时 付款
    @RequestMapping("/toindex")
    public String index(Model model, HttpSession session, Order order) throws Exception {
        order.setOrderId(UUID.randomUUID().toString());
        model.addAttribute("order",order);
        Map map = new HashMap<>();
        map.put("orderId",order.getOrderId());
        map.put("userId",session.getAttribute("userId"));
        map.put("senderName",order.getSenderName());
        map.put("senderPhone",order.getSenderPhone());
        map.put("senderStation",order.getSenderStation());
        map.put("receiptName",order.getReceiptName());
        map.put("receiptPhone",order.getReceiptPhone());
        map.put("receiptStation",order.getReceiptStation());
        map.put("goodsName",order.getGoodsName());
        map.put("goodsWeight",order.getGoodsWeight());
        map.put("goodsVolume",order.getGoodsVolume());
        map.put("money",order.getMoney());
        //map.put("moneyStatus",moneyStatus);
        map.put("transTime",order.getTransTime());
        map.put("createTime",new Date());

        if ("在线支付".equals(order.getMoneyStatus())){
            map.put("moneyStatus","在线支付(待支付)");
            orderService.insertOrder(map);
            return "ali/pay"; //pay.jsp
        }else{
            map.put("moneyStatus","到付(待支付)");
            orderService.insertOrder(map);
            return "redirect:/order/orderlist";
        }

    }

    //为付款 保留订单之后付款   pay.jsp
    @RequestMapping("/totoindex")
    public String totoIndex(Model model,Order order){
        model.addAttribute("order",order);
        return "ali/pay";
    }

    @RequestMapping("/pay")
    public void  pay(Order order,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获得初始化的AlipayClient
        AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key,
                "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
        //设置请求参数
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl(AlipayConfig.return_url);
        alipayRequest.setNotifyUrl(AlipayConfig.notify_url);//异步回调地址
        //商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = order.getOrderId();
        //付款金额，必填
        String total_amount = order.getMoney();
        //订单名称，必填
        String subject = "铁路货运";
        //商品描述，可空
        String body = order.getGoodsName() + "  " + order.getSenderStation() + "  " + order.getReceiptStation();

        alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\","
                + "\"total_amount\":\""+ total_amount +"\","
                + "\"subject\":\""+ subject +"\","
                + "\"body\":\""+ body +"\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

        //请求
        String result;
        try {
            result = alipayClient.pageExecute(alipayRequest).getBody();
            System.out.println(result);
            response.setContentType("text/html;charset=" + AlipayConfig.charset);
            response.getWriter().write(result);//直接将完整的表单html输出到页面
            response.getWriter().flush();
            response.getWriter().close();
        } catch (AlipayApiException e) {
            e.printStackTrace();
            response.getWriter().write("捕获异常出错");
            response.getWriter().flush();
            response.getWriter().close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //goto 退款
    @RequestMapping("/torefund")
    public String toRefund(Model model ,String orderId) throws Exception {
        Order order = orderService.selectById(orderId);
        model.addAttribute("order",order);
        return "ali/refund";//refund.jsp
    }

    //客户取消订单 退款
    @RequestMapping("/refund")
    public String refund(Order order) throws Exception {
        AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key,
                "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
        AlipayTradeRefundRequest request = new AlipayTradeRefundRequest();
        //商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = order.getOrderId();
        //付款金额，必填
        String total_amount = order.getMoney();
        request.setBizContent("{" +
                "    \"out_trade_no\":\""+out_trade_no+"\"," +
                "    \"refund_amount\":"+total_amount+"," +
                "    \"refund_reason\":\"正常退款\"," +
                "    \"out_request_no\":\"HZ01RF001\"," +   // 可选   标识一次退款请求，同一笔交易多次退款需要保证唯一，如需部分退款，则此参数必传。
                "    \"operator_id\":\"OP001\"," +//可选 	商户的操作员编号
                "    \"store_id\":\"NJ_S_001\"," +//可选 	商户的门店编号
                "    \"terminal_id\":\"NJ_T_001\"" +//可选 	商户的终端编号
                "  }");
        AlipayTradeRefundResponse response = alipayClient.execute(request);
        if(response.isSuccess()){
            System.out.println("调用成功");
            orderService.cancelOrder(order.getOrderId());
        } else {
            System.out.println("调用失败");
        }
        return "redirect:/center";
    }
}
