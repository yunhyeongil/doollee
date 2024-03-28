package bt.btframework.aops;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import bt.btframework.common.vo.LoginVO;
import bt.btframework.utils.Constants;
import bt.btframework.utils.StringUtils;

public class ServiceInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(ServiceInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		LoginVO userInfo = (LoginVO) request.getSession().getAttribute("loginVO");

		String requestURI = request.getRequestURI(); // 요청 URI
		// log.debug(String.valueOf(requestURI.indexOf("/comm/login.do")));
		
		if (userInfo != null) { //윤형일 수정
			logger.info("[USER ID: " + userInfo.getUserId() + "][REQUEST URI: " + requestURI + "]");
		    //logger.debug("[REQUEST URI: " + requestURI + "]");
		}
		
		if ( requestURI.indexOf("/login/login.do") < 0 && 
				requestURI.indexOf("/index.do") < 0 &&
				requestURI.indexOf("/login/actionLogin.do") < 0 &&
				requestURI.indexOf("/login/sessionout.do") < 0) {
			// 정상적인 세션정보가 없으면 로그인페이지로 이동
			if (userInfo == null) {
				if (request.getHeader(Constants.METHOD_ID) != null) {
					// Ajax일 경우
					response.sendError(991);
					response.sendRedirect("/login/login.do");
				}
				ModelMap map = new ModelMap("sessionOut", "1");
				ModelAndView modelAndView = new ModelAndView("forward:/login/sessionout.do", map);
				throw new ModelAndViewDefiningException(modelAndView);
			}
			
		}

		response.addHeader("METHOD_ID", StringUtils.NULL(request.getHeader(Constants.METHOD_ID)));
		return super.preHandle(request, response, handler);
	}
}
