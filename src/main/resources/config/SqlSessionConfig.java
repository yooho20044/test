package config;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionConfig {

	private static SqlSession session;
	
	public static SqlSession getSqlSession() {
		try {
			String resource = "/mybatis-config.xml";
			InputStream stream = Resources.getResourceAsStream(resource);
			
			SqlSessionFactoryBuilder builder= new SqlSessionFactoryBuilder();
			SqlSessionFactory factory = builder.build(stream);
			session = factory.openSession(true);
		}catch(Exception e) {
			e.printStackTrace();
		}return session;
	}
}
