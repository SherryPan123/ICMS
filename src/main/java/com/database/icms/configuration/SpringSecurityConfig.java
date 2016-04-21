package com.database.icms.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.header.writers.frameoptions.XFrameOptionsHeaderWriter;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Autowired
    private UserDetailsService userDetailsService;
	
	@Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
    	http
            .headers()
                .addHeaderWriter(new XFrameOptionsHeaderWriter(XFrameOptionsHeaderWriter.XFrameOptionsMode.SAMEORIGIN))
                .and()
            .authorizeRequests()
            	.antMatchers("/company/*").hasAnyAuthority("admin")
            	.antMatchers("/car/*").hasAnyAuthority("company","admin")
            	.antMatchers("/conditions/*").hasAnyAuthority("company","admin")
            	.antMatchers("/employee/*").hasAnyAuthority("company","admin")
            	.antMatchers("/fare/*").hasAnyAuthority("company","admin")
            	.antMatchers("/accident/*").hasAnyAuthority("company","admin")
            	.antMatchers("/", "/css/**", "/js/**", "/fonts/**", "/images/**").permitAll()
                .and()
            .exceptionHandling().accessDeniedPage("/accessDeny")
                .and()
            .formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .successHandler(successHandler())
                .failureHandler(failureHandler())
                .permitAll()
                .and()
            .logout()
            	.logoutUrl("/logout")
            	.permitAll()
                .deleteCookies("remember-me")
                .and()
            .rememberMe();
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth
                .userDetailsService(userDetailsService)
                .passwordEncoder(new BCryptPasswordEncoder());
    }
    
    @Bean
    public AuthenticationSuccessHandler successHandler() {
        return new AjaxAuthenticationSuccessHandler();
    }

    @Bean
    public AuthenticationFailureHandler failureHandler() {
        return new AjaxAuthenticationFailureHandler();
    }

}
