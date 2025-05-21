package KetNoiModal;
import java.sql.Connection;
import java.sql.DriverManager;

public class KetNoi {
	public Connection cn;
	public void KetNoi() throws Exception{
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		String url = "jdbc:sqlserver://DESKTOP-J4VRV6K:1433; databaseName=MiniSocialNetwork ; user=sa; password=12345; encrypt=true; trustServerCertificate=true"; 
		cn = DriverManager.getConnection(url);
	}
}
