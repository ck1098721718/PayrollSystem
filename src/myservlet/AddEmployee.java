package myservlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

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
import net.sf.json.JSONObject;

/**
 * Servlet implementation class AddEmployee
 */
@WebServlet("/AddEmployee")
public class AddEmployee extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddEmployee() {
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
			Employee employee = new Employee();
			request.setAttribute("employee", employee);
			String department = request.getParameter("department").trim();
			String id = request.getParameter("id").trim();
			String name = request.getParameter("name").trim();
			String phone = request.getParameter("phone").trim();
			String sex = request.getParameter("sex").trim();
			String remark = ((Login)request.getSession().getAttribute("login")).getUsername();
			if(id==null)	id="";
			if(phone==null)	phone="";
			if(name==null)	name="";
			//数据库对象声明
			Connection con;
			Statement sql;
			String backNews = "";
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
			
			
			
			//获取系统时间
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");	//设置日期格式
			String time = df.format(new Date());
			//数据库操作
			try {
				String insertRecord = "INSERT INTO employee VALUES ('"+department+"','"+id+"','"+name+"','"+phone+"','"+sex+"','"+time+"','"+remark+"')";
				con = DriverManager.getConnection(Salary.url,Salary.username,Salary.password);
				sql = con.createStatement();
				if(flag==0) {
					int m = sql.executeUpdate(insertRecord);
					if(m!=0) {
						backNews="添加成功";
						employee.setDepartment(department);
						employee.setId(id);
						employee.setName(name);
						employee.setPhone(phone);
						employee.setSex(sex);
						employee.setTime(time);
						employee.setRemark(remark);
						((ArrayList)request.getSession().getAttribute("allemployee")).add(employee);
						insertRecord = "INSERT INTO 固定项目(id,name,department) VALUES ('"+id+"','"+name+"','"+department+"')";
						sql.executeUpdate(insertRecord);
						insertRecord = "INSERT INTO 计算项目(id,name,department) VALUES ('"+id+"','"+name+"','"+department+"')";
						sql.executeUpdate(insertRecord);
					}
					else {
						 backNews="添加失败";
						 employee.setBackNews(backNews);
					}
					sql.close();
					con.close();
				}
			}
			catch(SQLException exp) {
				flag = 2;
			}
			
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
			RequestDispatcher dispatcher= request.getRequestDispatcher("employeeManage.jsp");
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
