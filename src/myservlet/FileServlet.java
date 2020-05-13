package myservlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.catalina.core.ApplicationPart;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

import mybean.Image;
import mybean.Salary;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class FileServlet
 */
@WebServlet("/FileServlet")
@MultipartConfig(location="G://temp")
public class FileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
		try {
			Class.forName(Salary.forName);
		}
		catch(Exception e) {
			
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		//String path = this.getServletContext().getRealPath("/");
		System.out.println(request.getParameter("name")+"666");
		Part p = request.getPart("file1");
		System.out.println(p.getContentType()+"1");
		if(p.getContentType().contains("image")) {
			ApplicationPart ap = (ApplicationPart) p;
			String fname1 = ap.getSubmittedFileName();
			System.out.println(fname1+"2");
			//p.write("G:\\1.png");
			Connection con;
			PreparedStatement ps = null;
			InputStream in = p.getInputStream();
			//数据库操作
			try {
				con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
				String insertRecord = "insert into ttt (name,image)values(?,?)";
				ps = con.prepareStatement(insertRecord);
				ps.setString(1, "test");
				ps.setBinaryStream(2, in, in.available());
				ps.executeUpdate();
			}
			catch(SQLException exp) {
				exp.printStackTrace();
			}
			InputStream image = null;
			try {
				con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
				String queryRecord = "select image from ttt where name='test'";
				Statement sql = con.createStatement();
				ResultSet rs = sql.executeQuery(queryRecord);
				while(rs.next()) {
					image = rs.getBinaryStream("image");
					/*
					File file = new File("G:\\temp\\test.jpg");
			        FileOutputStream fos = null;
			        try {
			            fos = new FileOutputStream(file);
			            int len = 0;
			            byte[] buf = new byte[1024];
			            while ((len = image.read(buf)) != -1) {
			                fos.write(buf, 0, len);
			            }
			            fos.flush();
			        } catch (Exception e) {
			            e.printStackTrace();
			        } finally {
			            if (null != fos) {
			                try {
			                    fos.close();
			                } catch (IOException e) {
			                    e.printStackTrace();
			                }
			            }
			        }
			    	*/
					//System.out.println(image);
					
				}
				Image i = new Image();
				
				byte[] t = new byte[2048];
				
				image.read(t);
				
				String encodeBase64 = Base64.encode(t);
				System.out.println("RESULT: " + new String(encodeBase64));
				
				for(int j=0;j<t.length;j++) {
					System.out.print(t[j]);
				}
				System.out.println();
				i.setImage(encodeBase64);
				response.getWriter().print(JSONObject.fromObject(i));
			}
			catch(SQLException exp) {
				exp.printStackTrace();
			}
			
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
