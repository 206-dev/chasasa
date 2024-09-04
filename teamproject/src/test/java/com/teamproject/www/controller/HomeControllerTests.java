package com.teamproject.www.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
						"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@WebAppConfiguration // text for Controller
@Log4j
public class HomeControllerTests {
private MockMvc mockMvc; // Client
	
	@Autowired
	private WebApplicationContext ctx; // View
	
	@Before
	public void setup() {
		log.info("setup...");
		mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	// 회원가입
	@Test
	public void testJoinRun() throws Exception{
		log.info(mockMvc.perform(MockMvcRequestBuilders.post("/joinrun")
				.param("u_id", "test10")
				.param("u_pw", "1234")
				.param("u_nickname", "test-10")
				.param("u_email", "test10@email.com"))
				.andReturn()
				.getModelAndView());
	}
	
}
