package com.hrbu.sysfranework.intercetor;

import com.hrbu.domain.Admin;
import com.hrbu.domain.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ProtalIntercetor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String url = request.getRequestURI();
        HttpSession session = request.getSession();
        Object login = session.getAttribute("login");

        boolean isLogin = false;
        if(login != null){
            isLogin = true;
        }

        if(url.indexOf("/login")>0 || isLogin){
            return true;
        }

        User user = (User) session.getAttribute("user");
        if(user != null){
            return true;
        }

        request.getRequestDispatcher("login.jsp").forward(request,response);
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
