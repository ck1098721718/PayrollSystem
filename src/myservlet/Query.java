package myservlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mybean.Attendance;
import mybean.Employee;
import mybean.Salary;
import net.sf.json.JSONArray;

/**
 * Servlet implementation class QueryEmployee
 */
@WebServlet("/Query")
public class Query extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Query() {
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
		//检查是否登陆
		/*
		String url = request.getHeader("Origin");
		response.setHeader("Access-Control-Allow-Origin", url);
		response.addHeader("Access-Control-Allow-Credentials", "true");
		*/
		
		if(request.getSession(true).getAttribute("login")==null) {
			//设置编码方式
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().print("未登录");
		}
		else {
			//查询员工的方式
			String way = request.getParameter("way");
			String method = request.getParameter("method");
			// TODO Auto-generated method stub
			//设置编码方式
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			//request操作
			HttpSession session=request.getSession(true); 
			List <Employee> allemployee = null;
			List <Attendance> allattendance = null;
			if(method.equals("employee")) {
				allemployee = new ArrayList<Employee>();
				session.setAttribute("allemployee", allemployee);
			}
			else {
				allattendance = new ArrayList<Attendance>();
				session.setAttribute("allattendance", allattendance);
			}
			
			
			//数据库对象声明
			Connection con;
			Statement sql,sql2,sql3;
			try {
				con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
				sql = con.createStatement();
				sql2 = con.createStatement();
				sql3 = con.createStatement();
				String selectRecord = "SELECT * FROM "+method;
				if(way.equals("department")) {
					String department = request.getParameter("department");
					if(!department.equals("全部"))
					selectRecord = "SELECT * FROM "+method+" WHERE department ='"+department+"'";
				}
				else if(way.equals("id")) {
					String id = request.getParameter("id");
					selectRecord = "SELECT * FROM "+method+" WHERE id ='"+id+"'";
				}
				else if(way.equals("date")) {
					String date = request.getParameter("date");
					selectRecord = "SELECT * FROM "+method+" WHERE date ='"+date+"'";
				}
				ResultSet rs = sql.executeQuery(selectRecord);
				ResultSet rs2;
				// 展开结果集数据库
				if(method.equals("employee")) {
					while(rs.next()){
		                // 通过字段检索
		                String department  = rs.getString("department");
		                String id = rs.getString("id");
		                String name = rs.getString("name");
		                String phone = rs.getString("phone");
		                String sex = rs.getString("sex");
		                String time = rs.getString("time");
		                allemployee.add(new Employee(department,id,name,phone,sex,time));
		                try {
		                	String Record = "SELECT * FROM 固定项目 WHERE department='"+department+"'AND id='"+id+"'AND name='"+name+"'";
		                	rs2 = sql2.executeQuery(Record);
		                	if(!rs2.next()) {
		                		String insertRecord = "INSERT INTO 固定项目(department,id,name) VALUES('"+department+"','"+id+"','"+name+"')";
		                		sql3.executeUpdate(insertRecord);
		                	}
		                	Record = "SELECT * FROM 计算项目 WHERE department='"+department+"'AND id='"+id+"'AND name='"+name+"'";
		                	rs2 = sql2.executeQuery(Record);
		                	if(!rs2.next()) {
		                		String insertRecord = "INSERT INTO 计算项目(department,id,name) VALUES('"+department+"','"+id+"','"+name+"')";
		                		sql3.executeUpdate(insertRecord);
		                	}
		                }
		                catch(SQLException e) {
		    				e.printStackTrace();
		    			}
		            }
				}
				else {
					while(rs.next()){
		                // 通过字段检索
		                String department  = rs.getString("department");
		                String id = rs.getString("id");
		                String name = rs.getString("name");
		                String date = rs.getString("date");
		                String event = rs.getString("event");
		                String remark = rs.getString("remark");
		                allattendance.add(new Attendance(department,id,name,date,event,remark));
		            }
				}
				sql.close();
				con.close();
			}
			catch(SQLException e) {
				e.printStackTrace();
			}
			if(method.equals("employee")) {
				JSONArray jsonArray = JSONArray.fromObject(allemployee);
	            response.getWriter().println(jsonArray);
			}
			else {
				Collections.sort(allattendance, new Comparator<Attendance>() {

					@Override
					public int compare(Attendance o1, Attendance o2) {
						// TODO Auto-generated method stub
						String [] date1 = o1.getDate().split("-");
						String [] date2 = o2.getDate().split("-");
						int first = Integer.parseInt(date1[0])*365+Integer.parseInt(date1[1])*30+Integer.parseInt(date1[2]);
						int second = Integer.parseInt(date2[0])*365+Integer.parseInt(date2[1])*30+Integer.parseInt(date2[2]);
						if(first>second)	return -1;
						else if(first<second)	return 1;
						else return 0;
					}
					
				});
				JSONArray jsonArray = JSONArray.fromObject(allattendance);
	            response.getWriter().println(jsonArray);
			}
			/*
			//转发
			if(method.equals("employee")) {
				RequestDispatcher dispatcher= request.getRequestDispatcher("employeeManage.jsp");
				dispatcher.forward(request, response);
			}
			else {
				RequestDispatcher dispatcher= request.getRequestDispatcher("attendanceManage.jsp");
				dispatcher.forward(request, response);
			}
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
