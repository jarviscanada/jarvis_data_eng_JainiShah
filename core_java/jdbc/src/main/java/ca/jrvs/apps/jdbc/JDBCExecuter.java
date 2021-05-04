package ca.jrvs.apps.jdbc;

import com.sun.org.slf4j.internal.Logger;
import com.sun.org.slf4j.internal.LoggerFactory;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCExecuter {
  final Logger logger = LoggerFactory.getLogger(JDBCExecuter.class);
  public static void main(String[] args) {
    JDBCExecuter jdbcExecuter = new JDBCExecuter();
    DatabaseConnectionManager dcm = new DatabaseConnectionManager("localhost", "hplussport", "postgres", "password");

    try{
      Connection connection = dcm.getConnection();
      Statement statement = connection.createStatement();
      ResultSet resultSet = statement.executeQuery("SELECT COUNT(*) FROM CUSTOMER");
      while(resultSet.next()){
        System.out.println(resultSet.getInt(1));
      }
    } catch (SQLException e){
        jdbcExecuter.logger.error(e.getMessage(), e);

    }
  }
}
