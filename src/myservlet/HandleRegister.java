package myservlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybean.Register;
import mybean.Salary;

/**
 * Servlet implementation class HandleRegister
 */
@WebServlet("/HandleRegister")
public class HandleRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleRegister() {
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
		System.out.println("进入注册界面");
		//设置编码方式
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		int flag = 0;	//输入是否符合要求
		String backNews = "";
		//request操作
		Register reg = new Register();
		request.setAttribute("register", reg);
		String username = request.getParameter("username").trim();
		String password = request.getParameter("password").trim();
		String confirmPassword = request.getParameter("confirmPassword").trim();		
		String realname = request.getParameter("realname").trim();
		String sex = request.getParameter("sex").trim();
		String phone = request.getParameter("phone").trim();
		if(username==null)	username="";
		if(password==null)	password="";
		if(realname==null)	realname="";
		if(sex==null)	sex="";
		if(phone==null)	phone="";
		System.out.println("username:"+username+" password:"+password+" realname:"+realname);
		
		
		
		//数据库对象声明
		Connection con;
		Statement sql;
		//判断用户名格式正确与否
		if(flag == 0) {
			if(username.length()>=6&&username.length()<=12) {
				for(int i=0;i<username.length();i++) {
					char c = username.charAt(i);
					if(!((c<='z'&&c>='a')||(c<='Z'&&c>='A')||(c<='9'&&c>='0'))) {
						flag = 1;	//用户名格式不正确
						break;
					}
				}
			}
			else flag = 1;
		}
		//判断密码格式正确与否
		if(flag == 0) {
			if(password.length()>=6&&password.length()<=12) {
				for(int i=0;i<password.length();i++) {
					char c = password.charAt(i);
					if(!((c<='z'&&c>='a')||(c<='Z'&&c>='A')||(c<='9'&&c>='0'))) {
						flag = 3;	//密码格式不正确
						break;
					}
				}
			}
			else flag = 3;
		}
		//判断密码是否一致
		if(flag==0&&!password.equals(confirmPassword))	flag=4;
		
		//判断手机格式是否正确
		if(flag == 0) {
			if(phone.length()==11) {
				for(int i=0;i<phone.length();i++) {
					char c = phone.charAt(i);
					if(!(c<='9'&&c>='0')) {
						flag = 5;	//手机号码格式不正确
						break;
					}
				}
			}
			else flag = 5;
		}
		//姓名是否为空
		if(flag==0&&realname.length()==0)	flag = 6;
		
		//数据库操作
		try {
			String insertRecord = "INSERT INTO register VALUES ('"+username+"','"+password+"','"+realname+"','"+sex+"','"+phone+"')";
			con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
			sql = con.createStatement();
			if(flag==0) {
				int m = sql.executeUpdate(insertRecord);
				if(m!=0) {
					backNews="注册成功";
					reg.setBackNews(backNews);
					reg.setUsername(username);
					reg.setPassword(password);
					reg.setRealname(realname);
					reg.setSex(sex);
					reg.setPhone(phone);
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	//设置日期格式
					reg.setDate(df.format(new Date()));
				}
				else {
					 backNews="注册失败";
					 reg.setBackNews(backNews);
				}
				con.close();
			}
		}
		catch(SQLException exp) {
			flag = 2;
		}
		
		switch(flag) {
		case 1:	backNews="用户名格式不正确";break;
		case 2:	backNews="用户名已被注册，请更换用户名";break;
		case 3:	backNews="密码格式不正确";break;
		case 4:	backNews="密码不一致";break;
		case 5:	backNews="手机号码格式不正确";break;
		case 6:	backNews="姓名不能为空";break;
		}
		reg.setBackNews(backNews);
		System.out.println(backNews);
		response.getWriter().print(backNews);
		/*
		//转发
		if(flag==0) {
			RequestDispatcher dispatcher= request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		}
		else {
			RequestDispatcher dispatcher= request.getRequestDispatcher("register.jsp");
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
