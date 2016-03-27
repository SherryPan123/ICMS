package com.database.icms.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.header.writers.frameoptions.XFrameOptionsHeaderWriter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.validation.Errors;

@Configuration
@EnableWebSecurity
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
    private UserDetailsService userDetailsService;
	
    @Override
    protected void configure(HttpSecurity http) throws Exception {
    	http
            .headers()
                .addHeaderWriter(new XFrameOptionsHeaderWriter(XFrameOptionsHeaderWriter.XFrameOptionsMode.SAMEORIGIN))
                .and()
             //关闭csrf,否则必须使用Post方式请求/logout
//            .csrf()
//               .disable()
            .authorizeRequests()
                .antMatchers("/", "/css/**", "/js/**", "/images/**", "/fonts/**").permitAll()
                .antMatchers("/car/**").hasRole("USER")
                .and()
            .formLogin()
                .loginPage("/login")
                .usernameParameter("name")
                .defaultSuccessUrl("/")
                .permitAll()
                .and()
               //使用这种方法就要关闭csrf
//            .logout()
//            	.logoutUrl("/logout")
//				.logoutSuccessUrl("/login")
//				.deleteCookies("remove")
//				.invalidateHttpSession(false)
//				.and()
              // 如果要开启csrf ,这种配置方式也能成功登出， 为什么？
              .logout()
              		.deleteCookies("remember-me")
              		.permitAll()
              		.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
              		.logoutSuccessUrl("/login")
              		.and()
              	.rememberMe();
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
//        auth
//                .userDetailsService(userDetailsService)
//                .passwordEncoder(new BCryptPasswordEncoder());
    	//这是我暂时用来测试登出的代码 
    	auth
         .inMemoryAuthentication()
              .withUser("user")
                   .password("password")
                   .roles("USER");
    }
}