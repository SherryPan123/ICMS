package com.database.icms.configuration;

import javax.servlet.Filter;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class AppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class[] { AppConfig.class, SpringSecurityConfig.class };
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return null;
	}

	//DispatcherServlet的映射路径
	@Override
	protected String[] getServletMappings() {
		return new String[] { "/" };
	}
	
	@Override 
	protected Filter[] getServletFilters() { 
		CharacterEncodingFilter charFilter = new CharacterEncodingFilter(); 
		charFilter.setEncoding("UTF-8"); 
		charFilter.setForceEncoding(true); 
		return new Filter[] { charFilter }; 
	}

}
