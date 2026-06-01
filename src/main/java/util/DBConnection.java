package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() {
        Connection con = null;
        try {
            // 9.x වලදී Class.forName නැතත් වැඩ කරනවා, නමුත් ගැටලුවක් නැත
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // වැදගත්ම දේ: URL එකේ සෙටින්ග්ස්
            String url = "jdbc:mysql://localhost:3306/ati_badulla_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
            con = DriverManager.getConnection(url, "root", "");
            
        } catch (Exception e) {
            // දෝෂය පැහැදිලිව දැනගන්න මෙහෙම දාන්න
            System.err.println("DATABASE ERROR: " + e.getMessage());
            e.printStackTrace();
        }
        return con;
    }
}