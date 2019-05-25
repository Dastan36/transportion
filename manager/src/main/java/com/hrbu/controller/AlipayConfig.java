package com.hrbu.controller;

import java.io.FileWriter;
import java.io.IOException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {
	
//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

	// 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
	public static String app_id = "2016093000635203";
	
	// 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCxXYHY5bg+foUJr91LGXEGSrFyxZ4WszwfKJ4r2gdWFvKWUzC23IuWX/65jYoPL4H8+nfvgVA3rRkFoYT7343miJgGfyZkxgSA6RnEp/DfI4/7IqDGqZV1CW0R7+1dD8SowGk5H0q3w0HwHGJNidmLqoa22DcYfUiCKyUW0Ci+dURjrm57O9VYLfssfiMZWhQRrRGbEG3rDRe+zWR99S110W97D2pipRW6NEiInLxXBoWtE99pJUWw+28hXjc8u4TOgdCVHVhtzwaGZXXz5uLrTO0upR4sIFRMZQ+VtHF/4nOtm8eUm7gXgIU30qWqr3Qx8ymttBeEFB9k0PVqXECXAgMBAAECggEAGFJlSvP9dvxsi+6E3xaHDEDT4pQ84IoFlZRBVGwak3CkJX8U8A6ASceyK4nAQ+LU5XcHWV2XPXtMMhx7GvsF/3X9uu5Wunz5AyBz+ya4fjDnPp36BCQfLaR0Q4BuQVO3ORjhlQa4fUiWUzHhPRbJMUDaJlqx+3a6qbb26BD1dWBu5fHUtyDQLSJkIjbPcI064An2ikWJlEDG481kaYdaFpB/GUVG9AGJXrNgicJMlxvNpM91J2zoniVY7zGPpXmpLe2M9O6c2GYKiBUm4fWu0f3b2wUpI/7m4Gf14VOqCvAe3hNk9pKjbztJwRlYjyRXd/eSg/WxyX7EQ/To/vO6sQKBgQDW3cTkoaIj4EJVe0tD18f0hTMHg1WrRmU0nyxNvcRE3GQuRGXrM59Zmd+TINZrSj3XDS3VLCMmoTJTPCp7031SwWBtMQ5QdpT2G6yQexr0+tWxEY+XUu5UGyY8tt1RtL/lSexQCjOP5754/1YME+oBwL2nUM45btCIVjw9DcKyTwKBgQDTUeB2FQjkbj9qbMcmQqmj4pfgNlIjEqgyTAe+rPEGvU1NsmSOKLaQDWUqnqR+h6GMy3M+e/WsAb5A8I3AR/aJHW6PGjyAHhzlmXnjIgNs90ElIRJU7+z0j7yboPRBIgo04c/pMveqy/PP/bfUy+2fcM8eRyECxGCuQIonQpJjOQKBgFJJzp0tFdadjWoFdRa/bhHEbX2kG8wjgqD7kNEZKzCgIzHg+hNwysda+df0DIo8faB9qJ7qb2/c7lQYR8Dyhx2Jd695yRyhvXzfrmAK9ZD6+5n7ur1egm3tk+BOvEYNbiyW+gzRS1wCidz3FPI9MjKHqVqJxOEUAoMkW5+aRIVbAoGBALoLIZSUHEoQDeDCd+plUjioq5GIAXRDXrU5XrAuTdzjGIXJAuJtUZ0tTd3h4WxMOJxeGc3vEHEo77j4j7OzJ4e707RFIvKgkExLfJXNQjrSzBXGMf95Y6JEUYaqg6A8OcQo8gSbDJTgDn0VIJ1GFKQEizRa5uMqxPtkcrzxzTNxAoGBAIAk2kl7pVbJkJFKDVJtltQoPgXLnL3vTbK/iL/iBtZpWDQiO5XQ/41d2JauuXgNDYiS0q6V/cacpgbOm4LPKW2Y/lLf9Yoc/91UBbzgyIrvPwexT0z/wtxmzZ4Bgw49S+uPClTcfQTJ5XjDhmOFH7D4g8Bj5AE0nPJJ7Cmcg4yy";

    // 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAl3NG+tQjOMRRJSZu5z5X3Ol3Qq0Mdeec1+kkwzl6GGPwfy0eHnKx8E1DGUxxOJCsNttNX/VWfBXxOJlkqFh3BMaEAsz8aIXu09bWPRG/WT/Zv8B/iyB802Pdn5eT928lJqG+CCx+CFnuL1BgrOiFZ+ERNM2P0nuWPUuGO/EqmJWq4mbEbZkTcD9yMkrzep2l1Xg56E0RS0VjOnNFfgnVyHcm4dXPLWc0fmuZNt2YZpaIKUBapnV0Mtv4ZwCmv71f+38QUreJz4MWs/FQwI+itxQOv7MnEvXBkDGxT4ONPBidrugHS0LQ+wsHDVgRwQ8F5zoZkEtBbB2YZTGjw+HbtwIDAQAB";

	// 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String notify_url = "http://localhost:8080/transportion/protal/notify/notifyurl";
    //http://localhost:8080/transportion/protal/return/returnurl
	// 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String return_url = "http://localhost:8080/transportion/protal/return/returnurl";

	// 签名方式
	public static String sign_type = "RSA2";
	
	// 字符编码格式
	public static String charset = "utf-8";
	
	// 支付宝网关
	public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";
	
	// 支付宝网关
	public static String log_path = "C:\\";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /** 
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

