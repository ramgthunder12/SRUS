package kr.co.srus;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = { "kr.co.srus" })
@MapperScan(basePackages = "kr.co.srus")
public class SrusApplication {

	public static void main(String[] args) {
		SpringApplication.run(SrusApplication.class, args);
	}
}
