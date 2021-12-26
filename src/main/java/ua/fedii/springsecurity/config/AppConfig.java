package ua.fedii.springsecurity.config;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import javax.sql.DataSource;
import java.beans.PropertyVetoException;
import java.util.logging.Logger;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "ua.fedii.springsecurity")
@PropertySource("classpath:persistence-postgresql.properties")
public class AppConfig {
  @Autowired private Environment environment;

  private Logger logger = Logger.getLogger(getClass().getName());

  @Bean
  public ViewResolver viewResolver() {
    InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();

    viewResolver.setPrefix("/WEB-INF/view/");
    viewResolver.setSuffix(".jsp");

    return viewResolver;
  }

  @Bean
  public DataSource securityDataSource() {
    ComboPooledDataSource comboPooledDataSource = new ComboPooledDataSource();

    try {
      comboPooledDataSource.setDriverClass(environment.getProperty("jdbc.driver"));
    } catch (PropertyVetoException e) {
      throw new RuntimeException(e);
    }

    logger.info(">>> jdbc.url = " + environment.getProperty("jdbc.url"));
    logger.info(">>> jdbc.user = " + environment.getProperty("jdbc.user"));

    comboPooledDataSource.setJdbcUrl(environment.getProperty("jdbc.url"));
    comboPooledDataSource.setUser(environment.getProperty("jdbc.user"));
    comboPooledDataSource.setPassword(environment.getProperty("jdbc.password"));

    comboPooledDataSource.setInitialPoolSize(getIntProperty("connection.pool.initialPoolSize"));
    comboPooledDataSource.setMinPoolSize(getIntProperty("connection.pool.minPoolSize"));
    comboPooledDataSource.setMaxPoolSize(getIntProperty("connection.pool.maxPoolSize"));
    comboPooledDataSource.setMaxIdleTime(getIntProperty("connection.pool.maxIdleTime"));

    return comboPooledDataSource;
  }

  private int getIntProperty(String propName) {
    String propValue = environment.getProperty(propName);

    assert propValue != null;
    return Integer.parseInt(propValue);
  }
}
