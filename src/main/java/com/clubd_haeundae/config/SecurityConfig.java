package com.clubd_haeundae.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.clubd_haeundae.security.AdminUserDetailsService;
import com.clubd_haeundae.security.CustomAuthenticationProvider;
import com.clubd_haeundae.security.MyAuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private AdminUserDetailsService adminUserDetailsService;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean(name = "customAuthenticationProvider")
    public CustomAuthenticationProvider customAuthenticationProvider(AdminUserDetailsService adminUserDetailsService, PasswordEncoder passwordEncoder) {
        return new CustomAuthenticationProvider(adminUserDetailsService, passwordEncoder);
    }
    
    @Bean
    public AuthenticationSuccessHandler successHandler() {
        return new MyAuthenticationSuccessHandler("/admin/main");
    }
    
//    @Bean
//    public MyAuthenticationSuccessHandler myAuthenticationSuccessHandler(){
//        return new MyAuthenticationSuccessHandler();
//    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(customAuthenticationProvider(adminUserDetailsService, passwordEncoder()));
//        auth
//                .userDetailsService(adminUserDetailService)
//                .passwordEncoder(passwordEncoder());
    }

    protected void configure(HttpSecurity http) throws Exception {
        http
                .headers().frameOptions().sameOrigin()
                .and()
                .authorizeRequests()
                .antMatchers("/css/**").permitAll()
                .antMatchers("/img/**").permitAll()
                .antMatchers("/image/**").permitAll()
                .antMatchers("/fonts/**").permitAll()
                .antMatchers("/js/**").permitAll()
                .antMatchers("/grape/**").permitAll()
                .antMatchers("/login").permitAll()
                .antMatchers("/api/**").permitAll()
                .antMatchers("/download/**").permitAll()
                .antMatchers("/store/**").permitAll()
                .antMatchers("/admin/**").hasAnyRole("AAA000","AAA001")
                .antMatchers("/**").permitAll()
                .and()
                .formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/checkLogin")
                .usernameParameter("userId")
                .passwordParameter("password")
                .successHandler(successHandler())
                .failureUrl("/login?error")
                .and()
                .rememberMe()
                .key("yasset")
                .rememberMeParameter("remember_me")
                .tokenValiditySeconds(86400 * 30)		// 1달유지 (24시간 * 30일)  
                .userDetailsService(adminUserDetailsService)
                .authenticationSuccessHandler(successHandler())
                .and()
                .logout()
                .logoutUrl("/logout")
                .logoutSuccessUrl("/succ-logout")
                .deleteCookies("JSESSIONID")
                .invalidateHttpSession(true)
                .permitAll()
                .and()
                .csrf().disable();
                
        
    }
}
