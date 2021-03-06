package net.carting.util;

import org.apache.commons.dbcp.DriverManagerConnectionFactory;
import org.apache.commons.dbcp.PoolableConnectionFactory;
import org.apache.commons.dbcp.PoolingDataSource;
import org.apache.commons.pool.impl.GenericObjectPool;

import javax.sql.DataSource;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

public class ConnectionFactory {

    private static interface Singleton {
        final ConnectionFactory INSTANCE = new ConnectionFactory();
    }

    private final DataSource dataSource;

    private ConnectionFactory() {
        Properties prop = new Properties();
        InputStream inputStream = getClass().getClassLoader().getResourceAsStream("jdbc.properties");
        
        try {
            prop.load(inputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String username = prop.getProperty("jdbc.username");
        String password = prop.getProperty("jdbc.password");
        String url = prop.getProperty("jdbc.databaseurl");
        String driver = prop.getProperty("jdbc.driverClassName");
        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.exit(0);
        }

        GenericObjectPool pool = new GenericObjectPool();
        DriverManagerConnectionFactory connectionFactory = new DriverManagerConnectionFactory(
                url, username, password
        );
        new PoolableConnectionFactory(connectionFactory, pool, null, "SELECT 1", 3, false, false, Connection.TRANSACTION_READ_COMMITTED);
        this.dataSource = new PoolingDataSource(pool);
    }

    public static Connection getDatabaseConnection() throws SQLException {
        return Singleton.INSTANCE.dataSource.getConnection();
    }
}
