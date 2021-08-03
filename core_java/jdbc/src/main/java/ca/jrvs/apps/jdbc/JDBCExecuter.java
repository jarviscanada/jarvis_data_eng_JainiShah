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
      CustomerDAO customerDAO = new CustomerDAO(connection);
      customerDAO.findAllSorted(20).forEach(System.out::println);
      System.out.println("Paged");
      for(int i=1;i<3;i++){
        System.out.println("Page number: " + i);
        customerDAO.findAllPaged(10, i).forEach(System.out::println);
      }
    } catch (SQLException e){
        jdbcExecuter.logger.error(e.getMessage(), e);

    }
  }
}
