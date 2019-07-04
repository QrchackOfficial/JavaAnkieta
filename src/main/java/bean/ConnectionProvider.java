package bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import static bean.Provider.*;

public class ConnectionProvider {
    private static Connection con = null;

    static  {
        try {
            Class.forName(DRIVER).newInstance();
            con = DriverManager.getConnection(CONNECTION_URL, USERNAME, PASSWORD);
        } catch (SQLException e) {
            System.out.println("Failed to connect: " + e.getMessage());
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        }
    }

    public static Connection getCon() {
        return con;
    }
}
