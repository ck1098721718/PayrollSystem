package myservlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybean.Attendance;
import mybean.Login;
import mybean.Salary;

/**
 * Servlet implementation class DeleteAttendance
 */
@WebServlet("/DeleteAttendance")
public class DeleteAttendance extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteAttendance() {
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
		if(request.getSession(true).getAttribute("login")==null) {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().print("未登录");
		}
		else {
			//设置编码方式
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			//request操作
			String id = request.getParameter("id");
			String event = request.getParameter("event");
			String date = request.getParameter("date");
			Iterator<Attendance> iter = ((ArrayList)request.getSession().getAttribute("allattendance")).iterator();
			while(iter.hasNext()) {
				Attendance e = iter.next();
				if(e.getId().equals(id)&&e.getEvent().equals(event)&&e.getDate().equals(date)) {
					iter.remove();
				}
			}
			//数据库操作
			Connection con;
			Statement sql;
			try {
				con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
				sql = con.createStatement();
				String deleteRecord = "DELETE FROM attendance WHERE id='"+id+"' AND event='"+event+"' And date='"+date+"'";
				sql.executeUpdate(deleteRecord);
				sql.close();
				con.close();
			}
			catch(SQLException e) {
				e.printStackTrace();
			}
			/*
			//转发
			RequestDispatcher dispatcher= request.getRequestDispatcher("attendanceManage.jsp");
			dispatcher.forward(request, response);
			*/
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
