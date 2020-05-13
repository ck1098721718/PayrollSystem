package myservlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybean.Employee;
import mybean.Login;
import mybean.Salary;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class UpdateEmployee
 */
@WebServlet("/UpdateEmployee")
public class UpdateEmployee extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateEmployee() {
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
			String department = request.getParameter("department").trim();
			String id = request.getParameter("id").trim();
			String name = request.getParameter("name").trim();
			String phone = request.getParameter("phone").trim();
			String sex = request.getParameter("sex").trim();
			String oldId = request.getParameter("oldId");
			//String time = request.getParameter("time").trim();
			String remark = ((Login)request.getSession().getAttribute("login")).getUsername();
			Employee employee = new Employee();
			//request.setAttribute("employee", employee);
			employee.setDepartment(department);
	        employee.setId(id);
	        employee.setName(name);
	        employee.setPhone(phone);
	        employee.setSex(sex);
	        employee.setOldId(oldId);
	        //employee.setTime(time);
			employee.setRemark(remark);

			int flag = 0;
			
			//判断name3
			if(flag==0&&name.length()==0)	flag = 3;
			//判断phone4
			if(flag == 0) {
				if(phone.length()==11) {
					for(int i=0;i<phone.length();i++) {
						char c = phone.charAt(i);
						if(!(c<='9'&&c>='0')) {
							flag = 4;	//手机号码格式不正确
							break;
						}
					}
				}
				else flag = 4;
			}
			
			//编号格式 5
			int idNum = 0;
			if(flag==0) {
				try {
					idNum = Integer.parseInt(id);
					if(idNum>=8000||idNum<=1000) {
						flag = 5;
					}
				}
				catch(Exception e){
					flag = 5;
				}
			}
			
			//判断部门与编号是否对应 1
			if(flag==0) {
				if(idNum/1000==1&&!department.equals("人力资源部"))	flag = 1;
				if(idNum/1000==2&&!department.equals("财务部"))	flag = 1;
				if(idNum/1000==3&&!department.equals("生产技术部"))	flag = 1;
				if(idNum/1000==4&&!department.equals("计划营销部"))	flag = 1;
				if(idNum/1000==5&&!department.equals("安全监察部"))	flag = 1;
				if(idNum/1000==6&&!department.equals("宣传部"))	flag = 1;
				if(idNum/1000==7&&!department.equals("后勤部"))	flag = 1;
			}
			
			//数据库操作
			Connection con;
			Statement sql;
			try {
				con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
				sql = con.createStatement();
				if(flag==0) {
					String updateRecord = "UPDATE employee SET id='"+id+"',department='"+department+"',name='"+name+"',phone='"+phone+"',sex='"+sex+"',remark='"+remark+"'WHERE id='"+oldId+"'";
					sql.executeUpdate(updateRecord);
					updateRecord = "UPDATE attendance SET id='"+id+"',department='"+department+"',name='"+name+"'WHERE id='"+oldId+"'";
					sql.executeUpdate(updateRecord);
					updateRecord = "UPDATE 固定项目 SET id='"+id+"',department='"+department+"',name='"+name+"'WHERE id='"+oldId+"'";
					sql.executeUpdate(updateRecord);
					updateRecord = "UPDATE 计算项目 SET id='"+id+"',department='"+department+"',name='"+name+"'WHERE id='"+oldId+"'";
					sql.executeUpdate(updateRecord);
					
			        List<Employee> allemployee = (ArrayList)request.getSession().getAttribute("allemployee");
			        for(Employee e:allemployee) {
			        	if(e.getId().equals(oldId)) {
			        		e.setId(id);
			        		e.setDepartment(department);
					        e.setName(name);
					        e.setPhone(phone);
					        e.setSex(sex);
					        //e.setTime(time);
			        	}
			        }
			        request.getSession().setAttribute("allemployee", allemployee);
				}
				sql.close();
				con.close();
			}
			catch(SQLException e) {
				e.printStackTrace();
				flag = 2;
			}
			String backNews="修改员工数据成功";
			switch(flag) {
			case 1: backNews="编号与部门不对应";break;
			case 2: backNews="编号已存在";break;
			case 3: backNews="姓名不正确";break;
			case 4: backNews="手机号码格式不正确";break;
			case 5: backNews="编号格式不正确";break;
			}
			employee.setBackNews(backNews);
			response.getWriter().print(JSONObject.fromObject(employee));
			/*
			//转发
			if(flag==0) {
				RequestDispatcher dispatcher= request.getRequestDispatcher("employeeManage.jsp");
				dispatcher.forward(request, response);
			}
			else {
				RequestDispatcher dispatcher= request.getRequestDispatcher("update.jsp");
				dispatcher.forward(request, response);
			}
			*/
		}
		
	}

}
