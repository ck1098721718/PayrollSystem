package myservlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybean.Attendance;
import mybean.Attendance;
import mybean.Login;
import mybean.Salary;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class UpdateAttendance
 */
@WebServlet("/UpdateAttendance")
public class UpdateAttendance extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateAttendance() {
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
		doPost(request,response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//检查是否登陆
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
			String department = request.getParameter("department");
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String date = request.getParameter("date");
			String event = request.getParameter("event");
			String remark = ((Login)request.getSession().getAttribute("login")).getUsername();
			String oldDate=request.getParameter("oldDate");
			String oldEvent=request.getParameter("oldEvent");
			Attendance attendance = new Attendance();
			request.setAttribute("attendance", attendance);
			attendance.setDepartment(department);
	        attendance.setId(id);
	        attendance.setName(name);
	        attendance.setDate(date);
	        attendance.setEvent(event);
			attendance.setRemark(remark);
			attendance.setOldDate(oldDate);
			attendance.setOldEvent(oldEvent);
			int flag = 0;
			int year1 = 0,month1 = 0,day1 = 0;
			//判断event2
			
			if(!(event.equals("病假")||event.equals("事假")||event.equals("迟到")||event.equals("早退")||event.equals("旷工"))&&flag==0) {
				flag = 2;
			}
			
			//判断日期 3
			if(flag==0) {
				String[] date1 = date.split("-");
				
				if(date1.length==3) {
					try {
						year1 = Integer.parseInt(date1[0]);
						month1 = Integer.parseInt(date1[1]);
						day1 = Integer.parseInt(date1[2]);
					}
					catch(Exception e){
						flag = 3;
					}
					if(month1==1||month1==3||month1==5||month1==7||month1==8||month1==10||month1==12) {
						if(day1>31) flag=3;
					}
					else if(month1!=2) {
						if(day1>30) flag=3;
					}
					else {
						if (year1%400==0 || (year1%4==0 && year1%100!=0)) {
							if(day1>29) flag=3;
						}
						else if(day1>28) flag=3;
					}
				}
				else flag=3;
				if(flag==0) {
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");	//设置日期格式
					String time = df.format(new Date());
					String[] date2 = time.split("-");
					int year2 = Integer.parseInt(date2[0]);
					int month2 = Integer.parseInt(date2[1]);
					int day2 = Integer.parseInt(date2[2]);
					if(year2-year1>10) flag=3;
					else if(year2-year1==10) {
						if(month2>month1) flag=3;
						else if(month2==month1&&day2>day1) flag=3;
					}
					
				}
			}
			
			//数据库操作
			Connection con;
			Statement sql;
			try {
				//查询是否存在该员工 1
				con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
				sql = con.createStatement();
				String selectRecord = "SELECT * FROM employee WHERE department ='"+department+"' And id='"+id+"' AND name='"+name+"'";
				ResultSet rs = sql.executeQuery(selectRecord);
				if(!rs.next()) flag = 1;
				else {
					String []time = rs.getString("time").split("-");
					int year2 = Integer.parseInt(time[0]);
					int month2 = Integer.parseInt(time[1]);
					int day2 = Integer.parseInt(time[2]);
					if((year1*360+month1*30+day1)<(year2*360+month2*30+day2)) {
						flag = 3;
					}
				}
				if(flag==0) {
					String updateRecord = "UPDATE attendance SET department='"+department+"',name='"+name+"',event='"+event+"',date='"+date+"',remark='"+remark+"'WHERE id='"+id+"' AND date='"+oldDate+"' AND event='"+oldEvent+"'";
					sql.executeUpdate(updateRecord);
					
					
			        List<Attendance> allattendance = (ArrayList)request.getSession().getAttribute("allattendance");
			        for(Attendance e:allattendance) {
			        	if(e.getId().equals(id)&&e.getDate().equals(oldDate)&&e.getEvent().equals(oldEvent)) {
			        		e.setDepartment(department);
					        e.setName(name);
					        e.setDate(date);
					        e.setEvent(event);
					        e.setRemark(remark);
			        	}
			        }
			        request.getSession().setAttribute("allattendance", allattendance);
				}
				sql.close();
				con.close();
			}
			catch(SQLException e) {
				e.printStackTrace();
				flag = 4;
			}
			String backNews="修改考勤数据成功";
			switch(flag) {
			case 1: backNews="不存在该员工";break;
			case 2: backNews="事件不正确";break;
			case 3: backNews="日期不正确";break;
			case 4: backNews="修改失败";break;
			}
			attendance.setBackNews(backNews);
			response.getWriter().print(JSONObject.fromObject(attendance));
			/*
			//转发
			if(flag==0) {
				RequestDispatcher dispatcher= request.getRequestDispatcher("attendanceManage.jsp");
				dispatcher.forward(request, response);
			}
			else {
				RequestDispatcher dispatcher= request.getRequestDispatcher("updateAttendance.jsp");
				dispatcher.forward(request, response);
			}
			*/
		}
		
	}

}
