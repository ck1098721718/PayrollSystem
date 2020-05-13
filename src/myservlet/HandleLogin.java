package myservlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mybean.Login;
import mybean.Salary;

/**
 * Servlet implementation class HandleLogin
 */
@WebServlet("/HandleLogin")
public class HandleLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleLogin() {
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
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//设置编码方式
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		//request操作
		Login login = new Login();
		HttpSession session=request.getSession(true); 
		session.setAttribute("login", login);

		String username = request.getParameter("username").trim();
		String password = request.getParameter("password").trim();
		if(username==null)	username="";
		if(password==null)	password="";
		//数据库对象声明
		Connection con;
		Statement sql;
		String backNews = "";
		int flag = 0;
		if(username.length()==0)	flag=1;
		else if(password.length()==0)	flag=2;
		if(flag==0) {
			try {
				con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
				sql = con.createStatement();
				String selectRecord = "SELECT * FROM register WHERE username='"+username+"' AND password='"+password+"'";
				ResultSet rs = sql.executeQuery(selectRecord);
				if(!rs.next())	flag=3;
				con.close();
			}
			catch(SQLException e) {
				flag = 3;
			}
		}
		switch(flag) {
		case 0 :	backNews="登录成功";break;
		case 1 :	backNews="用户名为空";break;
		case 2 :	backNews="密码为空";break;
		case 3 :	backNews="用户名不存在或密码不正确";break;
		}
		
		login.setBackNews(backNews);
		login.setUsername(username);
		login.setPassword(password);
		response.getWriter().print(backNews);
		/*
		if(flag!=0) {
			//session.setAttribute("login",null);
			RequestDispatcher dispatcher= request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		}
		else {
			//转发
			RequestDispatcher dispatcher= request.getRequestDispatcher("main.jsp");
			dispatcher.forward(request, response);
		}
		*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
