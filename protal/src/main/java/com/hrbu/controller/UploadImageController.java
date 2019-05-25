package com.hrbu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping(value="/upload")
public class UploadImageController {

    /**
     * ueditor上传图片的方法
     * @param file 上传图片的文件
     * @param request
     * @param response
     * @return
     */


    public static String UPLOAD_PATH = "D:\\upload\\";


    @RequestMapping(value="/images",method=RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> uploadNewsImg(@RequestParam(value="upfile",required=false) MultipartFile upfile,HttpServletRequest request,HttpServletResponse response) {

        String path = UPLOAD_PATH;
        //图片后缀
        String last = upfile.getOriginalFilename().substring(upfile.getOriginalFilename().lastIndexOf("."), upfile.getOriginalFilename().length());

        String uuid = UUID.randomUUID().toString().replace("-", "");
        String fileName = uuid+last;

        File file = new File(path,fileName);

        Map<String, Object> result = new HashMap<String,Object>();
        try {
            upfile.transferTo(file);
        } catch (IllegalStateException e) {
            System.out.println("富文本编辑器图片上传失败，参数异常："+e);
        } catch (IOException e1) {
            System.out.println("富文本编辑器图片上传失败io异常："+e1);
        }
        result.put("state", "SUCCESS");

//        result.put("url",  upLoadPath.replace("\\", "/")+fileName);
        result.put("url",  "upload/viewImagesToPage?imagePath="+fileName);
        result.put("original", "");   //alt
        result.put("type", last);//后缀
        result.put("size", upfile.getSize());
        result.put("title", fileName);
        return result;
    }

    /**
     * 供读取服务器上传成功的图片显示到jsp上使用(多个图片循环调用)
     * @param request
     * @param response
     * @param fileName  图片地址
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/viewImagesToPage")
    public String viewImagesToPage(HttpServletRequest request,HttpServletResponse response,
                                   @RequestParam(value = "imagePath", required = false) String fileName) {
        System.out.println("fileName:"+fileName);
        ServletOutputStream out = null;
        FileInputStream ips = null;
        try {
            ips = new FileInputStream(new File(UPLOAD_PATH,fileName));


            response.setContentType("multipart/form-data");
            out = response.getOutputStream();
            // 读取文件流
            int i = 0;
            byte[] buffer = new byte[4096];
            while ((i = ips.read(buffer)) != -1) {
                // 写文件流
                out.write(buffer, 0, i);
            }
            out.flush();
            ips.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (out != null) {
                try {
                    out.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            if (ips != null) {
                try {
                    ips.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return null;
    }
}
