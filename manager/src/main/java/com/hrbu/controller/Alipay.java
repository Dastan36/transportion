package com.hrbu.controller;

import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradeRefundRequest;
import com.alipay.api.response.AlipayTradeRefundResponse;
import com.hrbu.domain.Order;
import com.hrbu.service.compensate.CompensateService;
import com.hrbu.service.order.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.UUID;

@Controller
@RequestMapping("/ali")
public class Alipay {

    @Autowired
    private OrderService orderService;
    @Autowired
    private CompensateService compensateService;


    //goto 理赔退款
    @RequestMapping("/torefundpart")
    public String toRefund(Model model ,String orderId) throws Exception {
        Order order = orderService.selectById(orderId);
        String compensateMoney = compensateService.selectMoneyById(order.getOrderId());
        model.addAttribute("order",order);
        model.addAttribute("compensateMoney",compensateMoney);
        return "ali/refundPart";//refundPart.jsp
    }

    //理赔退款
    @RequestMapping("/refundpart")
    public String refund(Order order) throws Exception {
        AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key,
                "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
        AlipayTradeRefundRequest request = new AlipayTradeRefundRequest();
        //商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = order.getOrderId();
        String compensateMoney = compensateService.selectMoneyById(order.getOrderId());
        //付款金额，必填
        String total_amount = compensateMoney;
        request.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\","
                + "\"out_trade_no\":\""+ out_trade_no +"\","
                + "\"refund_amount\":\""+ total_amount +"\","
                + "\"refund_reason\":\""+ "理赔退款" +"\","
                + "\"out_request_no\":\""+ UUID.randomUUID().toString() +"\"}");
        AlipayTradeRefundResponse response = alipayClient.execute(request);
        if(response.isSuccess()){
            System.out.println("调用成功");
        } else {
            System.out.println("调用失败");
            System.out.println( response.getSubMsg());
        }
        return "redirect:/index";
    }
}
